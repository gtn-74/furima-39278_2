require 'rails_helper'
RSpec.describe User, type: :model do
  # FactoryBot.build(:user)の記述をbeforeに集約
  # user.カラムのuserを@userに変更
  before  do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12346'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
                                                      "パスワードは6文字以上で入力してください"
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは128文字以内で入力してください")
      end

      it 'passwordは英数字混合でなければ登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは、文字と数字を含んでください'
      end
      it 'passwordは英数字混合でなければ登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは、文字と数字を含んでください'
      end
      it 'passwordは全角では登録できない' do
        @user.password = 'パスワード111'
        @user.password_confirmation = 'パスワード111'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは、文字と数字を含んでください'
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字は、半角カタカナは入力できません"
      end

      it 'family_nameが半角では登録できない' do
        @user.family_name = 'ｵｳｷﾞﾀﾆ'
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字は、半角カタカナは入力できません"
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include "名前は、半角カタカナは入力できません"
      end

      it 'first_nameが半角では登録できない' do
        @user.first_name = 'ﾘｮｳｽｹ'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前は、半角カタカナは入力できません"
      end

      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字ふりがなは、カタカナ以外で登録できません"
      end

      it 'family_name_kanaが全角では登録できない' do
        @user.family_name_kana = '扇谷'
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字ふりがなは、カタカナ以外で登録できません"
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include  "名前ふりがなは、カタカナ以外で登録できません"
      end
      it 'first_name_kanaが全角では登録できない' do
        @user.first_name_kana = '諒祐'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前ふりがなは、カタカナ以外で登録できません"
      end

      it '生年月日が空では登録できない' do
        @user.birth_day = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include '誕生日を入力してください'
      end
      it '重複したemailが存在なら登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Eメールはすでに存在します'
      end
    end
  end
end
