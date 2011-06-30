class EventsSweeper < ActionController::Caching::Sweeper
  observe Event, Happening

  def expire_cached_content(record)
    expire_fragment(:fragment => 'attend')
    expire_fragment(:fragment => 'speak')
    expire_fragment(:fragment => 'archive')
  end

  alias_method :after_save, :expire_cached_content
  alias_method :after_destroy, :expire_cached_content
  alias_method :after_update, :expire_cached_content
end