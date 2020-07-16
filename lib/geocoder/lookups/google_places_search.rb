require "geocoder/lookups/google"
require "geocoder/results/google_places_search"

module Geocoder
  module Lookup
    class GooglePlacesSearch < Google
      def name
        "Google Places Search"
      end

      def required_api_key_parts
        ["key"]
      end

      def supported_protocols
        [:https]
      end

      private

      def base_query_url(query)
        "#{protocol}://maps.googleapis.com/maps/api/place/findplacefromtext/json?"
      end

      def query_url_google_params(query)
        {
          input: query.text,
          inputtype: 'textquery',
          fields: default_fields,
          language: query.language || configuration.language
        }
      end

      def default_fields
        legacy_fields = %w[id reference]
        basic = %w[business_status formatted_address geometry icon name 
          photos place_id plus_code types]
        contact = %w[opening_hours]
        atmosphere = %W[price_level rating user_ratings_total]
        (legacy_fields + basic + contact + atmosphere).join(',')
      end
    end
  end
end
