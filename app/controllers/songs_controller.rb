class SongsController < ApplicationController
  before_action :require_current_user, only: [:index, :create, :add, :playlist, :users]

  def index
		@user = User.find(session[:user_id])
		@all_songs = Song.all.order('created_at DESC')
	end

  def create
		@song = Song.create(title:params[:title], artist:params[:artist], count: 1)
		if @song.invalid?
			flash[:error] = @song.errors.full_messages
			redirect_to '/songs'
		else
			Other.create(user: User.find(session[:user_id]), song: Song.last, counto: 1)
			redirect_to '/songs'
		end
	end

	def add
    @user = User.find(session[:user_id])
		Song.find(params[:id]).increment!(:count)
		existingadd = Other.where(user: @user, song: Song.find(params[:id]))
		if existingadd.empty? == false
			x = Other.where(user: @user, song: Song.find(params[:id])).first.id
			Other.find(x).increment!(:counto)
		else
			Other.create(user: @user, song: Song.find(params[:id]), counto:1)
		end
		redirect_to '/songs'
	end

  def playlist
		@user = User.find(params[:id])
		@other = Other.joins(:song).joins(:user).where(user_id: params[:id])
	end

  def users
		@song = Song.find(params[:id])
		@otherusers = Other.joins(:song).joins(:user).where(song_id: params[:id])
	end



end
