module CurrentUserConcern
	extend ActiveSupport::Concern

  def current_user
  	super || guest_user
  end

  def guest_user
  	@guest_user ||= GuestUser.new
  end
end