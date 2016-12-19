class CreateOthers < ActiveRecord::Migration
  def change
    create_table :others do |t|
      t.references :song, index: true
      t.references :user, index: true
      t.integer :counto

      t.timestamps null: false
    end
    add_foreign_key :others, :songs
    add_foreign_key :others, :users
  end
end
