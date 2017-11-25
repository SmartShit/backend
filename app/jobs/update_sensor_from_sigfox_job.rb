class UpdateSensorFromSigfoxJob < ApplicationJob
  def perform(sigfox_id, sigfox_data)
    sensor = Sensor.find_by_sigfox_id(sigfox_id)

    pct = parse_pct_from_sigfox_data(sigfox_data)

    unless pct.nil?
      sensor.fullness_pct = pct
      sensor.save
    end
  rescue
    # ignored
  end

  private

  def parse_pct_from_sigfox_data(data)
    data_i = data.to_i(16)

    shift = (data.length * 4 - 8)
    first_byte = (data_i & (0xFF << shift)) >> shift
    request_type = (first_byte & 0xF0) >> 4
    operational_mode = first_byte & 0x0F

    puts "Sigfox data: request = #{request_type.to_s(16)}, mode = #{operational_mode.to_s(16)}"

    if request_type == 0x3 and [0x3, 0x4].include? operational_mode and data.length == 8
      x = (data_i & 0x00FF0000) >> 16
      y = (data_i & 0x0000FF00) >> 8
      z = (data_i & 0x000000FF)

      x -= 0x80
      y -= 0x80
      z -= 0x80

      angle = Math.atan(x.to_f / z.to_f)
      degrees = (angle * 180) / Math::PI
      pct = (100 * angle / (Math::PI / 2)).round

      puts "Sigfox data: x = #{x.to_s(16)}, y = #{y.to_s(16)}, z = #{z.to_s(16)}"
      puts "Sigfox data: angle = #{angle.round(2)}, degrees = #{degrees.round(2)}, pct = #{pct}"
    else
      pct = nil
    end

    pct
  end
end
