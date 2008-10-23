require File.dirname(__FILE__) + "/../../spec_helper"
require File.dirname(__FILE__) + "/../../../settings_extension"

describe Radiant::AdminUI do
  before :each do
    @admin = Radiant::AdminUI.new
  end
  
  it "should have a settings Region Set" do
    @admin.should respond_to(:settings)
  end
  
  it "should should have regions for the 'index'" do\
    @admin.settings.index.should_not be_nil
  end
  
  it "should have 'top, bottom' regions in the 'index main' region" do
    @admin.settings.index.main.should == %w{top bottom}
  end
end