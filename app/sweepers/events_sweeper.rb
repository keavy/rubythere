class EventsSweeper < ActionController::Caching::Sweeper
  observe Event
  observe Happening

  def after_create(record)
    expire_cache(record)
  end

  def after_update(record)
    expire_cache(record)
  end

  def after_destroy(record)
    expire_cache(record)
  end

  private
  def expire_cache(record)
    expire_fragment 'events/attend'
    expire_fragment 'events/speak'
    expire_fragment 'events/archive'
  end
end