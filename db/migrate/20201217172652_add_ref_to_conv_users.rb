class AddRefToConvUsers < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :messages, :users, on_delete: :cascade,
                    column: :user_id, primary_key: "id"
    add_foreign_key :messages, :conversations, on_delete: :cascade,
                    column: :conversation_id, primary_key: "id"
  end
end
