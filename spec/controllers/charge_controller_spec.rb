require 'rails_helper'

RSpec.describe ChargeController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      get :new
      expect(response).to render_template :new
    end

    it 'instantiates @stripe_btn_data' do
      get :new
      expect(assigns(:stripe_btn_data)).not_to be_nil
    end
  end

  describe 'POST create' do
    it 'changes current_user role to premium' do
      before do
        current_user.role = :standard
        current_user.save
      end
      post :create, charge: { customer: Faker::Internet.email, amount: 15_00, description: 'Membership', currency: 'usd' }
      expect(current_user.role).to eql('premium')
    end

    it 'redirects to a new wiki' do
      post :create, charge: { customer: Faker::Internet.email, amount: 15_00, description: 'Membership', currency: 'usd' }
      expect(response).to redirect_to [new_wiki_path]
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user) }
    it 'triggers set_standard_role on destroy' do
      expect(user).to receive(:set_standard_role).at_least(:once)
      delete :destroy
    end

    it 'triggers publicize on destroy' do
      expect(user).to receive(:publicize).at_least(:once)
      delete :destroy
    end

    it 'redirects back' do
      delete :destroy
      expect(response).to redirect_to :back
    end
  end
end
