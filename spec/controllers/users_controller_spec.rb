require 'spec_helper'

describe UsersController do
  describe "new" do
    it 'returns the new page' do
      get :new
      response.should be_success
    end
  end

  describe "GET#show" do
    context 'when a user is logged in' do

      before(:each) do
        @user = FactoryGirl.create(:user)
        login_user @user
      end

      it 'assigns the correct user' do
        get :show
        assigns(:user).should eq @user
      end

       it 'returns a page with users account details' do
        get :show
        response.should render_template(:show)
      end
    end

    context 'when a user is NOT logged in' do
      render_views
      it 'redirects them to the home page' do
        get :show
        response.should redirect_to(root_path)
      end
    end
  end

  describe "#create" do
    it "sends an email" do
      data = {
        full_name: 'Alice Smith',
        email: 'alice@example.com',
        display_name: 'alice',
        password: 'poet',
        password_confirmation: 'poet'
      }
      post :create, user: data
    end
  end
end
