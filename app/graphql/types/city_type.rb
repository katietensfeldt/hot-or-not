module Types
  class CityType < Types::BaseObject
    field :coord, Types::CoordinatesType, null: false
    field :country, String, null: false
    field :id, Integer, null: false
    field :name, String, null: false
    field :state, String, null: true
  end
end
