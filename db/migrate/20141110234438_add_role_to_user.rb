class AddRoleToUser < ActiveRecord::Migration
  def up
    add_column :users, :role, :string

    User.all.each do |user|
      assigned_role = if user.admin
        'admin'
      elsif user.platform_admin
        'platform_admin'
      else
        'registered'
      end

      user.update_attributes(role: assigned_role)
    end
  end

  def down
    User.all.each do |user|
      user.admin = false
      user.platform_admin = false

      case user.role
      when 'admin'
        user.admin = true
      when 'platform_admin'
        user.platform_admin = true
      end

      user.save
    end

    remove_column :users, :role
  end
end
