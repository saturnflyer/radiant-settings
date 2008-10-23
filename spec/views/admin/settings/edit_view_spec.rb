require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/settings/:id/edit" do
  before do
    @parts = mock_model(Radiant::Config)
    @parts.stub!(:key).and_return('defaults.page.parts')
    @parts.stub!(:value).and_return('body, extended')
    @parts.stub!(:description).and_return('foo')
    @parts.stub!(:protected?).and_return(false)
    @parts.stub!(:protected_value).and_return('body, extended')
    
    assigns[:setting] = @parts
    
    render 'admin/settings/edit'
  end
  
  it "should have a heading of with setting key that is being edited" do
    response.should have_tag('h2.setting-name', 'defaults.page.parts')
  end
  
  it "should have a description" do
    response.should have_tag('div.description', 'foo')
  end
  
  it "should have a form" do
    response.should have_tag('form') do |form|
      form.should have_tag('input', :value => 'body, extended')
    end
  end
end
