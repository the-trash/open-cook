shared_examples "empty space" do
  describe "> Project" do
    it "should be clean" do
      User.count.should eq 0
      Post.count.should eq 0
      Hub.count.should  eq 0
    end
  end
end