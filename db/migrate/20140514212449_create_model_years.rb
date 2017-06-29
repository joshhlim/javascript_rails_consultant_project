class CreateModelYears < ActiveRecord::Migration
  def change
    create_table :model_years do |t|
      t.integer :year
      t.belongs_to :model, index: true

      t.timestamps
    end
  end
end
