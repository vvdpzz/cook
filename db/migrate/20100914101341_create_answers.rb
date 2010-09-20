class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.references :user
      t.references :question
      t.text :body
      t.text :html_body
      t.integer :voted,       :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
