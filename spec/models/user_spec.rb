require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:wikis) }
  it { is_expected.to have_many(:collaborations) }
  it { is_expected.to have_many(:collab_wikis) }

  describe 'attributes' do
    it 'should have email attribute' do
      expect(user).to have_attributes(email: user.email)
    end

    it 'responds to role' do
      expect(user).to respond_to(:role)
    end

    it 'responds to admin?' do
      expect(user).to respond_to(:admin?)
    end

    it 'responds to standard?' do
      expect(user).to respond_to(:standard?)
    end

    it 'responds to premium?' do
      expect(user).to respond_to(:premium?)
    end
  end

  describe 'roles' do
    it 'is standard by default' do
      expect(user.role).to eql('standard')
    end

    context 'standard user' do
      it 'returns true for #standard?' do
        expect(user.standard?).to be_truthy
      end

      it 'returns false for #admin?' do
        expect(user.admin?).to be_falsey
      end
    end

    context 'admin user' do
      before do
        user.role = 'admin'
        # user.save
      end

      it 'returns false for #standard?' do
        expect(user.standard?).to be_falsey
      end

      it 'returns true for #admin?' do
        expect(user.admin?).to be_truthy
      end
    end

    context 'premium user' do
      before do
        user.role = 'premium'
        user.save
      end

      it 'returns false for #standard?' do
        expect(user.standard?).to be_falsey
      end

      it 'returns true for #premium?' do
        expect(user.premium?).to be_truthy
      end
    end
  end

  describe 'invalid user' do
    let(:user_with_invalid_email) { build(:user, email: '') }

    it 'should be an invalid user due to blank email' do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe 'init on initialize' do
    it 'triggers init on initialize' do
      expect(user).to receive(:init).at_least(:once)
      User.find(user.id)
    end
  end

  describe '.downgrade' do
    before do
      user.role = :premium
      user.save
    end

    it 'returns false for #standard?' do
      expect(user.standard?).to be_falsey
    end

    it 'returns true for #premium?' do
      expect(user.premium?).to be_truthy
    end

    before do
      user.downgrade
    end

    it 'returns false for #premium?' do
      expect(user.premium?).to be_falsey
    end

    it 'returns true for #standard?' do
      expect(user.standard?).to be_truthy
    end
  end

  describe '.publicize' do
    let(:wiki) { create(:wiki, user: user, private: true) }

    it 'returns true for #private?' do
      expect(wiki.private?).to be_truthy
    end

    before do
      user.publicize
    end

    it 'returns false for #private?' do
      expect(wiki.private?).to be_falsey
    end
  end
end

# 4 failures, publicize doesn't turn true
# user isn't upgrading to premium first in downgrade test
# do I need to create a new instance of user for "init" to work?
