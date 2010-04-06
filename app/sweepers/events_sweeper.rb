class EventsSweeper < ActionController::Caching::Sweeper
  observe Event
  
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
    expire_fragment 'happenings/attend'
    expire_fragment 'happenings/speak'
  end
end