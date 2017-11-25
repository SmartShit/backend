class SigfoxController < ApplicationController
  def data
    render nothing: true, status: :not_acceptable if params[:sigfox_id].blank?
    render nothing: true, status: :not_acceptable if params[:sigfox_data].blank?

    UpdateSensorFromSigfoxJob.perform_now(params[:sigfox_id], params[:sigfox_data])

    render nothing: true, status: :ok
  end
end
