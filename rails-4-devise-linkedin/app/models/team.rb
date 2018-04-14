class Team < ActiveRecord::Base
	belongs_to :client
	has_many :users

	validates :name, presence: true, allow_blank: false
	validates :client_id, presence: true, allow_blank: false

	validates_uniqueness_of :name

	before_save :verify_client_id

	def verify_client_id
	end
end
