password = Devise.friendly_token(25)
User.create!(name: "Admin",
             email: 'admin@example.org',
             password: password,
             password_confirmation: password,
             is_admin: true,
             terms: "1",
             confirmed_at: Time.now)
puts "Created admin user admin@example.org with password #{password}"
