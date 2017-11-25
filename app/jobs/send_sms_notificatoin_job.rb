class SendSmsNotificationJob < ApplicationJob
  TWILIO_ACCOUNT_SID = 'AC8f2bee36489c1d78337a8e0afcd71990'
  TWILIO_AUTH_TOKEN = '6dcc292bf9fb43acb84eabd4e2a7a49c'

  def perform(sensor_id)
    sump = Sump.eager_load(:sensor).where('sensors.id = ?', sensor_id).first

    return if sump.nil?

    text = "[SmartShit] Vase zumpa je zaplnena z #{sump.sensor.fullness_pct} %. Budete kontaktovat ohledne odvozu."

    send_message(sump.phone, text)
  rescue
    # ignored
  end

  private

  def send_message(phone, text)
    twilio = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
    twilio.messages.create({
                                       from: '+17402004236',
                                       to: phone,
                                       body: text
                                   })
  end
end
