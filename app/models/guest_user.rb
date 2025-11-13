# Plain Ruby Object for guest users - no database access required
class GuestUser
	attr_accessor :name, :first_name, :last_name, :email, :id

	def initialize
		@id = nil
		@name = "Guest User"
		@first_name = "Guest"
		@last_name = "User"
		@email = "guest@example.com"
	end

	# Match User model interface for compatibility
	def persisted?
		false
	end

	def new_record?
		true
	end

	# Petergate authorization compatibility - guest users have no roles
	def has_roles?(*roles)
		false
	end

	def roles
		[]
	end
end