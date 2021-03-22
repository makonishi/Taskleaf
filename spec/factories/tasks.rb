FactoryBot.define do
  factory :task do
    name { 'テストを書く'}
    description {'RSpec&Capybara&FactoryBotを準備する'}
    # :userという名前のFactoryをTaskモデルに定義されたuserという名前の関連を生成するのに利用する
    user
  end
end