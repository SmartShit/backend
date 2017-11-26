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

      angle_xz = Math.atan2(x.to_f, z.to_f)
      angle_xy = Math.atan2(x.to_f, y.to_f)
      angle_yz = Math.atan2(y.to_f, z.to_f)

      degrees_xz = radians_to_degrees(angle_xz)
      degrees_xy = radians_to_degrees(angle_xy)
      degrees_yz = radians_to_degrees(angle_yz)

      pct_xz = radians_to_pct(angle_xz)
      pct_xy = radians_to_pct(angle_xy)
      pct_yz = radians_to_pct(angle_yz)

      puts "Sigfox data: x = #{x.to_s(16)}, y = #{y.to_s(16)}, z = #{z.to_s(16)}"
      puts "Sigfox data: angle_xz = #{angle_xz.round(2)}, degrees_xz = #{degrees_xz.round(2)}, pct_xz = #{pct_xz}"
      puts "Sigfox data: angle_xy = #{angle_xy.round(2)}, degrees_xy = #{degrees_xy.round(2)}, pct_xy = #{pct_xy}"
      puts "Sigfox data: angle_yz = #{angle_yz.round(2)}, degrees_yz = #{degrees_yz.round(2)}, pct_yz = #{pct_yz}"

      pct = pct_xz
    else
      pct = nil
    end

    pct
  end

  def radians_to_degrees(radians)
    (radians * 180) / Math::PI
  end

  def radians_to_pct(radians)
    pct = (Math.sin(radians) * 100).round.abs

    return 0 if pct < 0
    return 100 if pct > 100

    pct
  end
end
