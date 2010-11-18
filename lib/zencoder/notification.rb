module Zencoder
  class Notification < Base

    def self.list(options={})
      params = {:api_key  => options.delete(:api_key) || api_key,
                :page     => options.delete(:page) || 1,
                :per_page => options.delete(:per_page) || 50 }

      HTTP.get("#{options[:base_url] || base_url}/notifications", merge_params(options, params))
    end

  end
end
