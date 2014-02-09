class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :videos
    end
  end
end
