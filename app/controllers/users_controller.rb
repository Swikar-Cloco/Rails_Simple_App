class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update destroy ]
  # set user was done by the scaffold generator but it was not handeling whenever there was no users so I handeled it manually so set_user is not done using before_action for show method/action
  # instead i did what set_user would do but inside the show action and hadeled whenever no record was found issue was being generated
  before_action :set_user, only: %i[ edit update destroy ]
  before_action :require_user
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /users or /users.json
  def index
    # puts "Hererrrrrrrrrrrrrrrrrrr"
    # if current_user.email == "swikar@cloco.com"
    #   puts "Can Access"
    # else
    #   puts "Can't Access"
    #   flash[:notice] = "You dont have permission for this action - not an admin"
    #   redirect_to articles_path 
    # end
    
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 5)
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
        @articles= @user.articles
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
    # if logged_in? && current_user.id == @user.id
    #   puts "Can edit"
    # else
    #   puts "Can't edit"
    #   flash[:notice] = "You dont have permission for this action"
    #   redirect_to articles_path 
    # end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.html { redirect_to articles_path, notice: "User was successfully created." }
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
    puts "Destroyed sssssssssssssssssssssssssssssssssssssssssssssssssss"
    puts @user
    puts current_user
    if (@user == current_user)
      session[:user_id] = nil
    end
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully deleted and all the related articles were too." }
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
      params.require(:user).permit(:username, :email, :password)
    end
end
