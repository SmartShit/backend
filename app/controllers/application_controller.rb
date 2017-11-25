class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: :not_found
  end
end
