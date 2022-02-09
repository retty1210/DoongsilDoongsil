<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지도 API</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=41c4fe4ada289883c25325091a1e27aa&libraries=services,clusterer,drawing"></script>
</head>
<body>

<div id="map" style="width:50%;height:500px;"></div>

<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.50665779534792, 126.95280650000001), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도생성   
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체 생성
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표 검색
geocoder.addressSearch('서울특별시 동작구 상도1동 강남초등길 15', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명 표시
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">학교위치</div>'
        });
        infowindow.open(map, marker);

        // 지도중심을 결과값으로 받은 위치로 이동
        map.setCenter(coords);
    } 
});    
</script>
</body>
</html>