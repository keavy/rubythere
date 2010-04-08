class Admin::PresentationsController < AdminAreaController
  resource_controller
  
  [create, update].each { |action| action.wants.html {redirect_to admin_presentations_path} }
  
  def create
    if params[:presentation][:speaker_attributes]
      params[:presentation][:speaker_attributes].each do |h|
        unless h[1]["speaker_id"].blank?
          h[1].delete("speaker_attributes")
        end
      end
    end
    if params[:presentation][:talk_attributes]
      params[:presentation][:talk_attributes].each do |h|
        unless h[1]["talk_id"].blank?
          h[1].delete("talk_attributes")
        end
      end
    end
    @presentation = Presentation.new(params[:presentation])
    if @presentation.save
      flash[:notice] = "Presentation successfully added"
      redirect_to admin_presentations_path
    else
      render :action => :new
    end
  end
  
end
