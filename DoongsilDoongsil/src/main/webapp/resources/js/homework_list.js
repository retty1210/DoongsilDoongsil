//var pageNo = "${pageNo}";

$(document).ready(function() {
	$("table tbody tr").hide();
	//$("tr[name=homework_data_maincol]").show();
	var pageNo = $("#pageNo").val() * 1;
	console.log("현재페이지: " + pageNo);
	$("tr[name=homework_data_"+pageNo+"]").show();
	$("#page-item"+pageNo).addClass("active");
});

function prePage() {
	var pageNo = $("#pageNo").val() * 1;
	var preNo = pageNo - 1;
	if(preNo < 1) {
		preNo = 1;
	}
	var startpage = $("#startpage").val() * 1;
	console.log("이전페이지: " + preNo + " | 시작페이지: " + startpage);
	if(preNo >= startpage) {
		$("tr[name=homework_data_"+pageNo+"]").hide();
		$("tr[name=homework_data_"+preNo+"]").show();
		$("#pageNo").val(preNo);
		$("#page-item"+pageNo).removeClass("active");
		$("#page-item"+preNo).addClass("active");
	} else {
		location.href = "/homework?pageNo="+preNo;
	}
}

function nextPage() {
	var pageNo = $("#pageNo").val() * 1;
	console.log("pageNo" + pageNo);
	var nextNo = pageNo + 1;
	console.log("nextNo" + nextNo);
	var lastpage = $("#lastpage").val() * 1;
	console.log("다음페이지: " + nextNo + " | 마지막페이지: " + lastpage);
	if(nextNo <= lastpage) {
		$("tr[name=homework_data_"+pageNo+"]").hide();
		$("tr[name=homework_data_"+nextNo+"]").show();
		$("#pageNo").val(nextNo);
		$("#page-item"+pageNo).removeClass("active");
		$("#page-item"+nextNo).addClass("active");
	} else {
		location.href= "/homework?pageNo="+nextNo;
	}
}

function pageChange(e) {
	var newPage = e * 1;
	var pageNo = $("#pageNo").val() * 1;
	console.log("기존페이지: " + pageNo + " | 바꾸려는 페이지: " + newPage);
	$("tr[name=homework_data_"+pageNo+"]").hide();
	$("tr[name=homework_data_"+newPage+"]").show();
	$("#pageNo").val(newPage);
	$("#page-item"+pageNo).removeClass("active");
	$("#page-item"+newPage).addClass("active");
}