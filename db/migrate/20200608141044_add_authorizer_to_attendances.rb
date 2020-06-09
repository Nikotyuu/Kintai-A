class AddAuthorizerToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :authorizer, :string
  end
end
