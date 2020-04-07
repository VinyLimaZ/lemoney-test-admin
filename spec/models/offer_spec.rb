# frozen_string_literal: true

describe Offer do
  describe 'validations' do
    context 'validates presence' do
      it { is_expected.to validate_presence_of(:advertiser_name) }
      it { is_expected.to validate_presence_of(:url) }
      it { is_expected.to validate_presence_of(:description) }
      it { is_expected.to validate_presence_of(:starts_at) }
    end

    context 'validates uniqueness' do
      subject { create(:offer) }
      it { is_expected.to validate_uniqueness_of(:advertiser_name) }
    end

    context 'validates length' do
      it { is_expected.to validate_length_of(:description).is_at_most(500) }
    end

    context 'custom validate' do
      describe 'valid_url' do
        subject { build(:offer, url: 'ttps://www.google.com') }
        it { is_expected.not_to be_valid }

        before { subject.valid? }
        it { expect(subject.errors.full_messages).to eq('Invalid URL, please verify and try again') }
      end
    end
  end
end
