class Api::V1::UsersController < ApplicationController
  include Authenticable
  before_action :authenticate_request

  def profile
    render json: @current_user
  end

  def index
    render json: User.all
  end
end
