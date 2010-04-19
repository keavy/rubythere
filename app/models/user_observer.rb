class UserObserver < ActiveRecord::Observer
  def after_create(user)
    Mailer.deliver_new_user_notification(user)
  end
end
