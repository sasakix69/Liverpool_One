# CarrierWaveの設定呼び出し
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_DEFAULT_REGION'],
    }
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'oneliverpool'
    config.cache_storage = :fog
    config.asset_host = 'https://s3.amazonaws.com/oneliverpool'
    # リソースを非公開状態でアップロード
    config.fog_public = false
  end
end