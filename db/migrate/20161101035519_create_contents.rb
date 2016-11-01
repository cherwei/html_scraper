class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :href, null: false
      t.text :content
      t.timestamps
    end
  end
end
