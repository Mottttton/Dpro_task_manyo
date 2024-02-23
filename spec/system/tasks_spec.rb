require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        visit new_task_path
        fill_in('task_title', with: 'new task')
        fill_in('task_content', with: 'new task')
        click_button('登録する')
        task_list = all('body tr')
        expect(page).to have_table
        expect(task_list[1].text).to have_text('new task')
      end
    end
  end

  describe '一覧表示機能' do
    let!(:first_task) { FactoryBot.create(:first_task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }

    before do
      visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '登録済みのタスク一覧が作成日時の降順で表示される' do
        task_list = all('body tr')
        expect(page).to have_table
        expect(task_list[1].text).to have_text('third_task')
        expect(task_list.last.text).to have_text('first_task')
      end
    end
    context '新たにタスクを作成した場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('body tr')
        expect(task_list[1].text).not_to have_text("latest")

        visit new_task_path
        fill_in('task_title', with: 'latest')
        fill_in('task_content', with: 'latest task')
        click_button('登録する')
        task_list = all('body tr')
        expect(page).to have_table
        expect(task_list[1].text).to have_text("latest")
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
        task = FactoryBot.create(:first_task)
        visit task_path(task.id)
        expect(page).to have_text(task.title)
        expect(page).to have_text(task.content)
        expect(page).to have_text(task.created_at)
        second_task = FactoryBot.create(:second_task)
        visit task_path(second_task.id)
        expect(page).to have_text(second_task.title)
        expect(page).to have_text(second_task.content)
        expect(page).to have_text(second_task.created_at)
      end
    end
  end
end
