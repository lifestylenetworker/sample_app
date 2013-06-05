class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
    @title = "All users"
    @users = User.paginate(page: params[:page])
  end

  def new
  	@title = "Sign up"
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the sample app!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @title ="Edit user"
    #@user = User.find(params[:id]) #Commented out because user now exists via sessions and
                                    #this action is only accessible to logged in users
                                    #via the new action correct_user.
  end

  def update
    #@user = User.find(params[:id]) #Commented out because user now exists via sessions and
                                    #this action is only accessible to logged in users.
                                    #via the new action correct_user.
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
