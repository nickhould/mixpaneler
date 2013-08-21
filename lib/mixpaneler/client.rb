module Mixpaneler
  class Client
    API_KEY    = ENV['mixpanel_api_key']
    API_SECRET = ENV['mixpanel_api_secret']

    def initialize()
      @client = Mixpanel::Client.new(config)
      @from_date = Date.today - 7
      @to_date = Date.today - 1
    end

    private
    def config(config={})
      config[:api_key], config[:api_secret] = API_KEY, API_SECRET
    end

    def method_missing(method, *args, &block)
      client_request(method, args)
    end

    def client_request(method, args)
      @client.request( slasherize(method), params(args))
    end

    def params(args)
      args.any? ? args[0] : {}
    end

    def slasherize(method)
      method.to_s.gsub("_","/")
    end
  end
end