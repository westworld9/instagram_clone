class DeleteRecords < ActiveRecord::Migration[5.1]
  def change
    drop_table :follows
  end
end
