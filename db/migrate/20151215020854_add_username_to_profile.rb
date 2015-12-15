class AddUsernameToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :username, :string, null: false, limit: 32, default: ''
  end
end
