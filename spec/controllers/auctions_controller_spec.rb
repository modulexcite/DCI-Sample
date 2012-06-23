require 'spec_helper'

describe AuctionsController do
  describe "post 'CREATE'" do
    let(:current_user){stub}

    let(:auction_params){
      AuctionParams.new(item_name: 'name')
    }

    let(:request_params){
      {auction_params: {item_name: 'name'}}
    }

    before :each do
      controller.should_receive(:current_user).and_return(current_user)
    end

    context "successful" do
      let(:auction){stub(id: 1)}

      it "should render path to created auction" do
        CreateAuction.should_receive(:create).with(current_user, auction_params).and_return({auction: auction})
        xhr :post, :create, request_params
        response.body.should == {auction_path: auction_path(auction.id)}.to_json
      end
    end

    context "failed" do
      let(:errors){["error1"]}

      it "should render errors" do
        CreateAuction.should_receive(:create).and_return({errors: errors})
        xhr :post, :create, request_params
        response.body.should == {errors: errors}.to_json
      end
    end
  end
end
