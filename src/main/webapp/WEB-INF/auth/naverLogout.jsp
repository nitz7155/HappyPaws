<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>행복한 발자국</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
</head>
<body>
	<script>
		let naverLogoutWindow = window.open('https://nid.naver.com/nidlogin.logout?returl=https://www.naver.com/',"_blank" ,'네이버 앱');
	</script>
	<script defer>
		$.ajax({
			url : "/auth/logout/naver",
			type :  "GET",
			async : false,
			success : function(res){
				console.log('성공');
				alert('네이버에서 정상적으로 로그아웃 처리되었습니다.');
				closeWindow();
			},
			error : function(err){
				console.log('실패');
				alert('네이버에서 정상적으로 로그아웃 로그아웃 처리되지 않았습니다.');
			}
		});

		function closeWindow() {
			naverLogoutWindow.close();
			location.href = "/";
		}
	</script>
</body>
</html>