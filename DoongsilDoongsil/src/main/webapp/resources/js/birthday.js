  // select box 연도 , 월 표시
  $(document).ready(function () {
    var dt = new Date();
    var com_year = dt.getFullYear();

    // 년도
    // 올해 기준으로 -50년부터 +1년을 보여준다.
    var year = "";
    $("#year").append("<option value=''>년도</option>");
    for (var y = (com_year - 50); y <= (com_year + 1); y++) {
      $("#year").append("<option value='" + y + "'>" + y + " 년" + "</option>");
    }

    // 월(1월부터 12월)
    var month;
    $("#month").append("<option value=''>월</option>");
    for (var i = 1; i <= 12; i++) {
      $("#month").append("<option value='" + i + "'>" + i + " 월" + "</option>");
    }

    // 일(1일부터 31일)
    var day;
    $("#day").append("<option value=''>일</option>");
    for (var i = 1; i <= 31; i++) {
      $("#day").append("<option value='" + i + "'>" + i + " 일" + "</option>");
    }

  })
