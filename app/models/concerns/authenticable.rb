module Authenticable
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.secrets.secret_key_base

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    begin
      decoded_token = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
      @current_user = User.find(decoded_token.first['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
