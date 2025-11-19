module BlogsHelper
	def gravatar_helper user
		image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 40
	end

  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      language = language.present? ? language.to_sym : :text
      CodeRay.scan(code, language).div
    end

    def link(link, title, content)
      title_attr = title.present? ? " title=\"#{title}\"" : ""
      "<a href=\"#{link}\"#{title_attr} target=\"_blank\" rel=\"noopener noreferrer\">#{content}</a>"
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)

    options = {
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      lax_html_blocks: true,
    }

    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
	end

	def blog_color_status blog
    'border: 2px solid #e50000;
     border-radius: 2px;
     padding:0 5px 0 5px;
     box-sizing: inherit;' if blog.draft?
  end
end
