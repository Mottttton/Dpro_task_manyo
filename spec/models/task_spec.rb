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
end
