class UsersController < ApplicationController
  protect_from_forgery
  before_action :require_login, except: [:login, :register, :index]

def index
end

def register
  u=User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
  if u.valid?
    u.save
    flash[:notice] = "Thanks for registering. Please login below."
    redirect_to "/index"
  else
    flash[:errors]=u.errors.full_messages
    redirect_to "/index"
  end
end

def login
  u = User.find_by_email(params[:email])
    if (u && u.authenticate(params[:password]))
      session[:user_id] = u.id
      redirect_to "/songs"
    else
      flash[:error] = "Invalid login information!"
      redirect_to '/index'
    end
end

def logoff
    session[:user_id]=nil
    redirect_to "/index"
  end


end
