require "geocoder/lookups/google"
require "geocoder/results/google_places_details"

module Geocoder
  module Lookup
    class GooglePlacesDetails < Google
      def name
        "Google Places Details"
      end

      def required_api_key_parts
        ["key"]
      end

      def supported_protocols
        [:https]
      end

      private

      def base_query_url(query)
        "#{protocol}://maps.googleapis.com/maps/api/place/details/json?"
      end

      def results(query)
        result = super(query, 'result')
        return [result] unless result.is_a? Array

        result
      end

      def query_url_google_params(query)
        {
          placeid: query.text,
          language: query.language || configuration.language
        }
      end
    end
  end
end
