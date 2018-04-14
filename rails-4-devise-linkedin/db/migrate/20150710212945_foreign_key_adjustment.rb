class ForeignKeyAdjustment < ActiveRecord::Migration
  def change
  	add_foreign_key :users, :teams , column: 'team_id'
  	add_foreign_key :teams, :clients , column: 'client_id'
  end
end
