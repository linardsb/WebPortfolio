class AddLinardsAdminUser < ActiveRecord::Migration[5.1]
  def up
    # Use raw SQL to avoid loading models during migration
    email = 'linardsberzins@gmail.com'

    # Check if user already exists
    result = execute("SELECT id FROM users WHERE email = '#{email}' LIMIT 1")

    if result.count > 0
      # Update existing user to admin
      execute("UPDATE users SET roles = 'site_admin' WHERE email = '#{email}'")
      puts "✓ Updated #{email} to site_admin"
    else
      # Create new admin user with encrypted password
      require 'bcrypt'
      temp_password = SecureRandom.hex(16)
      encrypted_password = BCrypt::Password.create(temp_password)

      execute(<<-SQL)
        INSERT INTO users (email, encrypted_password, name, roles, created_at, updated_at)
        VALUES (
          '#{email}',
          '#{encrypted_password}',
          'Linards Berzins',
          'site_admin',
          NOW(),
          NOW()
        )
      SQL

      puts "✓ Created admin user: #{email}"
      puts "✓ Temporary password: #{temp_password}"
      puts "⚠ IMPORTANT: Save this password and change it after first login!"
    end
  end

  def down
    execute("UPDATE users SET roles = NULL WHERE email = 'linardsberzins@gmail.com'")
  end
end
