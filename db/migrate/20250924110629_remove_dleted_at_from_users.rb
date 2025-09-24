class RemoveDletedAtFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :deleted_at, :datetime
  end
end
