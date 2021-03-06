class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  before_filter :authenticate_user!, :only => [:index, :show, :edit, :update, :destroy]

  def sent
    @current_user = current_user
    @comment = Comment.new
    @tyml = Tyml.new
  end

  def contacts
    @current_user = current_user
    @users_from_contacts = @current_user.users_from_contacts
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def dashboard
    @comment = Comment.new

    if current_user.present?
      @current_user = current_user
      @autocomplete_items = @current_user.contacts.map { |c| c.contact_email }
      @tyml = Tyml.new
    else
      redirect_to new_user_session_path
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @tyml = Tyml.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @tyml = Tyml.new

    if current_user.present?
      @user = current_user
    else
      redirect_to new_user_session_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
