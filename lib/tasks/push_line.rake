require 'date'

namespace :push_line do
  desc 'LINEBOT : 試合開始前の通知'
  task push_line_message: :environment do
    message = {
      type: 'text',
      text: 'まもなく試合が始まります！   Youll Never Walk Alone✊🔴'
    }

    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end

    # 対戦クラブの試合時間10分前　ここから
    Brighton_Hove_Albion_FC = Time.local(2022, 10, 1, 22, 50)
    Rangers_FC = Time.local(2022, 10, 5, 3, 50)
    Arsenal_FC = Time.local(2022, 10, 10, 00, 20)
    Rangers_FC_2 = Time.local(2022, 10, 13, 3, 50)
    Manchester_City_FC = Time.local(2022, 10, 17, 00, 20)
    West_Ham_United_FC = Time.local(2022, 10, 20, 3, 20)
    Nottingham_Forest_FC = Time.local(2022, 10, 22, 20, 20)
    AFC_Ajax = Time.local(2022, 10, 27, 3, 50)
    Leeds_United_FC = Time.local(2022, 10, 29, 22, 50)
    SSC_Napoli = Time.local(2022, 11, 2, 4, 50)
    Tottenham_Hotspur_FC = Time.local(2022, 11, 7, 1, 20)
    Southampton_FC = Time.local(2022, 11, 12, 23, 50)
    Aston_Villa_FC = Time.local(2022, 12, 26, 23, 50)
    Leicester_City_FC = Time.local(2022, 12, 31, 23, 50)
    Brentford_FC = Time.local(2023, 1, 2, 23, 50)
    Brighton_Hove_Albion_FC_2 = Time.local(2023, 1, 14, 23, 50)
    Chelsea_FC = Time.local(2023, 1, 21, 23, 50)
    Wolverhampton_Wanderers_FC = Time.local(2023, 2, 4, 23, 50)
    Everton_FC = Time.local(2023, 2, 11, 23, 50)
    Newcastle_United_FC = Time.local(2023, 2, 18, 23, 50)
    Crystal_Palace_FC = Time.local(2023, 2, 25, 23, 50)
    Manchester_United_FC = Time.local(2023, 3, 4, 23, 50)
    AFC_Bournemouth = Time.local(2023, 3, 11, 23, 50)
    Fulham_FC = Time.local(2023, 3, 18, 23, 50)
    Manchester_City_FC_2 = Time.local(2023, 4, 1, 22, 50)
    Arsenal_FC_2 = Time.local(2023, 4, 8, 22, 50)
    Leeds_United_FC_2 = Time.local(2023, 4, 15, 22, 50)
    Nottingham_Forest_FC_2 = Time.local(2023, 4, 22, 22, 50)
    West_Ham_United_FC_2 = Time.local(2023, 4, 26, 3, 35)
    Tottenham_Hotspur_FC_2 = Time.local(2023, 4, 29, 22, 50)
    Brentford_FC_2 = Time.local(2023, 5, 6, 22, 50)
    Leicester_City_FC_2 = Time.local(2023, 5, 13, 22, 50)
    Aston_Villa_FC_2 = Time.local(2023, 5, 20, 22, 50)
    Southampton_FC_2 = Time.local(2023, 5, 28, 23, 50)
    # 対戦クラブの試合時間10分前　ここまで
    time = Time.now
    SEC_PER_MIN = 60
    time = Time.at(time.to_i / SEC_PER_MIN * SEC_PER_MIN)

    case time
    when Brighton_Hove_Albion_FC, Rangers_FC, Arsenal_FC, Rangers_FC_2, Manchester_City_FC, West_Ham_United_FC,
         Nottingham_Forest_FC, AFC_Ajax, Leeds_United_FC, SSC_Napoli, Tottenham_Hotspur_FC, Southampton_FC, Aston_Villa_FC,
         Leicester_City_FC, Brentford_FC, Brighton_Hove_Albion_FC_2, Chelsea_FC, Wolverhampton_Wanderers_FC, Everton_FC,
         Newcastle_United_FC, Crystal_Palace_FC, Manchester_United_FC, AFC_Bournemouth, Fulham_FC, Manchester_City_FC_2,
         Arsenal_FC_2, Leeds_United_FC_2, Nottingham_Forest_FC_2, West_Ham_United_FC_2, Tottenham_Hotspur_FC_2, Brentford_FC_2,
         Leicester_City_FC_2, Aston_Villa_FC_2, Southampton_FC_2
      p client.broadcast(message)
    end
  end
end
