require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    # 一覧表示機能を最初のbeforeに記していく
    before do
      # ①ユーザーAを作成しておく（テストデータの準備）
      # 定義した:userファクトリを指定してUserオブジェクトの作成と登録を行う
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      # ①作成者がユーザーAであるタスクを作成しておく（テストデータの準備）
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    end
    context 'ユーザーAがログインしているとき' do
      before do
        # ②ユーザーAでログインする(前提となっているユーザー操作をしておく)
        # 1. visit [URL] 特定のURLでアクセスする
        visit login_path
        # 2. fill_in テキストフィールドに値を入れる（メールアドレスという<labal＞がついたテキストフィールド<input>要素にメールアドレスを入れる）
        fill_in 'メールアドレス', with: 'a@example.com'
        # 3. （パスワードを入力する）
        fill_in 'パスワード', with: 'password'
        # 4. click_button ボタンを押す（「ログインする」ボタンを押す）
        click_button 'ログインする'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        # ③作成済みのタスクの名称が画面上に表示されていることを確認
        # 画面内に特定の内容（beforeで登録するようにしたユーザーAが作成者になっているタスク）が存在するか検査
        # page(画面)に「最初のタスク」という内容があることを期待する
        # ※have_contentの部分はマッチャ(Matcher)と呼ばれている
        expect(page).to have_content '最初のタスク'
      end
    end
  end
end