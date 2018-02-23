User.create!(
	email: "test@test.com",
	password: "asdfasdf",
	password_confirmation: "asdfasdf",
	name: "Admin User",
	roles: "site_admin"
	)

puts "1 Admin user created"

User.create!(
	email: "test2@test.com",
	password: "asdfasdf",
	password_confirmation: "asdfasdf",
	name: "Regular User",
	)

puts "1 regular user created"

3.times do |topic|
	Topic.create!(
		title: "Topic #{topic}"
	)
end

puts "3 topics created"

10.times do |blog|
	Blog.create!(
		title: "Blog post #{blog}",
		body: "Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum
					Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum
					Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum",
		topic_id: Topic.last.id
	)
end

puts "10 Blogposts created"

5.times do |skill|
	Skill.create!(
		title: "Rails #{skill}",
		percent_utilized: 15
	)
end

puts "5 skills added"

8.times do |portfolio_item|
	Portfolio.create!(
		title: "Portfolio title: #{portfolio_item}",
		subtitle: "Emails",
		body: "Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum
					 Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum
					 Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum", 
		main_image: "https://placeholdit.co//i/600x400?&bg=f9e267&fc=000000&text=Portfolio%20Item", 
		thumb_image: "https://placeholdit.co//i/350x200?&bg=99eeff&fc=000000&text=Thumb%20Item"
	)
end

1.times do |portfolio_item|
	Portfolio.create!(
		title: "Portfolio title: #{portfolio_item}",
		subtitle: "Ruby on Rails",
		body: "Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum
					 Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum
					 Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum", 
		main_image: "https://placeholdit.co//i/600x400?&bg=f9e267&fc=000000&text=Portfolio%20item", 
		thumb_image: "https://placeholdit.co//i/350x200?&bg=99eeff&fc=000000&text=Thumb%20Item"
	)
end

puts "9 portfolio items created"


3.times do |technology|
	Portfolio.last.technologies.create!(
		name: "Technology #{technology}"
		)
end

puts "3 technologies created"























