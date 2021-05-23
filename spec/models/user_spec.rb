require 'rails_helper'

RSpec.describe User, type: :model do
  it 'アカウント名、表示名、メールがあれば有効な状態であること' do
    user = User.new(
      short_name: 'oniki',
      display_name: '新奥大介',
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
    expect(user).to be_valid
  end

  it 'アカウント名がなければ無効な状態であること' do
    user = User.new(short_name: nil)
    user.valid?
    expect(user.errors[:short_name]).to include('を入力してください')
  end

  it '表示名がなければ無効な状態であること' do
    user = User.new(display_name: nil)
    user.valid?
    expect(user.errors[:display_name]).to include('を入力してください')
  end

  it 'メールがなければ無効な状態であること' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it 'パスワードがなければ無効な状態であること' do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
  end

  it 'アカウント名が最大文字数を超えれば無効な状態であること' do
    user = User.new(short_name: 'a' * (User::SHORT_NAME_MAX + 1))
    user.valid?
    expect(user.errors[:short_name]).to include("は#{User::SHORT_NAME_MAX}文字以内で入力してください")
  end

  it 'アカウント名が最小文字数に満たなければ無効な状態であること' do
    user = User.new(short_name: 'a' * (User::SHORT_NAME_MIN - 1))
    user.valid?
    expect(user.errors[:short_name]).to include("は#{User::SHORT_NAME_MIN}文字以上で入力してください")
  end

  it '表示名が最大文字数を超えれば無効な状態であること' do
    user = User.new(display_name: 'a' * (User::DISPLAY_NAME_MAX + 1))
    user.valid?
    expect(user.errors[:display_name]).to include("は#{User::DISPLAY_NAME_MAX}文字以内で入力してください")
  end

  it 'メールが最大文字数を超えれば無効な状態であること' do
    user = User.new(email: 'a' * (User::EMAIL_MAX + 1))
    user.valid?
    expect(user.errors[:email]).to include("は#{User::EMAIL_MAX}文字以内で入力してください")
  end

  it 'パスワードが最小文字数に満たなければ無効な状態であること' do
    password = 'a' * (User::PASSWORD_MIN - 1)
    user = User.new(password: password, password_confirmation: password)
    user.valid?
    expect(user.errors[:password]).to include("は#{User::PASSWORD_MIN}文字以上で入力してください")
  end

  it '有効なメールフォーマットでなければ無効な状態であること' do
    user = User.new(email: 'test@test,com')
    user.valid?
    expect(user.errors[:email]).to include('は不正な値です')
  end

  it '重複するメールアドレスがあれば無効な状態であること' do
    user = User.create(
      short_name: 'hoge',
      display_name: 'ほげ',
      email: 'same@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
    expect(user).to be_valid
    other_user = User.new(
      short_name: 'hoge',
      display_name: 'ほげ',
      email: 'same@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
    other_user.valid?
    expect(other_user.errors[:email]).to include('はすでに存在します')
  end
end
