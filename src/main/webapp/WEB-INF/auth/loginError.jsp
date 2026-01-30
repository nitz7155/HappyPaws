<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>행복한 발자국 - 로그인 오류</title>
	<%@include file="/head.jsp"%>
	<link rel="stylesheet" href="/resources/css/auth.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<main>
		<h1>로그인 오류</h1>
		<p>로그인 기능에 오류가 생겼습니다.</p>
		<a href="/auth/login">로그인 화면으로 돌아가기</a>
		<p>에러: ${error}</p>
	</main>
	<%@include file="/footer.jsp" %>
</body>
</html>