class CreateModelYearServiceRequirementVotes < ActiveRecord::Migration
  def change
    create_table :model_year_service_requirement_votes do |t|
      t.belongs_to :model_year_service_requirement
      t.belongs_to :user
      t.belongs_to :vote_type
      t.boolean :is_guest
      t.string :ip_address
      t.string :session_id

      t.timestamps
    end
  end
end
