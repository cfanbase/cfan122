# frozen_string_literal: true

module Cfan122

  class ExamLocation < Operation
    class Request < Operation::Request
      PARAMS = [:fzjg, :kskm]
      attr_accessor *PARAMS
      include HttpConfig
      include OperationMethods

      def execute params = {}
        options = attributes.merge(params)
        self.class.post('/m/examplan/initKsdd', body: to_params(options))
      end

      private
      def reset
        set_default
        self.attributes = {fzjg: city, kskm: subject}
      end
    end

    class Response < Operation::Response
      def body
        to_json['data']
      end
    end
  end

end
