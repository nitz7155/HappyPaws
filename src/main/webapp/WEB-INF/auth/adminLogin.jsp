<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@include file="/head.jsp" %>
	<link rel="stylesheet" href="/resources/css/auth.css">
</head>
<body>
	<%@include file="/header.jsp" %>
	<main>
		<div class="auth-form">
			<h3>관리자 로그인</h3>
			<form action="/auth/adminLogin" method="post">
				<div><input type="text" name="us_id" placeholder="아이디 입력" autofocus></div>
				<p class="error-message">아이디를 입력해주세요.</p>
				<div><input type="password" name="us_password" placeholder="비밀번호 입력"></div>
				<p class="error-message">비밀번호를 입력해주세요.</p>
				<div><input type="submit" value="로그인"></div>
			</form>
			<c:choose>
				<c:when test='${error == "id" }'>
					<p style="color: red;">아이디가 틀렸습니다.</p>
				</c:when>
				<c:when test='${error == "del" }'>
					<p style="color: red;">삭제된 계정입니다.</p>
				</c:when>
				<c:when test='${error == "password" }'>
					<p style="color: red;">비밀번호가 틀렸습니다.</p>
				</c:when>
				<c:when test='${error == "admin" }'>
					<p style="color: red;">관리자가 아닙니다.</p>
				</c:when>
			</c:choose>
		</div>
	</main>
	<%@include file="/footer.jsp" %>
</body>
</html>