class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update destroy ]
  # set user was done by the scaffold generator but it was not handeling whenever there was no users so I handeled it manually so set_user is not done using before_action for show method/action
  # instead i did what set_user would do but inside the show action and hadeled whenever no record was found issue was being generated
  before_action :set_user, only: %i[ edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    # the parameter passed in the URI transfers here in params in hash data structure (dictonary)
    # created instance variable so that it would be globally accessible
    @id = params[:id]
    @ids_in_User = User.ids

    # yes_exists = @exists.select {|ex_id| ex_id == @id} 

    @ids_in_User.each do |ex_id|
      if @id.to_s == ex_id.to_s
        @yes_exists = true
        break
      else
        @yes_exists = false
      end
    end 
    # {|ex_id| ex_id == @id} 

    if @yes_exists==true 
        @user = User.find(params[:id])
    else
        html_content = "<h2>No record found for id "  + params[:id] + "</h2>"

        render html: html_content.html_safe
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username)
    end
end
