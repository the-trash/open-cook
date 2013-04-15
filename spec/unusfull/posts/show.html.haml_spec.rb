require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :user_id => 1,
      :author => "Author",
      :keywords => "Keywords",
      :description => "Description",
      :copyright => "Copyright",
      :title => "Title",
      :raw_content => "MyText",
      :content => "MyText",
      :main_image_url => "Main Image Url",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Author/)
    rendered.should match(/Keywords/)
    rendered.should match(/Description/)
    rendered.should match(/Copyright/)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Main Image Url/)
    rendered.should match(/State/)
  end
end
