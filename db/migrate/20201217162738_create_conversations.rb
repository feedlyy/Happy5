class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.integer :sender
      t.integer :receiver
      t.timestamps
    end
  end
end
