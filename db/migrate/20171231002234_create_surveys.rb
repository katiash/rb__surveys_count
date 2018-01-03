class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :your_name
      t.string :dojo_loc
      t.string :fave_lang
      t.text :comment

      t.timestamps null: false
    end
  end
end
