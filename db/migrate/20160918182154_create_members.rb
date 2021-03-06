class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.string :category
      t.string :role

      t.timestamps
    end
  end
end
