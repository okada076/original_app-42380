# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  "トマト", "きゅうり", "にんじん", "レモン", "さつまいも",
  "なす", "カボチャ", "すだち", "じゃがいも", "レタス", "その他"
].each do |name|
  Vegetable.find_or_create_by!(name: name)
end

# === トマトの作り方手順データを追加 ===
# トマトのIDを取得（既に登録済み前提）
tomato = Vegetable.find_by(name: "トマト")

# 手順がすでに存在しない場合のみ作成
growing_steps = [
  { step_number: 1, title: "種まき", content: "間隔をあけて種をまき、薄く土をかぶせます。" },
  { step_number: 2, title: "発芽・間引き", content: "双葉が出たら元気なものを残し、他は間引きます。" },
  { step_number: 3, title: "植え替え", content: "本葉が出たら鉢や畑に植え替えます。支柱を立てるとよいです。" },
  { step_number: 4, title: "水やり・肥料", content: "土が乾いたら水やり。2週間に1回程度液体肥料を与えます。" },
  { step_number: 5, title: "摘芯", content: "茎が支柱の高さに達したら、花房の上の葉を２枚残して、新しい葉が展開する芽を摘み取り伸長を止めます。" },
  { step_number: 6, title: "収穫", content: "実が赤くなったらハサミで切って収穫しましょう。" }
]

# 一度に作成（重複防止のためwhereで存在確認）
growing_steps.each do |step|
  GrowingStep.find_or_create_by!(
    vegetable_id: tomato.id,
    step_number: step[:step_number],
    title: step[:title],
    content: step[:content]
  )
end

# === にんじんの作り方手順 ===
carrot = Vegetable.find_by(name: "にんじん")

carrot_steps = [
  { step_number: 1, title: "種まき", content: "直まきで1cm間隔に種をまき、軽く土をかぶせます。" },
  { step_number: 2, title: "間引き", content: "本葉が2〜3枚出たら、元気なものを残して間引きます。" },
  { step_number: 3, title: "追肥・土寄せ", content: "間引き後に追肥と土寄せを行います。根の露出を防ぎます。" },
  { step_number: 4, title: "水やり", content: "乾燥に注意して、土の表面が乾いたらたっぷり水やりします。" },
  { step_number: 5, title: "収穫", content: "根の直径が3cm程度になったら引き抜いて収穫します。" }
]

carrot_steps.each do |step|
  GrowingStep.find_or_create_by!(
    vegetable_id: carrot.id,
    step_number: step[:step_number],
    title: step[:title],
    content: step[:content]
  )
end

# === きゅうりの作り方手順 ===
cucumber = Vegetable.find_by(name: "きゅうり")

cucumber_steps = [
  { step_number: 1, title: "種まき", content: "育苗ポットに2〜3粒まき、本葉2枚で1本に間引きます。" },
  { step_number: 2, title: "定植", content: "本葉4〜5枚でプランターや畑に植え替え、支柱を立てます。" },
  { step_number: 3, title: "水やり・肥料", content: "成長期は毎日水やり。10日に1回ほど追肥をします。" },
  { step_number: 4, title: "整枝", content: "子づる・孫づるを適宜整理して風通しをよくします。" },
  { step_number: 5, title: "収穫", content: "開花から5〜7日後が収穫適期。早めに収穫することで次の実が育ちやすくなります。" }
]

cucumber_steps.each do |step|
  GrowingStep.find_or_create_by!(
    vegetable_id: cucumber.id,
    step_number: step[:step_number],
    title: step[:title],
    content: step[:content]
  )
end
