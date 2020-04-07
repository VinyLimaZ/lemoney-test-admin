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
      describe 'verify_url' do
        context 'a really broken URL returns a error' do
          subject { build(:offer, url: 'ttps://www.googlecom\n') }
          it { is_expected.not_to be_valid }

          before { subject.valid? }
          it { expect(subject.errors.full_messages).to include('Invalid URL, please verify and try again') }
        end
      end
    end
  end

  describe '#url=' do
    context 'sanitize the URL to fix little problems' do
      subject { build(:offer, url: 'ttps://www.google.com') }

      it { is_expected.to be_valid }
      it { expect(subject.url).to eq('https://www.google.com') }
    end
  end
end
