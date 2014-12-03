class CreateNutrients < ActiveRecord::Migration
  def change
    create_table :nutrients do |t|
      t.integer :'Nutr_No'
      t.integer :importance
      t.float :dv
      t.timestamps
    end
  end
end
