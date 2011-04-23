class UserObserver < ActiveRecord::Observer
  def after_create(user)
    Mailer.new_user_notification(user).deliver
  end
end
