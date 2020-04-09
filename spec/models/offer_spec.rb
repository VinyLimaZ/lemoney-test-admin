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
      subject { build(:offer) }
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

  describe '#toggle_state' do
    subject { offer.enabled? }
    before { offer.toggle_state }

    context 'if admin alredy disabled the offer' do
      let(:offer) { create(:offer, :disabled) }

      context 'it will enable it' do
        it { is_expected.to be true }
      end
    end

    context 'if admin didnt explicit disabled the offer' do
      let(:offer) { create(:offer) }
      context 'it will disables it' do
        it { is_expected.to be false }
      end
    end

    context 'if admin explicit enabled the offer' do
      let(:offer) { create(:offer, :enabled) }

      context 'it will disables it' do
        it { is_expected.to be false }
      end
    end
  end

  describe '#enabled?' do
    subject { offer.enabled? }

    context 'if admin explicit disables the offer' do
      let(:offer) { create(:offer, :disabled) }

      it { is_expected.to be false }
    end

    context 'if the offer isnt disabled' do
      context 'and the offer isnt started' do
        let(:offer) { create(:offer, :not_started_yet) }

        it { is_expected.to be false }
      end

      context 'the offer already started' do
        context 'but already ended' do
          let(:offer) { create(:offer, :already_ended) }

          it { is_expected.to be false }
        end

        context 'and isnt ended yet' do
          let(:offer) { create(:offer) }

          it { is_expected.to be true }
        end
      end
    end
  end

  describe '#finished?' do
    subject { offer.finished? }

    context 'if the offer is in time' do
      let(:offer) { create(:offer, ends_at: Date.current + 1.day) }

      it { is_expected.to be false }
    end

    context 'if the offer is on time' do
      let(:offer) { create(:offer, ends_at: Date.current) }

      it { is_expected.to be false }
    end

    context 'if doesnt have an end' do
      let(:offer) { create(:offer, :without_ends_at) }
      it { is_expected.to be false }
    end

    context 'if the offer not on time' do
      let(:offer) { create(:offer, ends_at: Date.current - 1.day) }

      it { is_expected.to be true }
    end
  end

  describe '#not_started?' do
    subject { offer.not_started? }
    context 'if the offer is in time' do
      let(:offer) { create(:offer, starts_at: Date.current - 1.day) }

      it { is_expected.to be false }
    end

    context 'if the offer is on time' do
      let(:offer) { create(:offer, starts_at: Date.current) }

      it { is_expected.to be false }
    end

    context 'if the offer is not on time' do
      let(:offer) { create(:offer, starts_at: Date.current + 1.day) }

      it { is_expected.to be true }
    end
  end
end
