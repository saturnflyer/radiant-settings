require File.dirname(__FILE__) + '/../spec_helper'

describe Radiant::Config, 'find_all_as_tree' do
  before do
    @title  = Radiant::Config.create(:key => 'admin.title', :value => 'Radiant CMS')
    @parts  = Radiant::Config.create(:key => 'defaults.page.parts', :value => 'body, extended')
    @status = Radiant::Config.create(:key => 'defaults.page.status', :value => 'draft')
    @repetitive = Radiant::Config.create(:key => 'repetitive.setting.setting', :value => 'foo')
  end
  
  it "should find all settings and return a tree as a nested hash" do
    result = Radiant::Config.find_all_as_tree
    result['admin']['title'].should             == @title
    result['defaults']['page']['parts'].should  == @parts
    result['defaults']['page']['status'].should == @status
    result['repetitive']['setting']['setting'].should == @repetitive
  end
end