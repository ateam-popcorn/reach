class DropUserMeetings < ActiveRecord::Migration
  def change
    drop_table :user_meetings
  end
end
