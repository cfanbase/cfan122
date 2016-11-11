# frozen_string_literal: true

module Cfan122

  module HttpConfig
    extend ActiveSupport::Concern

    included do
      include HTTParty
      debug_output $stdout
      headers({
        "Accept-Encoding" => 'gzip',
        "Accept" => 'application/json',
        'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.107 Safari/537.36"
        })

      def set_base_uri province
        self.class.base_uri Config.instance.domain.dup.gsub('www', province.to_s)
      end
    end

  end
end
