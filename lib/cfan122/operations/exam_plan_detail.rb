# frozen_string_literal: true

module Cfan122

  class ExamPlanDetail < Operation
    class Request < Operation::Request
      PARAMS = [:startTime, :endTime, :fzjg, :kscx, :ksdd, :kskm, :size, :zt]
      attr_accessor *PARAMS
      include HttpConfig
      include OperationMethods

      def execute params = {}
        options = attributes.merge(params)
        self.class.post('/m/examplan/getExamPlanDetail', body: to_params(options))
      end

      private
      def set_request_params
        self.attributes = {
          startTime: Date.today,
          endTime: Date.today + 1.year,
          fzjg: city, kscx: type,
          ksdd: location, kskm: subject,
          size: 99, zt: 0
        }
      end

    end

    class Response < Operation::Response
      def body
        to_json['data']
      end
    end
  end

end
