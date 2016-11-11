# frozen_string_literal: true

module Cfan122

  class Operation
    attr_reader :options, :request, :response

    def initialize options = {}
      @options = options
    end

    def self.execute options = {}
      self.new(options).execute
    end

    def execute
      @request = self.class::Request.new(options)
      @response = self.class::Response.new(@request)
      @response.body
    end

    class Request
      attr_accessor :body, :response, :impersonation_user

      def initialize params = {}
        set_default
        set_base_uri province
        self.attributes = params
        set_request_params
      end

      def set_default; end

      def set_request_params; end

      def execute
        raise NotImplemented
      end
    end

    class ResponseError < StandardError
      attr_reader :response_code

      def initialize message, response_code
        super message
        @response_code = response_code
      end
    end

    class Response
      attr_reader :request, :response, :operation

      def initialize operation
        @operation = operation
        @response = operation.execute
        @request = response.request
        raise ResponseError.new('Request Error!', response.code) if response.code != 200
      end

      def to_json
        response.body.blank? ? {} : JSON.parse(response.body)
      end

    end
  end
end
