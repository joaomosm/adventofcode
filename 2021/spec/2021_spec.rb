require File.dirname(__FILE__) + '/rspec_helper'

context "2021" do
  
  it "return the correct result" do
    expect(LeClass.print).to be(3)
  end
end