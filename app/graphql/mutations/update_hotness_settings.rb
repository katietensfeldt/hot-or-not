module Mutations
  class UpdateHotnessSettings < BaseMutation
    field :hotness_setting, Types::HotnessSettingType, null: false
    field :errors, [String], null: true

    # FIXME: change integer to enum
    argument :units, Integer, required: true
    argument :temp, Float, required: false

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
