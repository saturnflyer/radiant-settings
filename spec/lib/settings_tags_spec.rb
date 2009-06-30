require File.dirname(__FILE__) + '/../spec_helper'

describe "Settings Tags" do
  dataset :users_and_pages

  describe "<r:config:setting>" do
    it "should render the Radiant::Config setting specified by the required 'key' attribute." do
      pages(:home).should render('<r:config:setting key="title" />').as(Radiant::Config['title'])
    end

    it "should error without the required 'key' attribute." do
      pages(:home).should render('<r:config:setting />').with_error("'key' attribute required")
    end
  end

end