class UsersController < ApplicationController
  before_action :require_login, only: [ :show ]

  def show
    @user = User.find(params[:id])
  end
end
