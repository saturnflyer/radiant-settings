require File.dirname(__FILE__) + '/../../../spec_helper'

describe "Settings Tags" do
  scenario :users_and_pages

  describe "<r:config:setting>" do
    it "should render the Radiant::Config setting specified by the required 'key' attribute." do
      page.should render('<r:config:setting key="title" />').as(Radiant::Config['title'])
    end

    it "should render nothing without the required 'key' attribute." do
      page.should render('<r:config:setting />').as('')
    end
  end

end