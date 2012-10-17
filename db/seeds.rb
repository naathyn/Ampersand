puts 'CREATING NATHAN AS ADMIN, ALAN AND AUDREY'
nathan = User.create! :realname => 'Nathan Couch', :email => 'nathan3k@gmail.com', :name => 'naathyn', :password => 'nathancouch', :password_confirmation => 'nathancouch', :location => 'Jackson, Tennessee', :bio => 'I love everything beautiful.'
puts 'Nathans username: ' << nathan.name
alan = User.create! :realname => 'Alan Couch', :email => 'hatchiebird@gmail.com', :name => 'hatchiebird', :password => 'alancouch', :password_confirmation => 'alancouch', :location => 'Jackson', :bio => 'Too many interests, not enough time to explore them all.'
puts 'Alans username: ' << alan.name
audrey = User.create! :realname => 'Audrey Couch', :email => 'audeyboo10@gmail.com', :name => 'audreycouch', :password => 'audreycouch', :password_confirmation => 'audreycouch', :location => 'Tennessee', :bio => 'Cats.'
puts 'Audreys username: ' << audrey.name
User.first.toggle!(:admin)
