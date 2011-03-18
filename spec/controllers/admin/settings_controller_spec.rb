require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::SettingsController do
  dataset :users
  
  before(:each) do
    @parts = mock_model(Radiant::Config)
    @parts.stub!(:key).and_return('defaults.page.parts')
    @parts.stub!(:value).and_return('body, extended')
    @title = mock_model(Radiant::Config)
    @title.stub!(:key).and_return('admin.title')
    @title.stub!(:value).and_return('Radiant CMS')
  end
  
  it "should require login" do
    logout
    lambda { get :index }.should                require_login
    lambda { get :show, :id => 1 }.should       require_login
    lambda { get :new }.should                  require_login
    lambda { post :create}.should               require_login
    lambda { get :edit, :id => 1 }.should       require_login
    lambda { put :update, :id => 1 }.should     require_login
    lambda { delete :destroy, :id => 1 }.should require_login
  end

  describe "non-admin user" do
    before :each do
      login_as :non_admin
    end

    def redirects_to_pages
      response.should be_redirect
      response.should redirect_to(admin_pages_path)
      flash[:error].should == 'You must have admin privileges to manage application settings.'
    end

    it 'should not have access to the index action' do get :index end
    it 'should not have access to the show action' do get :show, :id => 1 end
    it 'should not have access to the new action' do get :new end
    it 'should not have access to the create action' do post :create end
    it 'should not have access to the edit action' do get :edit, :id => 1 end
    it 'should not have access to the update action' do put :update, :id => 1 end
    it 'should not have access to the destroy action' do delete :destroy, :id => 1 end

    after :each do
      redirects_to_pages
    end
  end
  
  describe "admin user" do
    before :each do
      login_as :admin
    end
  
    describe 'GET /admin/settings' do
      before do
        @tree = {
          'admin' => {
            'title' => @title
          },
          'defaults' => {
            'page' => {
              'parts' => @parts
            }
          }
        }
      end

      it "should fetch all settings" do
        Radiant::Config.should_receive(:find_all_as_tree).and_return(@tree)
        get :index
        assigns[:settings].should_not be_nil
        response.should be_success
      end
    end

    describe "GET /admin/settings/new" do
      it "should show a new setting form" do
        get :new
        response.should be_success
      end
    end

    describe "GET /admin/settings/:id/edit" do
      it "should fetch the desired setting" do
        Radiant::Config.should_receive(:find).with('123').and_return(@parts)
        get :edit, :id => '123'
        assigns[:setting].should == @parts
        response.should be_success
      end
    end

    describe "PUT /admin/settings/:id" do
      it "should update an existing setting" do
        Radiant::Config.should_receive(:find).with('123').and_return(@parts)
        @parts.should_receive(:update_attribute).with(:value, 'body, sidebar')
      
        put :update, :id => '123', :setting => { :value => 'body, sidebar' }
        response.should redirect_to(admin_settings_path)
      end
    end

    describe "DELETE /admin/setting/:id" do
      it "should destroy the desired setting" do
        Radiant::Config.should_receive(:find).with('123').and_return(@parts)
        @parts.should_receive(:destroy)
        delete :destroy, :id => '123'
        response.should redirect_to(admin_settings_path)
      end
    end

  end
  
end
