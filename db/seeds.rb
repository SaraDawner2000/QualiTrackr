# Create the initial user
User.create(
  email: "ndworknstudy@gmail.com",
  password: "password",
  password_confirmation: "password",
  username: "natalie_super_admin",
  admin: true,
  role: "quality_manager"
)

# Create the sample users
users = ["Alice", "Bob", "Dave", "Eve"]
index = 0
User.role_options.each do |key, role|
    username = users[index].downcase
    User.create(
      email: "#{username}@example.com",
      password: "password",
      username: "#{username}",
      role:,
      admin: false
    )
  end
