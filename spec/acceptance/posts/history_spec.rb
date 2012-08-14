require 'spec_helper'

describe "Posts history" do

  context "when a user already created a post" do
    let(:user) do
      Crowdblog::TestRunner::Models.create_user
    end

    let!(:post) do
      Crowdblog::TestRunner::Models.create_post :post, author: user
    end

    before do

    end

    it "should see 1 revision" do

    end
  end
end
