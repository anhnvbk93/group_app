# Add activation field to users model
class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :boolean, default: false
    add_column :users, :active, :string
    add_column :users, :activated_at, :datetime
  end
end
