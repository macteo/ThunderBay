class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_user_from_token, only: [:add_item, :remove_item, :update_image]
  # GET /users
  # GET /users.json
  def index
    @users = User.all.order('id ASC')
  end

  # GET /users/1
  # GET /users/1.json
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
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/token
  # PATCH/PUT /users/token.json
  def update_image
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_item
    if !params["id"].blank?
      item = Item.find(params["id"])
      if item
        @profile = Profile.where(:user_id => @user.id, :venue_id => item.venue_id).first
        if @profile
          if @profile.items.where(:id => item.id).count == 0
            @profile.items << item
            @profile.save
          end
          #render json: @profile, status: 201
          render "profile.json", status: :ok, location: @user
          return
        end
      end
    end
    render json: '{"error":"Not found"}', status: 404
  end

  def remove_item
    if !params["id"].blank?
      item = Item.find(params["id"])
      if item
        @profile = Profile.where(:user_id => @user.id, :venue_id => item.venue_id).first
        if @profile
          @profile.items.delete(item)
          @profile.save
          render "profile.json", status: :ok, location: @user
          return
        end
      end
    end
    render json: '{"error":"Not found"}', status: 404
  end

  def authenticate
    @user = User.where(:email => user_params[:email]).first
    respond_to do |format|
      if @user && @user.valid_password?(user_params[:password])
        format.html { redirect_to @user, notice: 'User exists.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to "/", notice: 'Cannot authenticate' }
        format.json { render json: '{"error":"Cannot authenticate"}', status: 401 }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_user_from_token
    @user = User.where(:token => params[:token]).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :image, :image_cache, :remove_image, :birthday, :name, :password)
  end
end
