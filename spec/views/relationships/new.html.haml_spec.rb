require 'spec_helper'

describe "relationships/new" do
  before(:each) do
    assign(:relationship, stub_model(Relationship,
      :invitor_id => 1,
      :invitee_id => 1,
      :state => "MyString"
    ).as_new_record)
  end

  it "renders new relationship form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", relationships_path, "post" do
      assert_select "input#relationship_invitor_id[name=?]", "relationship[invitor_id]"
      assert_select "input#relationship_invitee_id[name=?]", "relationship[invitee_id]"
      assert_select "input#relationship_state[name=?]", "relationship[state]"
    end
  end
end
