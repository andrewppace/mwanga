require 'spec_helper'

describe "relationships/show" do
  before(:each) do
    @relationship = assign(:relationship, stub_model(Relationship,
      :invitor_id => 1,
      :invitee_id => 2,
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/State/)
  end
end
