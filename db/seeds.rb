# db/seeds.rb
items = [
  { name: 'スーパーマリオブラザーズ', category: 'game' },
  { name: 'ゼルダの伝説', category: 'game' },
  { name: 'ドラゴンクエスト', category: 'game' },
  { name: 'ファイナルファンタジー', category: 'game' },
  { name: 'パックマン', category: 'game' },
  { name: 'ストリートファイターII', category: 'game' },
  { name: 'メタルギア', category: 'game' },
  { name: 'ボンバーマン', category: 'game' },
  { name: 'ソニック・ザ・ヘッジホッグ', category: 'game' },
  { name: 'ロックマン', category: 'game' },
  { name: 'ダイヤブロック', category: 'toy' },
  { name: 'ケンダマ', category: 'toy' },
  { name: 'ベイブレード', category: 'toy' },
  { name: 'トランスフォーマー', category: 'toy' },
  { name: 'リカちゃん', category: 'toy' },
  { name: 'プラレール', category: 'toy' },
  { name: 'ミニ四駆', category: 'toy' },
  { name: 'スーパーボール', category: 'toy' },
  { name: 'ヨーヨー', category: 'toy' },
  { name: 'ジャンプロープ', category: 'toy' },
  # その他のアイテムを追加...
]

items.each do |item|
  Item.create(name: item[:name], category: item[:category])
end