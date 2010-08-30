require 'test_helper'

class Admin::PresentationsControllerTest < ActionController::TestCase
  def setup
    @user     = Factory(:user, :admin => 1)
    login_as @user
    3.times {Factory(:presentation)}
  end
  
  context "on GET to :index" do
    setup do
      get :index
    end

    should respond_with(:success)
  end
  
  context "on GET to :new" do
     setup do
       get :new
     end

     should respond_with(:success)
   end

   context "on POST to :create" do
     context "with valid details" do
       setup do
         post :create, :presentation =>  {:keynote => 1,
                                         :speaker_attributes => Factory.attributes_for(:speaker),
                                         :talk_attributes => Factory.attributes_for(:talk)}
       end

       should_change('Presentation count by 1', :by => 1) { Presentation.count }
       should_redirect_to("admin presentations path") {admin_presentations_path}
       should "return no errors" do
         assert assigns(:presentation).errors.full_messages.to_sentence.blank?
       end
     end

     context "with existing talk details" do
       setup do
         @talk = Factory(:talk)
         post :create, :presentation =>  {:keynote => 1,
                                         :speaker_attributes => Factory.attributes_for(:speaker),
                                         :talk_attributes => {
                                           :title => '',
                                           :description => ''
                                         },
                                         :talk_id => @talk.id}
       end

       should_change('Presentation count by 1', :by => 1) { Presentation.count }
       should_redirect_to("admin presentations path") {admin_presentations_path}
       should "return no errors" do
         assert assigns(:presentation).errors.full_messages.to_sentence.blank?
       end
     end
   end
 
  
end
