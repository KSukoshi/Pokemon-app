require 'uri'
require 'net/http'

module Services
    module PokeApi
        class Api
            def self.get_abilities(params)
                uri = URI('https://pokeapi.co/api/v2/pokemon/' + params)
                response = Net::HTTP.get_response(uri)
                unparsed_data = response.body if response.is_a?(Net::HTTPSuccess)
                data = JSON.parse(unparsed_data).to_h
                abilities = data['abilities']
                skill_params = []
                abilities.each do |result|
                  skill_params << [result['ability']['name'], result['ability']['url']]
                end

                skill_params
            end
        end
    end
end