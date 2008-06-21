require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/settings/index" do
  before do
    @parts = mock_model(Radiant::Config)
    @parts.stub!(:key).and_return('defaults.page.parts')
    @parts.stub!(:value).and_return('body, extended')
    @parts.stub!(:description).and_return('foo')
    
    @title = mock_model(Radiant::Config)
    @title.stub!(:key).and_return('admin.title')
    @title.stub!(:value).and_return('Radiant CMS')
    @title.stub!(:description).and_return('bar')
    
    assigns[:settings] = {
      'admin' => {
        'title' => @title
      },
      'defaults' => {
        'page' => {
          'parts' => @parts
        }
      }
    }
    
    render 'admin/settings/index'
  end
  
  it "should have a heading of 'Radiant Settings'" do
    response.should have_tag('h1', 'Radiant Settings')
  end
  
  it "should have a table listing all settings" do
    response.should have_tag('td', 'Defaults')
    response.should have_tag('td', 'Page')
    response.should have_tag('td', 'Parts')
    response.should have_tag('td', 'body, extended')
  end
end
