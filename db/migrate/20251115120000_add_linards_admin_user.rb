class AddLinardsAdminUser < ActiveRecord::Migration[5.1]
  def up
    # Check if user already exists
    user = User.find_by(email: 'linardsberzins@gmail.com')

    if user
      # Update existing user to admin
      user.update!(roles: 'site_admin')
      puts "✓ Updated linardsberzins@gmail.com to site_admin"
    else
      # Create new admin user
      temp_password = SecureRandom.hex(16)
      User.create!(
        email: 'linardsberzins@gmail.com',
        password: temp_password,
        password_confirmation: temp_password,
        name: 'Linards Berzins',
        roles: 'site_admin'
      )
      puts "✓ Created admin user: linardsberzins@gmail.com"
      puts "✓ Temporary password: #{temp_password}"
      puts "⚠ Check deployment logs for password, then change it immediately after login"
    end
  end

  def down
    user = User.find_by(email: 'linardsberzins@gmail.com')
    user&.update(roles: nil)
  end
end
