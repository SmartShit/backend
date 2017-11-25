class SumpsController < ApplicationController
  def index
    sumps = Sump.eager_load(:sensor).all

    response = sumps.map do |sump|
      sump_to_json(sump)
    end

    render json: response
  end

  def show
    sump = Sump.eager_load(:sensor).find(params[:id])

    render json: sump_to_json(sump)
  end

  private

  def sump_to_json(sump)
    {
        id: sump.id,
        latitude: sump.latitude,
        longitude: sump.longitude,
        name: sump.name,
        address_street: sump.address_street,
        address_city: sump.address_city,

        sensor_id: sump.sensor.id,
        fullness_pct: sump.sensor.fullness_pct
    }
  end
end
