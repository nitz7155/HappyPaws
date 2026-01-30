<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>행복한 발자국 - 닉네임 변경</title>
	<%@include file="/head.jsp"%>
	<link rel="stylesheet" href="/resources/css/auth.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<main>
		<div class="auth-form">
			<h3>닉네임 변경</h3>
			<p>이미 있는 닉네임입니다. 다른 닉네임을 입력해주세요.</p>
			<form action="/auth/snsReJoin" method="post" name="change_nick_form">
				<div>
					<input type="text" name="new_nickname" placeholder="닉네임 입력" value="${snsUser.us_nick}" required>
					<input type="button" value="닉네임 중복 검사">
				</div>
				<p class="error-message">닉네임 중복 검사를 해주세요.</p>
				<div><input type="submit" value="네이버 회원으로 가입하기"></div>
			</form>
		</div>
	</main>
	<%@include file="/footer.jsp" %>
	<script src="/resources/js/auth.js"></script>
</body>
</html>