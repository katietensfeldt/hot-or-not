module Types
  class CityWeatherOneDayType < Types::BaseObject
    field :city, Types::CityType, null: true
    field :weather, Types::OneDayWeatherType, null: false
    field :id, Integer, null: false
    field :name, String, null: false
  end
end
