# db/seeds.rb
items = [
  { name: 'ストリートファイターII', category: 'game' },
  { name: 'ロックマン', category: 'game' },
  { name: 'ケンダマ', category: 'toy' },
  { name: 'ベイブレード', category: 'toy' },
  { name: 'トランスフォーマー', category: 'toy' },
  { name: 'リカちゃん', category: 'toy' },
  { name: 'プラレール', category: 'toy' },
  { name: 'ミニ四駆', category: 'toy' },
  { name: 'スーパーボール', category: 'toy' },
  { name: 'ヨーヨー', category: 'toy' },
  # その他のアイテムを追加...
]

items.each do |item|
  Item.create(name: item[:name], category: item[:category])
end