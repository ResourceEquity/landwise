class ApiController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  skip_before_action :verify_authenticity_token
  skip_before_action :check_redirect

  before_action :authenticate!

  def create
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user,
    }
    result = ResourceEquitySchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue => e
    logger.error e.message
    logger.error e.backtrace.join("\n")

    if Rails.env.development?
      render json: { errors: [{ message: e.message, code: 500, backtrace: e.backtrace }], data: {} }, status: 500
    else
      render json: { errors: [{ message: e.message, code: 500 }], data: {} }, status: 500
    end
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def current_user
    bearer = request.headers['Bearer'].to_s.split(/Bearer\s+/).last
    access = AccessToken.find_by!(token: bearer)
    access.user
  rescue ActiveRecord::RecordNotFound => e
    nil
  end

  def authenticate!
    unless current_user.present?
      render json: { errors: [{ message: 'Invalid authentication token', code: 403 }], data: {} }, status: :forbidden
    end
  end

end
