10.times do |blog|
	Blog.create!(
		title: "Blog post #{blog}",
		body: "Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum
					Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum
					Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum"
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

9.times do |portfolio_item|
	Portfolio.create!(
		title: "Portfolio title: #{portfolio_item}",
		subtitle: "Services",
		body: "Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum
					 Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum
					 Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum", 
		main_image: "https://placeholdit.co//i/600x400?&bg=f9e267&fc=000000&text=Portfolio%20item", 
		thumb_image: "https://placeholdit.co//i/350x200?&bg=99eeff&fc=000000&text=Thumb%20Item"
	)
end

puts "9 portfolio items created"