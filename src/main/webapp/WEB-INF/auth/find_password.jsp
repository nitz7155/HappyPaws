<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>행복한 발자국 - 비밀번호 찾기</title>
	<%@include file="/head.jsp"%>
	<link rel="stylesheet" href="../../resources/css/auth.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<main>
		<div class="auth-form">
			<h3>비밀번호 찾기</h3>
			<form action="/auth/find_password" method="post" name="findPwForm">
				<div id="user_authentication">
					<div><input type="text" name="us_id" id="us_id" placeholder="아이디 입력" autofocus></div>
					<p class="error-message">아이디를 입력해주세요.</p>

					<div><input type="text" name="us_name" id="us_name" placeholder="이름 입력"></div>
					<p class="error-message">이름을 입력해주세요.</p>

					<div>
						<input type="text" name="us_phone" id="us_phone" placeholder="전화번호 입력">
						<input type="button" value="전화번호 인증">
					</div>
					<p class="error-message">전화번호 인증을 받아주세요.</p>
					<div id="us_phone_auth_div" style="display: none;">
						<input type="text" name="us_phone_auth_code" id="us_phone_auth_code" placeholder="인증번호 입력" maxlength="6">
						<span class="timer" id="timer">05:00</span>
						<input type="button" value="인증번호 확인">
					</div>

					<input type="button" value="비밀번호 찾기" onclick="check_user()">
				</div>
		
				<div id="password_change" style="display: none;">
					<div><input type="password" name="us_password" id="us_password" placeholder="비밀번호 입력"></div>
					<p class="error-message">비밀번호가 유효하지 않습니다.</p>
					<div><input type="password" name="us_check_password" id="us_check_password" placeholder="비밀번호 확인"></div>
					<p class="error-message">비밀번호가 서로 다릅니다.</p>
					<div><input type="submit" value="비밀번호 변경"></div>
				</div>
			</form>
		</div>
	</main>
	<%@include file="/footer.jsp" %>
	<script src="../../resources/js/auth.js"></script>
</body>
</html>