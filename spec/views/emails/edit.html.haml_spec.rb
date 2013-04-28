require 'spec_helper'

describe "emails/edit" do
  before(:each) do
    @email = assign(:email, stub_model(Email,
      :address => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit email form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", email_path(@email), "post" do
      assert_select "input#email_address[name=?]", "email[address]"
      assert_select "input#email_description[name=?]", "email[description]"
    end
  end
end
