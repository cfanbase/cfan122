# frozen_string_literal: true

module Cfan122

  module OperationMethods
    extend ActiveSupport::Concern

    included do

      def attributes
        attrs = self.class.const_defined?('PARAMS') ? (self.class.attrs + self.class::PARAMS) : self.class.attrs
        attrs.map{|key| [key, public_send("#{key}")]}.to_h
      end

      def attributes=(hash)
        hash.each{|key, value| public_send("#{key}=", value) if self.class.method_defined? "#{key}=" }
      end

      def to_params options = {}
        options = options.select{|k, v| self.class::PARAMS.include?(k) } if self.class.const_defined?('PARAMS')
        options.map{|k, v| ["#{k}", v] }.to_h
      end

      def self.attrs
        [:province, :city, :subject, :type, :location, :page]
      end

      attr_accessor *attrs

      private

      def set_default
        @province ||= :ln
        @subject ||= 3
        @type ||= 'C1'
        @city ||= '辽B'
        @location ||= '21020103'
        @page ||= 1
      end
    end

  end
end
