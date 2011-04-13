class Admin::SettingsController < ApplicationController
  
  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
    :when => (Radiant::Config['roles.settings'].split(',').collect{|s| s.strip.underscore }.map(&:to_sym) rescue :admin || :admin),
    :denied_url => { :controller => 'admin/pages', :action => 'index' },
    :denied_message => "You must have admin privileges to manage application settings."
  
  def index
    @settings = Radiant::Config.find_all_as_tree
  end
  
  def new
    @setting = Radiant::Config.new
  end
  
  def create
    @setting = Radiant::Config.find_or_create_by_key(params[:setting]['key'])
    @setting.update_attributes(params[:setting])
    flash[:notice] = t('settings_extension.notices.create.success', :setting => @setting.key)
    redirect_to admin_settings_url
  end

  def edit
    @setting = Radiant::Config.find(params[:id])
  end

  def update
    Radiant::Config.find(params[:id]).update_attribute(:value, params[:setting][:value])
    redirect_to admin_settings_url
  end

  def destroy
    @setting = Radiant::Config.find(params[:id])
    @key = @setting.key
    @setting.destroy
    flash[:notice] = t('settings_extension.notices.destroy.success', :setting => @key)
    redirect_to admin_settings_url
  end

end
