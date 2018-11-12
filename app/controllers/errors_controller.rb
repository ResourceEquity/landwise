class ErrorsController < ApplicationController

  protect_from_forgery with: :exception

  def not_found
    render template: 'errors/not_found', formats: [:html]
  end

  def internal_server_error
    render template: 'errors/internal_server_error', formats: [:html]
  end

  def unprocessable_entity
    render template: 'errors/unprocessable_entity', formats: [:html]
  end

end
