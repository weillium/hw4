class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create

    @username_check = User.find_by({email: params["user"]["username"]})
    @email_check = User.find_by({email: params["user"]["email"]})

    if @username_check
      flash[:notice] = "Username exists, try another one!"
      redirect_to "/users/new"
    elsif @email_check
      flash[:notice] = "Email exists, try another one!"
      redirect_to "/users/new"
    else
      plain_text_password = params["user"]["password"]
      @user = User.new(params["user"])
      @user.password = BCrypt::Password.create(plain_text_password)
      @user.save
      flash[:notice] = "Account successfully created!"
      session["user_id"] = @user.id
      redirect_to "/"
    end

  end
end
