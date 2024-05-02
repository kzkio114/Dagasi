class RakutenService
    # 楽天市場商品検索APIを使用して商品を検索する
    def self.search_items(keyword)
      # RakutenWebService::Ichiba::Item.search は楽天市場商品検索APIをラップしたメソッドです
    results = RakutenWebService::Ichiba::Item.search(keyword: keyword)

      # APIからのレスポンスをランダムに並び替えてから加工
    results.to_a.shuffle.map do |item| #to_aとランダム性を持たせるためのshuffleを追加
        # 商品画像がある場合は最初の画像URLを使用し、ない場合はデフォルト画像URLを使用
        image_url = item.image_flag == 1 && item.medium_image_urls.any? ? item.medium_image_urls.first : 'path/to/default-image.png'

        {
          name: item.name,  # 商品名
          price: item.price,  # 価格
          url: item.affiliate_url,  # 商品のアフィリエイトURL
          image_url: image_url  # 商品画像URL
        }
    end
  end
end