class AddBgphotoToUsers < ActiveRecord::Migration
   def self.up
    change_table :users do |t|
      t.attachment :bgphoto
    end
  end

  def self.down
    remove_attachment :users, :bgphoto
  end
end
