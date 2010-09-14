class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :s
      t.string  :e
      t.integer :t
      t.string  :c

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
