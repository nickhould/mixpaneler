module Mixpaneler
  class Client
    API_KEY    = ENV['mixpanel_api_key']
    API_SECRET = ENV['mixpanel_api_secret']

    def initialize()
      config = {
        api_key:     API_KEY,
        api_secret:  API_SECRET
      }
      @client = Mixpanel::Client.new(config)
      @from_date = Date.today - 7
      @to_date = Date.today - 1
    end

    def method_missing(method, *args, &block)
      puts slasherize(method)
      puts get_params(args)
      @client.request(
        slasherize(method),
        get_params(args))
    end

    def get_params(args)
      args.any? ? args[0] : {}
    end

    def slasherize(method)
      method.to_s.gsub("_","/")
    end
    # def events(parans={})
    #   @client.request('events', params)
    # end

    # def events_top(params={})

    # def funnel_list(params={})
    #   @client.request('funnels/list', params)
    # end

    # def funnel(params={})
    #   @client.request('funnels', params)
    # end

    # def events_names(params={})
    #   @client.request('events/names', params  )
    # end
  end
end