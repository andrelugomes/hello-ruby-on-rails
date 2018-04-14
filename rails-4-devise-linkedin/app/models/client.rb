class Client < ActiveRecord::Base
	#has_many :teams, class_name: "Team", foreign_key: "client_id"
	has_many :teams

	validates :name, presence: true, allow_blank: false
	validates_uniqueness_of :name

	before_destroy :verify_teams

	#tratament para Constraint
    def verify_teams
      	return true if teams.count == 0
		errors.add :base, "Cannot delete client with team"
		false
    end
end
