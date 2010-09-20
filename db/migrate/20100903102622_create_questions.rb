class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :user
      t.string :title
      t.text :body
      t.text :html_body
      t.integer :status,      :default => 0
      # accepted answer ID
      t.integer :accepted,    :default => 0
      t.integer :voted,       :default => 0   
      t.integer :viewed,      :default => 0
      t.integer :favorited,   :default => 0
      # answers size
      t.integer :answered,    :default => 0
      # tags
      t.string  :tagged

      t.timestamps
    end
    add_index :questions, :user_id
  end

  def self.down
    drop_table :questions
  end
end
