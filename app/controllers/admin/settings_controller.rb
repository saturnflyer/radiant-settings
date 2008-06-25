class Admin::SettingsController < ApplicationController
  
  only_allow_access_to :new, :create, :destroy
    :when => :admin,
    :denied_url => {:action => 'index'},
    :denied_message => "See your administrator if you'd like to create a new setting."
  
  def index
    @settings = Radiant::Config.find_all_as_tree
  end
  
  def new
  end
  
  def create
    Radiant::Config.find_or_create_by_key(params[:setting]['key']).update_attributes(params[:setting])
    redirect_to admin_settings_url
  end
  
  def edit
    @setting = Radiant::Config.find(params[:id])
  end
  
  def update
    Radiant::Config.find(params[:id]).update_attribute(:value, params[:setting][:value])
    redirect_to admin_settings_url
  end
  
end
