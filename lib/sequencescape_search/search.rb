module SequencescapeSearch

  # Search objects can be created for each search endpoint, and can be used
  # to perform appropriate searches.
  class Search

    attr_reader :api_root, :search_endpoint, :search

    # api_root: A Faraday client pointed at the api root
    # search: A SearchEndpoint
    # search_endpoint: [optional] the name of the searches resource itself
    def initialize(api_root,search,search_endpoint='searches',singlular_endpoint='search')
      @api_root = api_root
      @search = search
      @search_endpoint = search_endpoint
      @singlular_endpoint = singlular_endpoint
    end

    # Search for 'query' at the configured endpoint returns a hash matching the SearchEndpoint #return_map
    def find(query)
      payload = { singlular_endpoint => {parameter => query} }.to_json
      response = api_root.post(search_root,payload)
      case response.status
      when 404
        return nil
      when 301
        json = JSON.parse(response.body)
        Hash[return_map.map {|k,v| [k,json.dig(*v)] } ]
      when 503
        raise SequencescapeBusy, "Sequencescape is currently unavailable."
      else
        raise SequencescapeError, "Unexpected response status: #{searches.status}"
      end
    end

    private

     def name; search.name; end
     def parameter; search.parameter; end
     def return_map; search.return_map; end

    # Uses the manually configured version if available otherwise
    # 1. Tries to use ActiveSupport 'singularize'
    # 2. Falls back to a naieve method
    def singlular_endpoint
      @singular_endpoint ||= if search_endpoint.respond_to?(:singularize)
        search_endpoint.singularize
      else
        search_endpoint.gsub(/e{0,1}s\z/,'')
      end
    end

    # Cached search root
    def search_root
      @search_root ||= "#{search_uuid}/first"
    end

    # Finds the uuid corresponding to the configured search endpoint
    def search_uuid
      searches = api_root.get(search_endpoint)
      case searches.status
      when 200
        begin
          json = JSON.parse(searches.body)
        rescue JSON::ParserError
          raise SequencescapeError, "Sequencescape returned non-json content"
        end
        found_search = json.fetch(search_endpoint).detect {|search| search["name"] == name }
        raise SearchNotFound, "Could not find search #{name}" if found_search.nil?
        found_search.fetch("uuid")
      when 503
        raise SequencescapeBusy, "Sequencescape is currently unavailable."
      else
        raise SequencescapeError, "Unexpected response status: #{searches.status}"
      end
    end
  end

end
