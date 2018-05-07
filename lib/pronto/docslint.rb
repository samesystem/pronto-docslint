require 'pronto'
require 'shellwords'

module Pronto
  class Docslint < Runner
    CONFIG_FILE = '.pronto_docslint.yml'.freeze
    CONFIG_KEYS = %w[watched_file_extensions additions_treshold deletions_treshold]

    attr_reader :watched_file_extensions, :additions_treshold, :deletions_treshold

    def run
      return [] if no_patches? || documentation_exists?

      prepare_config
      meaningful_patches.map { |patch| new_message(patch) }.compact
    end

    private

    def no_patches?
      !@patches || @patches.count.zero?
    end

    def documentation_exists?
      @patches.any? { |patch| patch.delta.new_file[:path].match?(/\.md$/) }
    end

    def meaningful_patches
      @patches.select do |patch|
        modified = patch.additions > additions_treshold || patch.deletions > deletions_treshold
        modified && patch.delta.new_file[:path].match?(/^app\/.*\.(#{watched_file_extensions.join('|')})$/)
      end
    end

    def new_message(patch)
      path = patch.delta.new_file[:path]
      watched_extensions = watched_file_extensions.map { |ext| "\e[33m#{ext}\e[0m" }.join(',')
      offence = "Changes on #{watched_extensions} files requires documentation changes.."

      Message.new(path, OpenStruct.new, :warning, offence, nil, self.class)
    end

    def prepare_config
      read_config
      fill_empty_settings_with_default_values
    end

    def read_config
      config_file = File.join(git_repo_path, CONFIG_FILE)
      return unless File.exist?(config_file)

      config = YAML.load_file(config_file)

      CONFIG_KEYS.each do |config_key|
        next unless config[config_key]
        instance_variable_set("@#{config_key}", config[config_key])
      end
    end

    def fill_empty_settings_with_default_values
      @watched_file_extensions ||= %w[js rb]
      @additions_treshold ||= 1
      @deletions_treshold ||= 1
    end

    def git_repo_path
      @git_repo_path ||= Rugged::Repository.discover(File.expand_path(Dir.pwd)).workdir
    end
  end
end
