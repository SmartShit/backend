class UpdateSensorFirebaseJob < ApplicationJob
  FIREBASE_URL = 'https://smart-shit-e8a3c.firebaseio.com/'

  def perform(sensor_id)
    sensor = Sensor.find(sensor_id)
    firebase = Firebase::Client.new(FIREBASE_URL)

    firebase.push("sensors/#{sensor.id}", {
        fullness_pct: sensor.fullness_pct
    })
  rescue
    # ignored
  end
end
