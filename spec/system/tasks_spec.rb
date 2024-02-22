require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '登録機能' do

    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content '書類作成'
        second_task = FactoryBot.create(:second_task)
        visit tasks_path
        expect(page).to have_content 'メール送信'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '登録済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        second_task = FactoryBot.create(:second_task)
        visit tasks_path
        expect(page).to have_table
        expect(page).to have_content(task.title)
        expect(page).to have_content(second_task.title)
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
        task = FactoryBot.create(:task)
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
