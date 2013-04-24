# This migration comes from crowdblog (originally 20121016063750)
class CreateCrowdblogUsers < ActiveRecord::Migration
  def change
    create_table :crowdblog_users do |t|
      t.string :email
      t.string :name
    end
  end
end
