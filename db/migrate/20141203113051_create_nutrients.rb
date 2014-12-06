class CreateNutrients < ActiveRecord::Migration
  def change
    create_table :nutrients do |t|
      t.string :name
      t.integer :'Nutr_No'
      t.integer :importance
      t.string :dv
      t.timestamps
    end
  end
end
