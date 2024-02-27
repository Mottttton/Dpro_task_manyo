require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        visit new_task_path
        fill_in('task_title', with: 'new task')
        fill_in('task_content', with: 'new task')
        fill_in('task_deadline_on', with: "2022-02-28")
        select('低', from: 'task_priority')
        select('未着手', from: 'task_status')
        click_button('登録する')
        task_list = all('body tbody tr')
        expect(page).to have_table
        expect(task_list.first.text).to have_text('new task')
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
        task_list = all('body tbody tr')
        expect(page).to have_table
        expect(task_list.first.text).to have_text('first_task')
        expect(task_list.last.text).to have_text('third_task')
      end
    end
    context '新たにタスクを作成した場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('body tbody tr')
        expect(task_list.first.text).not_to have_text("latest")
        expect(task_list.first.text).to have_text("first_task")

        visit new_task_path
        fill_in('task_title', with: 'latest')
        fill_in('task_content', with: 'latest task')
        fill_in('task_deadline_on', with: '2024-03-01')
        select('低', from: 'task_priority')
        select('未着手', from: 'task_status')
        click_button('登録する')
        task_list_after_creating_task = all('body tbody tr')
        expect(page).to have_table
        expect(task_list_after_creating_task.first.text).to have_text("latest")
        expect(task_list_after_creating_task.first.text).not_to have_text("first_task")
      end
    end
  end

  describe 'ソート機能' do
    let!(:first_task) { FactoryBot.create(:first_task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }

    before do
      visit tasks_path
    end

    context '「終了期限」というリンクをクリックした場合' do
      it "終了期限昇順に並び替えられたタスク一覧が表示される" do
        task_list_before_ordering = all('body tbody tr')
        expect(task_list_before_ordering[0].text).to have_text('first_task')
        expect(task_list_before_ordering[1].text).to have_text('second_task')
        expect(task_list_before_ordering[2].text).to have_text('third_task')
        click_link('終了期限')
        sleep(0.5)
        task_list_after_ordering = all('body tbody tr')
        expect(task_list_after_ordering[0].text).to have_text('third_task')
        expect(task_list_after_ordering[1].text).to have_text('second_task')
        expect(task_list_after_ordering[2].text).to have_text('first_task')
      end
    end
    context '「優先度」というリンクをクリックした場合' do
      it "優先度の高い順に並び替えられたタスク一覧が表示される" do
        task_list_before_ordering = all('body tbody tr')
        expect(task_list_before_ordering[0].text).to have_text('first_task')
        expect(task_list_before_ordering[1].text).to have_text('second_task')
        expect(task_list_before_ordering[2].text).to have_text('third_task')
        click_link('優先度')
        sleep(0.5)
        task_list_after_ordering = all('body tbody tr')
        expect(task_list_after_ordering[0].text).to have_text('second_task')
        expect(task_list_after_ordering[1].text).to have_text('first_task')
        expect(task_list_after_ordering[2].text).to have_text('third_task')
      end
    end
  end

  describe '検索機能' do
    let!(:first_task) { FactoryBot.create(:first_task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }

    before do
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索ワードを含むタスクのみ表示される" do
        task_list_before_search = all('body tbody tr')
        expect(task_list_before_search.count).to eq 3
        expect(page).to have_content('first_task')
        expect(page).to have_content('second_task')
        expect(page).to have_content('third_task')

        fill_in('search_title', with: 'first')
        click_button('検索')
        task_list_after_search = all('body tbody tr')
        expect(task_list_after_search.count).to eq 1
        expect(page).to have_content('first_task')
        expect(page).not_to have_content('second_task')
        expect(page).not_to have_content('third_task')
      end
    end
    context 'ステータスで検索した場合' do
      it "検索したステータスに一致するタスクのみ表示される" do
        task_list_before_search = all('body tbody tr')
        expect(task_list_before_search.count).to eq 3
        expect(page).to have_content('first_task')
        expect(page).to have_content('second_task')
        expect(page).to have_content('third_task')

        select('未着手', from: 'search_status')
        click_button('検索')
        task_list_after_search = all('body tbody tr')
        expect(task_list_after_search.count).to eq 1
        expect(page).to have_content('first_task')
        expect(page).not_to have_content('second_task')
        expect(page).not_to have_content('third_task')

        select('着手中', from: 'search_status')
        click_button('検索')
        task_list_after_search = all('body tbody tr')
        expect(task_list_after_search.count).to eq 1
        expect(page).not_to have_content('first_task')
        expect(page).to have_content('second_task')
        expect(page).not_to have_content('third_task')

        select('完了', from: 'search_status')
        click_button('検索')
        task_list_after_search = all('body tbody tr')
        expect(task_list_after_search.count).to eq 1
        expect(page).not_to have_content('first_task')
        expect(page).not_to have_content('second_task')
        expect(page).to have_content('third_task')
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
      end
    end
    context 'タイトルとステータスで検索した場合' do
      it "検索ワードをタイトルに含み、かつステータスに一致するタスクのみ表示される" do
        task_list_before_search = all('body tbody tr')
        expect(task_list_before_search.count).to eq 3
        expect(page).to have_content('first_task')
        expect(page).to have_content('second_task')
        expect(page).to have_content('third_task')

        select('未着手', from: 'search_status')
        fill_in('search_title', with: 'first')
        click_button('検索')
        task_list_after_search = all('body tbody tr')
        expect(task_list_after_search.count).to eq 1
        expect(page).to have_content('first_task')
        expect(page).not_to have_content('second_task')
        expect(page).not_to have_content('third_task')

        select('着手中', from: 'search_status')
        fill_in('search_title', with: 'first')
        click_button('検索')
        expect(page).not_to have_content('first_task')
        expect(page).not_to have_content('second_task')
        expect(page).not_to have_content('third_task')
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
        expect(page).to have_text(task.created_at.strftime("%Y/%m/%d %H:%M"))
        expect(page).to have_text(task.deadline_on.strftime("%Y/%m/%d"))
        expect(page).to have_text(task.priority)
        expect(page).to have_text(task.status)
        second_task = FactoryBot.create(:second_task)
        visit task_path(second_task.id)
        expect(page).to have_text(second_task.title)
        expect(page).to have_text(second_task.content)
        expect(page).to have_text(second_task.created_at.strftime("%Y/%m/%d %H:%M"))
        expect(page).to have_text(second_task.deadline_on.strftime("%Y/%m/%d"))
        expect(page).to have_text(second_task.priority)
        expect(page).to have_text(second_task.status)
      end
    end
  end
end
