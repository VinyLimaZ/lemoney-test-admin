# frozen_string_literal: true

feature 'Admin enable/disable an offer' do
  context 'Admin clicks on disable offer' do
    context 'offer is on right time' do
      let!(:offer) { create(:offer, :enabled) }

      scenario 'offer becomes disable even if is on time' do
        visit offers_path

        click_link 'Disable offer'

        expect(page).to have_text('State was successfully changed')
        expect(page).to have_text('Disabled')
      end
    end
  end

  context 'admin clicks on enable offer' do
    context 'it\'s disabled but it\'s on time' do
      let!(:offer) { create(:offer, :disabled) }
      scenario 'offer becomes enabled' do
        visit offers_path

        click_link 'Enable offer'

        expect(page).to have_text('State was successfully changed')
        expect(page).to have_text('Enabled')
      end
    end
  end

  context 'admin clicks on enable offer' do
    context 'but it isn\'t on time' do
      let!(:offer) { create(:offer, :already_ended, enabled: nil) }
      scenario 'offer becomes enabled' do
        visit offers_path

        click_link 'Enable offer'

        expect(page).to have_text('State was successfully changed')
        expect(page).to have_text('Disabled')
      end
    end
  end
end
