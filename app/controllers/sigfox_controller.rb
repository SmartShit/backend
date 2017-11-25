class SigfoxController < ApplicationController
  def data
    render nothing: true, status: :not_acceptable if params[:id].blank?
    render nothing: true, status: :not_acceptable if params[:data].blank?

    UpdateSensorFromSigfoxJob.perform_now(params[:id], params[:data])

    render nothing: true, status: :ok
  end
end
