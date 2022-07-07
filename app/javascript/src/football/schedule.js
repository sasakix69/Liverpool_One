$(document).on('turbolinks:load', function() {
  $.ajaxSetup({
    headers : {"X-Auth-Token" : gon.football_info}
  });
  $.getJSON("https://api.football-data.org/v2/teams/64/matches?status=SCHEDULED", function(data_PL) {
    //JSON取得後の処理
    game_list = data_PL.matches;
    games_num = data_PL.count;

    var youbi = ["日", "月", "火", "水", "木", "金", "土"];
    var date, jdate;
    var jtime = "";

    for (var i = 0; i < games_num; i++) {
      // 日時を日本時間に変換
      date = new Date(game_list[i].utcDate);
      date = date.toLocaleString("ja-JP");
      jdate = new Date(date);
      jtime = (jdate.getHours() + ':' + ("0" + jdate.getMinutes()).slice(-2)); // キックオフ時刻をX:XX表記にする
      //日程表にデータを挿入
      $("#matches-tbl").append(
      '<tr align="center">'
      + '<td><img src="https://crests.football-data.org/' + game_list[i].homeTeam.id + '.svg" height="30">'
      + '<br />'
      + game_list[i].homeTeam.name + '</td>'
      + '<td class="' + game_list[i].td_class + '">'
      + (jdate.getMonth() + 1) + '/' + jdate.getDate() + '(' + youbi[jdate.getDay()] + ')'
      + '<br />' + jtime + '</td>'
      + '<td><img src="https://crests.football-data.org/' + game_list[i].awayTeam.id + '.svg" height="30">'
      + '<br />'
      + game_list[i].awayTeam.name + '</td>'
      + '</tr>'
      );
    }
  });
});