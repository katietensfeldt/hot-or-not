module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :hot_or_not_cities_weather, [CityWeatherOneDayType], "Returns all cities that are hot or not", null: false do
      argument :name, String, required: true
      argument :hot, Boolean, required: false
    end
   
    def hot_or_not_cities_weather(name:, hot: nil)
      #TODO: Figure out how to input temp types in place of 'imperial'
      hot_temp = HotnessSetting.last.temp
      set_unit = HotnessSetting.last.units

      case set_unit
      when 0
        unit = '&units=imperial'
      when 1
        unit = '&units=metric'
      else
        unit = ''
      end

      url = "https://api.openweathermap.org/data/2.5/find?q=#{name}&appid=98eb6d082601d7acc75401f1e7b77bc3#{unit}"

      puts "HERE'S THE URL: #{url}"
      response = HTTP.get(url)
      weather = response.parse(:json)["list"]
      cities = []
      if hot==nil
        cities = weather
      else
        weather.each do |city|
          # TODO: Figure out how to pass hot or not temp value
          if hot==true && city["main"]["temp"]>=hot_temp
            cities << city
          elsif hot==false && city["main"]["temp"]<=hot_temp
            cities << city
          else
          end
        end
      end
      cities
    end
  end
end
