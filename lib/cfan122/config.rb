# frozen_string_literal: true

module Cfan122

  class Config
    include Singleton

    attr_accessor :domain, :timeout, :username, :password, :debug

    def initialize
      reset
    end

    def reset
      @domain ||= 'http://www.122.gov.cn'
      @username = nil
      @password = nil
      @debug = false
    end

  end
end
