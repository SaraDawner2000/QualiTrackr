require "rails_helper"

RSpec.describe "parts/new", type: :view do
  before(:each) do
    assign(:part, Part.new(
      number: "MyString",
      revision: "MyString",
      job: "MyString",
      drawing: "MyString",
      base_material: "MyString",
      finish: "MyString",
      measured_status: false
    ))
  end

  it "renders new part form" do
    render

    assert_select "form[action=?][method=?]", parts_path, "post" do
      assert_select "input[name=?]", "part[number]"

      assert_select "input[name=?]", "part[revision]"

      assert_select "input[name=?]", "part[job]"

      assert_select "input[name=?]", "part[drawing]"

      assert_select "input[name=?]", "part[base_material]"

      assert_select "input[name=?]", "part[finish]"

      assert_select "input[name=?]", "part[measured_status]"
    end
  end
end
