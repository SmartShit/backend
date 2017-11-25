class UpdateSensorFromSigfoxJob < ApplicationJob
  def perform(sigfox_id, sigfox_data)
    puts sigfox_id, sigfox_data

    #sensor = Sensor.find_by_sigfox_id(sigfox_id)

    #sensor.fullness_pct = sigfox_data

    #sensor.save
  end
end
