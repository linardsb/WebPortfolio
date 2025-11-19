module ApplicationHelper
	def login_helper style = ''
		# Only show logout link when admin is logged in
		# No public login/signup links - admin accesses via direct URL (/users/sign_in)
		if current_user.is_a?(GuestUser)
			"".html_safe  # Return nothing for public users
     else
    	 link_to "Logout", destroy_user_session_path, method: :delete, class: style
     end
	end 

  def source_helper(styles)
    if session[:source]
      greeting = "Thanks for visiting me from #{session[:source]}, please feel free to #{ link_to 'contact me', contact_path } if you'd like to work together."
      content_tag(:div, greeting.html_safe, class: styles)
    end
  end

	def nav_items
    [
      {
        url: root_path,
        title: 'Home'
      },
      {
        url: about_me_path,
        title: 'About'
      },
      {
        url: contact_path,
        title: 'Contact'
      },
      {
        url: blogs_path,
        title: 'Blog'
      },
      {
        url: portfolios_path,
        title: 'Portfolio'
      },
      {
        url: tech_news_path,
        title: 'AI'
      },
    ]
  end

  def nav_helper style, tag_type
    nav_links = ''

    nav_items.each do |item|
      nav_links << "<#{tag_type} style='margin-bottom: 0.6rem;'><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end

    nav_links.html_safe
  end

	def active? path
		"active" if current_page? path
	end

  def alerts
    alert = (flash[:alert] || flash[:error] || flash[:notice])

    if alert
      alert_generator alert
    end
  end

  def alert_generator msg
    js add_gritter(msg, title: "Linards Berzins Portfolio", sticky: false)
  end


end


































