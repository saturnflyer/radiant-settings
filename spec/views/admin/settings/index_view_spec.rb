require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/settings/index" do
  before do
    assigns[:template_name] = 'index'
    
    @parts = mock_model(Radiant::Config)
    @parts.stub!(:key).and_return('defaults.page.parts')
    @parts.stub!(:value).and_return('body, extended')
    @parts.stub!(:description).and_return('foo')
    @parts.stub!(:protected?).and_return(false)
    @parts.stub!(:protected_value).and_return('body, extended')
    
    @title = mock_model(Radiant::Config)
    @title.stub!(:key).and_return('admin.title')
    @title.stub!(:value).and_return('Radiant CMS')
    @title.stub!(:description).and_return('bar')
    @title.stub!(:protected?).and_return(false)
    @title.stub!(:protected_value).and_return('Radiant CMS')
    
    @password = mock_model(Radiant::Config)
    @password.stub!(:key).and_return('account.password')
    @password.stub!(:value).and_return('super secret')
    @password.stub!(:description).and_return('password')
    @password.stub!(:protected?).and_return(true)
    @password.stub!(:protected_value).and_return('********')
    
    assigns[:settings] = {
      'admin' => {
        'title' => @title
      },
      'defaults' => {
        'page' => {
          'parts' => @parts
        }
      },
      'account' => {
        'password' => @password
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
  
  it "should display password settings as '********'" do
    response.should have_tag('tr') do
      with_tag('td','Password')
      with_tag('td', '********')
    end
  end
end
