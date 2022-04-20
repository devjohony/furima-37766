require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    # ユーザー情報
    it '全て正しく入力されれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameがないと登録できない' do
      @user.nickname = nil
      @user.valid?
      
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスがないと登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意性でないと登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'メールアドレスは@がない登録できない' do
      @user.email = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードがないと登録できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードが5文字以下では登録できない' do
      @user.password = 'aaaaa'
      @user.password_confirmation = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードは確認用を含めて2回入力しないと登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    # it "新規登録・ログイン共にエラーハンドリングができていること" do

    # end

    # 本人情報確認
    it '苗字がない場合は登録できない' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it '名前がない場合は登録できない' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it '苗字は英語では入力できない' do
      @user.first_name = 'Kate'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name Full-width characters')
    end

    it '氏名は英語では入力できない' do
      @user.last_name = 'Smith'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name Full-width characters')
    end

    it '苗字カナがない場合は登録できない' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it '氏名カナがない場合は登録できない' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it '苗字のフリガナは平仮名は使えない' do
      @user.first_name_kana = 'たなか'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
    end

    it '苗字のフリガナは漢字は使えない' do
      @user.first_name_kana = '田中'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
    end

    it '苗字のフリガナは英語は使えない' do
      @user.first_name_kana = 'tanaka'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
    end

    it '氏名のフリガナは平仮名は使えない' do
      @user.last_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
    end

    it '氏名のフリガナは漢字は使えない' do
      @user.last_name_kana = '太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
    end

    it '氏名のフリガナは英語は使えない' do
      @user.last_name_kana = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
    end

    it '生年月日がないと登録できない' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end