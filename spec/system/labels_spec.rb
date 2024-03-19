require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  describe '登録機能' do
    let!(:first_user) { FactoryBot.create(:first_user) }
    before do
      visit new_session_path
      fill_in('session_email', with: 'taro@sample.com')
      fill_in('session_password', with: 'password')
      click_button('ログイン')
    end
    context 'ラベルを登録した場合' do
      it '登録したラベルが表示される' do
        click_link('ラベルを登録する')
        fill_in('label_name', with: 'work')
        click_button('登録する')
        expect(page).to have_text('ラベルを登録しました')
        expect(page).to have_text('work')
      end
    end
  end
  describe '一覧表示機能' do
    let!(:first_user) { FactoryBot.create(:first_user, :with_labels) }
    let!(:second_user) { FactoryBot.create(:second_user, :with_labels) }
    before do
      visit new_session_path
      fill_in('session_email', with: 'taro@sample.com')
      fill_in('session_password', with: 'password')
      click_button('ログイン')
    end
    context '一覧画面に遷移した場合' do
      it '登録済みのラベル一覧が表示される' do
        click_link('ラベル一覧')
        expect(page).to have_text("work")
        expect(page).not_to have_text("private")
      end
    end
  end
end
