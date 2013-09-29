require 'spec_helper'

describe "Tags" do
  context "Chack tags for correct work" do
    context "Post" do
      before(:each) do
        UsersMacros.create_admin
        @post = PostsMacros.create_post_for(User.root)
      end

      it "One Post for testing" do
        Post.count.should eq 1
      end

      it "Tags should works" do
        ActsAsTaggableOn::Tagging.all.count.should eq 0
        ActsAsTaggableOn::Tag.all.count.should     eq 0

        @post.tag_list = "awesome, slick, hefty"
        @post.save
        @post.reload
        
        @post.tags.should_not be_empty
        @post.tag_counts.should_not be_empty
        @post.inline_tags.should eq "awesome, slick, hefty"

        Post.tagged_with("awesome").should_not be_empty

        ActsAsTaggableOn::Tagging.all.count.should eq 3
        ActsAsTaggableOn::Tag.all.count.should     eq 3
      end

      it "Broken tags" do
        @post.tag_list = "awesome, slick.exe, hefty"
        @post.save
        @post.reload

        @post.tag_list.should    eq ["awesome", "slick", "exe", "hefty"]
        @post.inline_tags.should eq "awesome, slick, exe, hefty"
      end

      # it "Tags with scope should works" do
      #   ActsAsTaggableOn::Tagging.all.count.should eq 0
      #   ActsAsTaggableOn::Tag.all.count.should     eq 0

      #   @post.set_tag_list_on("pubs", "same, as, tag, list")
      #   @post.tag_list_on("pubs").should eq ["same", "as", "tag", "list"]
        
      #   @post.save
      #   @post.reload

      #   @post.tags_on("pubs").should_not be_empty
      #   @post.tag_counts_on("pubs").should_not be_empty
      #   Post.tagged_with("same", on: "pubs").count.should eq 1

      #   ActsAsTaggableOn::Tagging.all.count.should eq 4
      #   ActsAsTaggableOn::Tag.all.count.should     eq 4
      # end
    end
  end
end