class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.references :dj, index: true
      t.string :duration

      t.timestamps
    end
  end
end
