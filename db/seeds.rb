# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

vegetables = [
  { name: "トマト", category: "果菜類" },
  { name: "きゅうり", category: "果菜類" },
  { name: "なす", category: "果菜類" },
  { name: "カボチャ", category: "果菜類" },

  { name: "にんじん", category: "根菜類" },
  { name: "さつまいも", category: "根菜類" },
  { name: "じゃがいも", category: "根菜類" },

  { name: "レモン", category: "果実類" },
  { name: "すだち", category: "果実類" },

  { name: "レタス", category: "葉菜類" },

  { name: "その他", category: "その他" }
]

vegetables.each do |v|
  veg = Vegetable.find_or_initialize_by(name: v[:name])
  veg.category = v[:category]
  veg.save!
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


# === レモンの作り方手順 ===
lemon = Vegetable.find_by(name: "レモン")

lemon_steps = [
  { step_number: 1, title: "苗の植え付け", content: "日当たりと水はけの良い場所に苗を植えます。" },
  { step_number: 2, title: "水やり", content: "土が乾いたらたっぷり水を与えます。夏は朝夕の2回が理想。" },
  { step_number: 3, title: "追肥", content: "春と秋に肥料を与えます。柑橘専用肥料が効果的です。" },
  { step_number: 4, title: "剪定", content: "風通しを良くするため、混み合った枝を剪定します。" },
  { step_number: 5, title: "収穫", content: "果皮が黄色く色づいたら収穫します。" }
]

lemon_steps.each do |step|
  GrowingStep.find_or_create_by!(
    vegetable_id: lemon.id,
    step_number: step[:step_number],
    title: step[:title],
    content: step[:content]
  )
end

sweet_potato = Vegetable.find_by(name: "さつまいも")

sweet_potato_steps = [
  { step_number: 1, title: "苗の植え付け", content: "つるを30cm間隔で植え付け、土を軽くかぶせます。" },
  { step_number: 2, title: "水やり", content: "植え付け後はたっぷり水を与えますが、その後は乾燥気味に育てます。" },
  { step_number: 3, title: "つる返し", content: "地面に触れたつるから根が出るのを防ぐため、つるを持ち上げます。" },
  { step_number: 4, title: "追肥", content: "必要に応じて、植え付け1ヶ月後に軽く追肥します。" },
  { step_number: 5, title: "収穫", content: "植え付けから約4ヶ月後、葉が黄色くなったら収穫時です。" }
]

sweet_potato_steps.each do |step|
  GrowingStep.find_or_create_by!(
    vegetable_id: sweet_potato.id,
    step_number: step[:step_number],
    title: step[:title],
    content: step[:content]
  )
end

eggplant = Vegetable.find_by(name: "なす")

eggplant_steps = [
  { step_number: 1, title: "苗の植え付け", content: "日当たりの良い場所に株間40cmで植え付け、支柱を立てます。" },
  { step_number: 2, title: "水やり", content: "水を好むため、毎日たっぷり水を与えます。" },
  { step_number: 3, title: "整枝", content: "主枝と2本の側枝を残し、他は摘み取ります。" },
  { step_number: 4, title: "追肥", content: "2〜3週間おきに追肥を行います。" },
  { step_number: 5, title: "収穫", content: "開花から20日ほどで実が大きくなったら収穫します。" }
]

eggplant_steps.each do |step|
  GrowingStep.find_or_create_by!(
    vegetable_id: eggplant.id,
    step_number: step[:step_number],
    title: step[:title],
    content: step[:content]
  )
end

pumpkin = Vegetable.find_by(name: "カボチャ")

pumpkin_steps = [
  { step_number: 1, title: "種まき", content: "ポットに2〜3粒まき、本葉2枚で1本に間引きます。" },
  { step_number: 2, title: "定植", content: "本葉4〜5枚で畑に植え、株間は80cm以上取ります。" },
  { step_number: 3, title: "整枝", content: "親づる1本仕立てにして、子づるは摘み取ります。" },
  { step_number: 4, title: "人工授粉", content: "確実な結実のため、開花時に人工授粉を行います。" },
  { step_number: 5, title: "収穫", content: "受粉後40〜50日で果皮が固くなり、巻きひげが枯れたら収穫します。" }
]

pumpkin_steps.each do |step|
  GrowingStep.find_or_create_by!(
    vegetable_id: pumpkin.id,
    step_number: step[:step_number],
    title: step[:title],
    content: step[:content]
  )
end

sudachi = Vegetable.find_by(name: "すだち")

sudachi_steps = [
  { step_number: 1, title: "苗木の植え付け", content: "日当たりと水はけの良い場所に、春または秋に植え付けます。" },
  { step_number: 2, title: "水やり", content: "乾燥しすぎないよう、特に夏場はこまめに水やりします。" },
  { step_number: 3, title: "剪定", content: "毎年冬に不要な枝を剪定し、風通しを良くします。" },
  { step_number: 4, title: "施肥", content: "冬と春に緩効性肥料を株元に施します。" },
  { step_number: 5, title: "収穫", content: "8月〜10月にかけて果実が青いうちに収穫します。" }
]

sudachi_steps.each do |step|
  GrowingStep.find_or_create_by!(
    vegetable_id: sudachi.id,
    step_number: step[:step_number],
    title: step[:title],
    content: step[:content]
  )
end


potato = Vegetable.find_by(name: "じゃがいも")

potato_steps = [
  { step_number: 1, title: "種芋の植え付け", content: "芽が出た種芋をカットして、切り口を乾燥させてから植えます。" },
  { step_number: 2, title: "芽かき", content: "芽が出たら強い芽を1〜2本残して他は摘み取ります。" },
  { step_number: 3, title: "土寄せ", content: "芽が伸びたら数回に分けて土を寄せ、芋が露出しないようにします。" },
  { step_number: 4, title: "追肥", content: "土寄せのタイミングで軽く追肥を行います。" },
  { step_number: 5, title: "収穫", content: "花が咲いたあと、茎葉が枯れてきたら収穫のサインです。" }
]

potato_steps.each do |step|
  GrowingStep.find_or_create_by!(
    vegetable_id: potato.id,
    step_number: step[:step_number],
    title: step[:title],
    content: step[:content]
  )
end

lettuce = Vegetable.find_by(name: "レタス")

lettuce_steps = [
  { step_number: 1, title: "種まき", content: "育苗ポットに種をまき、発芽適温（15〜20℃）で管理します。" },
  { step_number: 2, title: "間引き", content: "本葉2〜3枚で1本に間引きます。" },
  { step_number: 3, title: "定植", content: "本葉4〜5枚で畑やプランターに植え替え、株間25cm程度とります。" },
  { step_number: 4, title: "水やり", content: "乾燥しないように管理しますが、水のやりすぎには注意します。" },
  { step_number: 5, title: "収穫", content: "結球タイプは球が締まったら、リーフタイプは外葉から順次収穫します。" }
]

lettuce_steps.each do |step|
  GrowingStep.find_or_create_by!(
    vegetable_id: lettuce.id,
    step_number: step[:step_number],
    title: step[:title],
    content: step[:content]
  )
end
