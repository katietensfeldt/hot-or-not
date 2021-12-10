module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :hot_or_not_cities_weather, [CityWeatherOneDayType], "Returns all cities that are hot or not", null: false do
      argument :name, String, required: true
      argument :hot, Boolean, required: false
      argument :feels_like, Boolean, required: false
    end
   
    def hot_or_not_cities_weather(name:, hot: nil, feels_like: nil)
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

      url = "https://api.openweathermap.org/data/2.5/find?q=#{name}&appid=#{Rails.application.credentials.open_weather}#{unit}"

      response = HTTP.get(url)
      weather = response.parse(:json)["list"]
      puts weather
      cities = []
      unfiltered_cities = weather
      if hot==nil && feels_like==nil
        cities = unfiltered_cities
      elsif hot!=nil && feels_like==nil
        unfiltered_cities.each do |city|
          if hot==true && city["main"]["temp"]>=hot_temp
            cities << city
          elsif hot==false && city["main"]["temp"]<=hot_temp
            cities << city
          end
        end
      elsif hot==nil && feels_like!=nil
        unfiltered_cities.each do |city|
          if hot==true && city["main"]["feels_like"]>=hot_temp
            cities << city
          elsif hot==false && city["main"]["feels_like"]<=hot_temp
            cities << city
          else
          end
        end
      end
      parse_object(cities)
    end

    def parse_object(cities)
      city_array = []
      hot_temp = HotnessSetting.last.temp

      cities.each do |city|
        city_object = {
          city: {
            coordinates: city["coord"],
            country: city["sys"]["country"],
            id: city["id"],
            name: city["name"],
          },
          weather: {
            feels_like: city["main"]["feels_like"],
            temp: city["main"]["temp"],
            temp_max: city["main"]["temp_max"],
            temp_min: city["main"]["temp_min"],
            hot: city["main"]["temp"] >= hot_temp,
          }
        }
        city_array << city_object
      end

      return city_array
    end
  end
end
