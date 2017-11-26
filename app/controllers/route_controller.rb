class RouteController < ApplicationController
  def route
    sumps = []
    sumps << Sump.find(1)
    sumps << Sump.find(2)
    sumps << Sump.find(3)

    response = sumps.map do |sump|
      sump.to_sump_json
    end

    render json: response
  end
end
