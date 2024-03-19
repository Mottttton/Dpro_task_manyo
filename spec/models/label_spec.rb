require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'バリデーションのテスト' do
    let!(:first_user) { FactoryBot.create(:first_user) }
    context 'ラベルの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        label = first_user.labels.build(name: '')
        expect(label).to be_invalid
        expect(label.errors.full_messages).to eq ['名前を入力してください']
      end
    end

    context 'ラベルの名前に値があった場合' do
      it 'バリデーションに成功する' do
        label = first_user.labels.build(name: 'work')
        expect(label).to be_valid
      end
    end
  end
end
