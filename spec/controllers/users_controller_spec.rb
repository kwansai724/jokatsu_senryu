require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    it "正常にレスポンスを返すこと" do
      get :index
      expect(response).to be_successful
    end

    it "200レスポンスを返すこと" do
      get :index
      expect(response).to have_http_status "200"
    end
  end
end
