class Portfolio < ApplicationRecord
	validates_presence_of :title, :body, :main_image, :thumb_image

	scope :emails, -> { where(subtitle: 'Emails') }

	after_initialize :set_defaults

	def set_defaults
		self.main_image ||= "https://placeholdit.co//i/600x400?&bg=f9e267&fc=000000&text=Portfolio%20item"
		self.thumb_image ||= "https://placeholdit.co//i/350x200?&bg=99eeff&fc=000000&text=Thumb%20Item"
	end
end
