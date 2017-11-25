class SendSmsNotificationJob < ApplicationJob
  TWILIO_ACCOUNT_SID = 'AC828e90c9fdac988d640253026b07cebd'
  TWILIO_AUTH_TOKEN = 'b5fdd89e8a9023068c7edf74174ca17d'

  def perform(sensor_id)
    sump = Sump.eager_load(:sensor).where('sensors.id = ?', sensor_id).first

    return if sump.nil?

    text = "[SmartShit] Vase zumpa je zaplnena z #{sump.fullness_pct} %. Budete kontaktovat ohledne odvozu."

    send_message(sump.phone, text)
  rescue
    # ignored
  end

  private

  def send_message(phone, text)
    twilio = Twilio::REST::CLient.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
    twilio.account.messages.create({
                                       from: '+420777894022',
                                       to: phone,
                                       body: text
                                   })
  end
end
