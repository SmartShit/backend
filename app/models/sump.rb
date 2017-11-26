class Sump < ApplicationRecord
  belongs_to :sensor, inverse_of: :sump

  def to_sump_json
    {
        id: id,
        latitude: latitude,
        longitude: longitude,
        name: name,
        address_street: address_street,
        address_city: address_city,

        sensor_id: sensor.id,
        fullness_pct: sensor.fullness_pct
    }
  end
end
