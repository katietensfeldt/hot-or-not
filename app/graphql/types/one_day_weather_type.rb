module Types
  class OneDayWeatherType < Types::BaseObject
    field :feels_like, Float, null: false
    field :ground_level, Integer, null: true
    field :hot, Boolean, null: false
    field :temp, Float, null: false
    field :temp_max, Float, null: false
    field :temp_min, Float, null: false
  end
end
