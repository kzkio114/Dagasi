require 'rakuten_web_service'

RakutenWebService.configure do |c|
  c.application_id = ENV['RAKUTEN_APP_ID']
  # 任意でアフィリエイトIDも設定可能です
  c.affiliate_id = ENV['RAKUTEN_AFF_ID'] if ENV['RAKUTEN_AFF_ID']
end