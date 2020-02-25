# Create a sample user
unless User.find_by(email: 'newbie@email.com')
  user = User.new
  user.name = 'newbie'
  user.email = 'newbie@email.com'
  user.save
end

unless User.find_by(email: 'novice@email.com')
  user = User.new
  user.name = 'novice'
  user.email = 'novice@email.com'
  user.save
end

unless User.find_by(email: 'tester@email.com')
  user = User.new
  user.name = 'tester'
  user.email = 'tester@email.com'
  user.save
end
