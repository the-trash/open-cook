require 'spec_helper'

describe "Post" do
  context "Post and Comments" do
    before(:each) do
      TestCases.admin_blogger_hubs
      @admin = User.with_role(:admin).first 
      @user  = User.with_role(:blogger).first
      @post  = PostsMacros.create_post_for @user
      CommentsMacros.create_comments_for(@post, @admin)
    end

    it "Post should have 3 coments" do
      Comment.count.should eq 3
      @post.comments.count.should eq 3
    end

    it "Post should be draft and has 3 draft comments" do
      @post.comments.with_state(:draft).count.should eq 3
      @post.draft_comments_count.should eq 3
    end

    it "Comment of draft publication should be draft" do
      @post.state.should                    eq "draft"
      @post.commentable_state.should        eq "draft"

      @post.comments.where(commentable_state: :draft).count.should      eq 3
      @post.comments.where(commentable_state: :published).count.should  eq 0
    end

    it "Post moved to published state" do
      @post.to_published
      @post.comments.where(commentable_state: :draft).count.should      eq 0
      @post.comments.where(commentable_state: :published).count.should  eq 3
    end
  end
end