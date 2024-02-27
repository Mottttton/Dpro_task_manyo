require 'rails_helper'

RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: '', content: '企画書を作成する。', deadline_on: '2024-04-01', priority: 0, status: 0)
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["タイトルを入力してください"]
      end
    end

    context 'タスクの説明が空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: '企画書', content: '', deadline_on: '2024-04-01', priority: 0, status: 0)
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["内容を入力してください"]
      end
    end
    context '終了期限が空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: '企画書', content: '企画書を作成する。', deadline_on: nil, priority: 0, status: 0)
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["終了期限を入力してください"]
      end
    end
    context '優先度が空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: '企画書', content: '企画書を作成する。', deadline_on: '2024-04-01', priority: nil, status: 0)
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["優先度を入力してください"]
      end
    end
    context 'ステータスが空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: '企画書', content: '企画書を作成する。', deadline_on: '2024-04-01', priority: 0, status: nil)
        expect(task).to be_invalid
        expect(task.errors.full_messages).to eq ["ステータスを入力してください"]
      end
    end

    context 'タスクの入力欄全てに値が入っている場合' do
      it 'タスクを登録できる' do
        task = Task.create(title: '企画書', content: '企画書を作成する。', deadline_on: '2024-04-01', priority: 0, status: 0)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:first_task) { FactoryBot.create(:first_task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索ワードを含むタスクが絞り込まれる" do
        tasks = Task.title_search('first')
        expect(tasks).to include(first_task)
        expect(tasks).not_to include(second_task)
        expect(tasks).not_to include(third_task)
        expect(tasks.count).to eq 1

        tasks = Task.title_search('second')
        expect(tasks).not_to include(first_task)
        expect(tasks).to include(second_task)
        expect(tasks).not_to include(third_task)
        expect(tasks.count).to eq 1

        tasks = Task.title_search('third')
        expect(tasks).not_to include(first_task)
        expect(tasks).not_to include(second_task)
        expect(tasks).to include(third_task)
        expect(tasks.count).to eq 1

        tasks = Task.title_search('task')
        expect(tasks).to include(first_task)
        expect(tasks).to include(second_task)
        expect(tasks).to include(third_task)
        expect(tasks.count).to eq 3
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        # 検索されたテストデータの数を確認する
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        tasks = Task.status_search(0)
        expect(tasks).to include(first_task)
        expect(tasks).not_to include(second_task)
        expect(tasks).not_to include(third_task)
        expect(tasks.count).to eq 1

        tasks = Task.status_search(1)
        expect(tasks).not_to include(first_task)
        expect(tasks).to include(second_task)
        expect(tasks).not_to include(third_task)
        expect(tasks.count).to eq 1

        tasks = Task.status_search(2)
        expect(tasks).not_to include(first_task)
        expect(tasks).not_to include(second_task)
        expect(tasks).to include(third_task)
        expect(tasks.count).to eq 1
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        # 検索されたテストデータの数を確認する
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索ワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        tasks = Task.title_status_search('first', 0)
        expect(tasks).to include(first_task)
        expect(tasks).not_to include(second_task)
        expect(tasks).not_to include(third_task)
        expect(tasks.count).to eq 1

        tasks = Task.title_status_search('first', 1)
        expect(tasks).not_to include(first_task)
        expect(tasks).not_to include(second_task)
        expect(tasks).not_to include(third_task)
        expect(tasks.count).to eq 0
      end
    end
  end
end
