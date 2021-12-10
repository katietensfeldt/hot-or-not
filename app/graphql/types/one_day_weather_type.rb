module Types
  class OneDayWeatherType < Types::BaseObject
    field :feelsLike, Float, null: false
    field :groundLevel, Integer, null: true
    field :hot, Boolean, null: false
    field :temp, Float, null: false
    field :tempMax, Float, null: false
    field :tempMin, Float, null: false
  end
end
