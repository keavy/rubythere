class PresentationsSweeper < ActionController::Caching::Sweeper
  observe Presentation
  
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
    expire_fragment "presentations/h_#{record.happening_id}"
  end
end