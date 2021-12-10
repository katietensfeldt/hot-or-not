module Types
  class CityType < Types::BaseObject
    field :coordinates, Types::CoordinatesType, null: false
    field :country, String, null: false
    field :id, Integer, null: false
    field :name, String, null: false
  end
end
