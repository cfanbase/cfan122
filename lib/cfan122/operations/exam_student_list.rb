# frozen_string_literal: true

module Cfan122

  class ExamStudentList < Operation
    class Request < Operation::Request
      PARAMS = [:xh, :page, :size]
      attr_accessor *PARAMS
      include HttpConfig
      include OperationMethods

      def execute params = {}
        options = attributes.merge(params)
        self.class.post('/m/examplan/getStudentInfo', body: to_params(options))
      end

      private
      def set_request_params
        self.attributes = {page: 1, size: 99999}
      end
    end

    class Response < Operation::Response

      def body
        to_json['data']
      end
    end
  end

end
