class EventsSweeper < ActionController::Caching::Sweeper
  observe Event, Happening

  def expire_cached_content(record)
    expire_fragment(:fragment => 'events/attend')
    expire_fragment(:fragment => 'events/speak')
    expire_fragment(:fragment => 'events/archive')
  end

  alias_method :after_save, :expire_cached_content
  alias_method :after_destroy, :expire_cached_content
  alias_method :after_update, :expire_cached_content
end