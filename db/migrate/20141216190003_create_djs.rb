class CreateDjs < ActiveRecord::Migration
  def change
    create_table :djs do |t|
      t.string :artist_name

      t.timestamps
    end
  end
end
