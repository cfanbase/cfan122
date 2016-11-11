# frozen_string_literal: true

module Cfan122

  class ExamSubject < Operation
    class Request < Operation::Request
      include HttpConfig
      include OperationMethods

      def execute params = {}
        options = attributes.merge(params)
        self.class.post('/m/examplan/initKskm', body: to_params(options))
      end

      private
      def reset
        set_default
        self.attributes = {kvmode: 0}
      end
    end

    class Response < Operation::Response
      def body
        to_json['data']
      end
    end
  end

end
