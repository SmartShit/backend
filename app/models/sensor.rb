class Sensor < ApplicationRecord
  has_one :sump, inverse_of: :sensor

  after_save :update_on_fullness_change

  def update_on_fullness_change
    return unless fullness_pct_changed?

    UpdateSensorFirebaseJob.perform_now(id)

    if fullness_pct > 70
      SendSmsNotificationJob.perform_now(id)
    end
  end
end
