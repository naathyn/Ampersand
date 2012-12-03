require 'spec_helper'

describe OpinionsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:micropost) { FactoryGirl.create(:micropost) }

  before { sign_in user }

  describe "creating a like with Ajax" do

    it "should increment the Opinion count" do
      expect do
        xhr :post, :create, opinion: { like_id: micropost.id }
      end.to change(Opinion, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, opinion: { like_id: micropost.id }
      response.should be_success
    end
  end

  describe "destroying an opinion with Ajax" do

    before { user.like!(micropost) }
    let(:opinion) { user.opinions.find_by_like_id(micropost) }

    it "should decrement the Opinion count" do
      expect do
        xhr :delete, :destroy, id: opinion.id
      end.to change(Opinion, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: opinion.id
      response.should be_success
    end
  end
end
