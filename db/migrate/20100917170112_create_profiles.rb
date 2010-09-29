class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.references :user
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.datetime :birth
      t.string  :website,     :default => "http://"
      t.string  :location
      t.text :me,             :default => ""

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
