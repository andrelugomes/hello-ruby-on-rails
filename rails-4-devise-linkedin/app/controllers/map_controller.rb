class MapController < ApplicationController
  before_action :authenticate_user!

  def index
  	user = User.new
  	user.id = current_user.id
  	user.name = current_user.name
  	user.image = current_user.image
  	@user = user
  end

  def map_data
  	data = []

  	#clients = Client.includes(:teams).all
  	clients = Client.all

  	clients.each do |client|
  		data_teams = []

  		teams = Team.where(client_id: client.id)

  		unless teams.empty?
  			teams.each do |team|
  				data_users = []
  				
  				users = User.where(team_id:team.id)
					unless users.empty?
						users.each do |user|
							#data_users << {:id => user.name, :image => user.image }
							data_users << {id: user.name, image: user.image }
						end
					end
				#data_teams << {:id => team.id, :team => team.name, :users => data_users }
	  			data_teams << {id: team.id, team: team.name, users: data_users }
	  		end		
  		end

  		#data << {:id => client.id, :client => client.name, :teams => data_teams }
  		data << {id: client.id, client: client.name, teams: data_teams }
  
  	end
  	
  	render json: @data = data
  end

  def simple_map_data
  	clients = Client.all
  	render json: @data = clients, include: [:teams, teams: { include: :users } ]
  end
end
