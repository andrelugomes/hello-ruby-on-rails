class DashboardController < ApplicationController

  before_action :authenticate_user!

  def index
  	#binding.pry 
  	user = User.new
  	user.id = current_user.id
  	user.name = current_user.name
  	user.image = current_user.image
  	user.team_id = current_user.team_id
  	@all_teams = Team.all 
  	@user = user
  	#binding.pry
  end

  def update_team
  	if params.has_key?(:team_id) && !params["team_id"].nil? && !params["team_id"].empty?
        #binding.pry
        user = User.find_by(id: params["id"])
        user.team_id = 	params["team_id"]
        user.save
        @user = user
        render json: @user, status: :ok
  	else  		 
        render :json => { :errors => "team_id is missing", :status => 400} ,status: :bad_request  
    end
  end

end
