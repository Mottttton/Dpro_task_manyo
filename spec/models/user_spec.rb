require 'rails_helper'

RSpec.describe 'ユーザモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: '', email: 'taro@sample.com', password: 'password', password_confirmation: 'password', admin: false)
        expect(user).to be_invalid
        expect(user.errors.full_messages).to eq ['名前を入力してください']
      end
    end

    context 'ユーザのメールアドレスが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'taro', email: '', password: 'password', password_confirmation: 'password', admin: false)
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include 'メールアドレスを入力してください'
      end
    end

    context 'ユーザのパスワードが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'taro', email: 'taro@sample.com', password: '', password_confirmation: 'password', admin: false)
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include 'パスワードを入力してください'
        expect(user.errors.full_messages).to include 'パスワードは6文字以上で入力してください'
      end
    end

    context 'ユーザのメールアドレスがすでに使用されていた場合' do
      it 'バリデーションに失敗する' do
        user1 = User.create(name: 'yamada taro', email: 'taro@sample.com', password: 'manyo_task', password_confirmation: 'manyo_task', admin: false)
        expect(user1).to be_valid
        user2 = User.create(name: 'tanaka taro', email: 'taro@sample.com', password: 'dpro_task', password_confirmation: 'dpro_task', admin: false)
        expect(user2).to be_invalid
        expect(user2.errors.full_messages).to eq ['メールアドレスはすでに使用されています']
      end
    end

    context 'ユーザのパスワードが6文字未満の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'taro', email: 'taro@sample.com', password: 'pass', password_confirmation: 'pass', admin: false)
        expect(user).to be_invalid
        expect(user.errors.full_messages).to eq ['パスワードは6文字以上で入力してください']
      end
    end

    context 'ユーザの名前に値があり、メールアドレスが使われていない値で、かつパスワードが6文字以上の場合' do
      it 'バリデーションに成功する' do
        user1 = User.create(name: 'yamada taro', email: 'yamadataro@sample.com', password: 'manyo_task', password_confirmation: 'manyo_task', admin: false)
        expect(user1).to be_valid
        user2 = User.create(name: 'tanaka taro', email: 'tanakataro@sample.com', password: 'manyo_task', password_confirmation: 'manyo_task', admin: false)
        expect(user2).to be_valid
      end
    end
  end
end
