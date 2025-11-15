namespace :admin do
  desc "Add admin user linardsberzins@gmail.com"
  task add_linards: :environment do
    user = User.find_or_initialize_by(email: 'linardsberzins@gmail.com')

    if user.new_record?
      # Generate a secure random password
      temp_password = SecureRandom.hex(16)
      user.password = temp_password
      user.password_confirmation = temp_password
      user.name = 'Linards Berzins'
      user.roles = 'site_admin'

      if user.save
        puts "✓ New admin user created for linardsberzins@gmail.com"
        puts "✓ Temporary password: #{temp_password}"
        puts "⚠ Please log in and change your password immediately via Devise"
      else
        puts "✗ Error creating user: #{user.errors.full_messages.join(', ')}"
      end
    else
      user.update!(roles: 'site_admin')
      puts "✓ User linardsberzins@gmail.com updated to site_admin"
    end
  end
end
