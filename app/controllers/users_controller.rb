# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UsersController < ApplicationController
  before_action :find_current_user, only: [:index, :show, :edit, :update, :destroy]

  # GET /users
  def index
    if @user.present?
      redirect_to @user
    end
  end

  def login
    if @user.blank?
      current_user = User.find_by(email: params[:email], password: params[:password])
      if current_user.present?
        session[:current_user_id] = current_user.id
        redirect_to current_user
      else
        redirect_to users_url, notice: 'User not exist.'
      end
    end
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_current_user
    if session[:current_user_id]
      @user = User.find_by(id: session[:current_user_id])
    else
      @user = nil
    end
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
