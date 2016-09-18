class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :project_type
      t.string :name
      t.text :purpose
      t.text :description

      t.timestamps
    end
  end
end
