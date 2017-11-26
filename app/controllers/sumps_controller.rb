class SumpsController < ApplicationController
  def index
    sumps = Sump.eager_load(:sensor).order('id ASC')

    response = sumps.map do |sump|
      sump.to_sump_json
    end

    render json: response
  end

  def show
    sump = Sump.eager_load(:sensor).find(params[:id])

    render json: sump.to_sump_json
  end
end
