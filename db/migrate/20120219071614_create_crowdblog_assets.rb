class CreateCrowdblogAssets < ActiveRecord::Migration
  def change
    create_table :crowdblog_assets do |t|
      t.integer :post_id
      t.string :attachment

      t.timestamps
    end
  end
end
