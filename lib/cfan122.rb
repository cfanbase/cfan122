# frozen_string_literal: true

require "active_support"
require "active_support/core_ext"
require "httparty"
require "jsonpath"

require "cfan122/config"
require "cfan122/http_config"
require "cfan122/operation"
require "cfan122/operation_methods"
require "cfan122/operations/exam_location"
require "cfan122/operations/exam_subject"
require "cfan122/operations/exam_agency"
require "cfan122/operations/exam_plan_list"
require "cfan122/operations/exam_plan_detail"
require "cfan122/operations/exam_plan_result"
require "cfan122/yaml_generator"
require "cfan122/version"


module Cfan122

  class << self
    def configure
      config = Config.instance
      block_given? ? yield(config) : config
    end

    alias :config :configure
  end


  def self.reload!
    Reloader.new(self).reload
  end

  class Reloader
    def initialize(top)
      @top = top
    end

    def reload
      cleanup
      load_all
    end

    private

    # @return [Array<String>] array of all files that were loaded to memory
    # under the lib/my_gem_name folder.
    # This code makes assumption #1 above.
    def loaded_files
      $LOADED_FEATURES.select{|x| x.starts_with?(__FILE__.chomp('.rb'))}
    end

    # @return [Array<Module>] Recursively find all modules and classes
    # under the MyGemName namespace.
    # This code makes assumption number #2 above.
    def all_project_objects(current = @top)
      return [] unless current.is_a?(Module) and current.to_s.split('::').first == @top.to_s
      [current] + current.constants.flat_map{|x| all_project_objects(current.const_get(x))}
    end

    # @return [Hash] of the format {Module => true} containing all modules
    #   and classes under the MyGemName namespace
    def all_project_objects_lookup
      @_all_project_objects_lookup ||= Hash[all_project_objects.map{|x| [x, true]}]
    end

    # Recursively removes all constant entries of modules and classes under
    # the MyGemName namespace
    def cleanup(parent = Object, current = @top)
      return unless all_project_objects_lookup[current]
      current.constants.each {|const| cleanup current, current.const_get(const)}
      parent.send(:remove_const, current.to_s.split('::').last.to_sym)
    end

    # Re-load all files that were previously reloaded
    def load_all
      loaded_files.each{|x| load x}
      true
    end
  end

end
