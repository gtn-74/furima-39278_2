require 'rails_helper'
RSpec.describe Item, type: :model do
  describe '商品出品登録' do
    before do
      
      @item = FactoryBot.build(:item)
    end

    context '商品登録ができる場合' do
      it '全ての項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
      context '商品登録ができない場合' do
        it '商品画像が空では登録できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include "画像を入力してください"
        end
        it '商品名が空では録できない' do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "商品名を入力してください"
        end
        it '商品説明文が空では登録できない' do
          @item.content = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "商品紹介文を入力してください"
        end
        it 'カテゴリが1では登録できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include "カテゴリーは空では登録できません"
        end
        it '商品状態が1では登録できない' do
          @item.sale_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include "状態は空では登録できません"
        end
        it '配送費の負担が1では登録できない' do
          @item.shopping_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include "配送料は空では登録できません"
        end
        it '地域が1では登録できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include "地域は空では登録できません"
        end
        it '発送日数が1では登録できない' do
          @item.shopping_day_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include "発送日数は空では登録できません"
        end
        it '販売価格が空では登録できない' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "金額を入力してください", "金額は数値で入力してください"
        end
        it '販売価格が全角では登録できない' do
          @item.price = '５５５５'
          @item.valid?
          expect(@item.errors.full_messages).to include "金額は数値で入力してください"
        end
        it '販売価格が300円未満では出品できない' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include "金額は300以上の値にしてください"
        end
        it '販売価格が10,000,000円を超過すると出品できない' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include "金額は9999999以下の値にしてください"
        end
        it 'userが紐づいていない場合登録できない' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include "ユーザーを入力してください"
        end
      end
    end
  end
end
