class Admin::SettingsController < ApplicationController
  
  def index
    @settings = Radiant::Config.find_all_as_tree
  end
  
  def edit
    @setting = Radiant::Config.find(params[:id])
  end
  
  def update
    Radiant::Config.find(params[:id]).update_attribute(:value, params[:setting][:value])
    redirect_to admin_settings_url
  end
  
end
