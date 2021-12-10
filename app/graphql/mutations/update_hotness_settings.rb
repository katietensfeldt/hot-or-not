module Mutations
  class UpdateHotnessSettings < BaseMutation
    # TODO: define return fields
    field :hotness_setting, Types::HotnessSettingType, null: false

    # TODO: define arguments
    argument :units, Integer, required: true
    argument :temp, Float, required: false

    # TODO: define resolve method
    def resolve(units:, temp:nil)
      setting = HotnessSetting.last
      puts temp
      setting.temp = temp || setting.temp
      setting.units = units || setting.units
      if setting.save
        {
          hotness_setting: setting,
          errors: [],
        }
      else
        {
          hotness_setting: nil,
          errors: setting.errors.full_messages
        }
      end
    end
  end
end
