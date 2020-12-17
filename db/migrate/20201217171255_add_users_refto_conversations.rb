class AddUsersReftoConversations < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :conversations, :users, on_delete: :cascade, column: :sender, primary_key: "id"
    add_foreign_key :conversations, :users, on_delete: :cascade, column: :receiver, primary_key: "id"
  end
end
