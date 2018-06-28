require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe "GET index" do
    before do
      @tag1 = Tag.create!(:name => "tag1")
      @tag2 = Tag.create!(:name => "tag2")
    end

    it "returns JSON with tags by keyword" do
      get :index, :params => { :name => "tag" }, format: :json
      hash_body = nil

      expect{hash_body = JSON.parse(response.body)}.not_to raise_exception
      expect(hash_body.length).to eq(2)
      expect(hash_body[0].keys).to match_array(["_id", "article_ids", "name"])
      expect(hash_body[0]["_id"]["$oid"]).to eq(@tag1.id.to_s)
      expect(hash_body[1]["_id"]["$oid"]).to eq(@tag2.id.to_s)
    end

    it "returns empty JSON without keyword" do
      get :index, format: :json
      hash_body = nil

      expect{hash_body = JSON.parse(response.body)}.not_to raise_exception
      expect(hash_body).to eq([])
    end
  end
end
