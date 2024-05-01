class RakutenService
   # 楽天市場商品検索APIを使用して商品を検索する
   def self.search_items(keyword)
    # RakutenWebService::Ichiba::Item.search は楽天市場商品検索APIをラップしたメソッドです
    results = RakutenWebService::Ichiba::Item.search(keyword: keyword)

    # APIからのレスポンスをそのまま返すか、必要に応じて加工して返す
    results.map do |item|
        {
          name: item['itemName'],
          price: item['itemPrice'],
          url: item['itemUrl'],
          image_url: item['mediumImageUrl']
        }
    end
  end
end