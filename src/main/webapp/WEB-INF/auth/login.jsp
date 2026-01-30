<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>행복한 발자국 - 로그인</title>
	<%@include file="/head.jsp"%>
	<link rel="stylesheet" href="/resources/css/auth.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<main>
		<h3>로그인</h3>
		<div class="sns-login fine">
			<h5>간편 로그인</h5>
			<a href="${naverLoginUrl}">
				<img src="/resources/img/naver_login.png" alt="네이버 로그인">
			</a>
			<a href="${kakaoLoginUrl}">
				<img src="/resources/img/kakao_login.png" alt="카카오 로그인">
			</a>
		</div>

		<div class="auth-form">
			<form action="/auth/login" method="post" name="loginForm">
				<h5>회원 로그인</h5>
				<div><input type="text" name="us_id" placeholder="아이디" autofocus></div>
				<p class="error-message">아이디를 입력해주세요.</p>
				<div><input type="password" name="us_password" placeholder="비밀번호"></div>
				<p class="error-message">비밀번호를 입력해주세요.</p>
				<div><input type="submit" value="로그인"></div>
			</form>

			<c:if test="${error ne null}">
				<p class="login-error-message">
					<c:choose>
						<c:when test='${error == "id" }'>
							존재하지 않는 아이디입니다.
						</c:when>
						<c:when test='${error == "del" }'>
							삭제된 계정입니다.
						</c:when>
						<c:when test='${error == "password" }'>
							비밀번호가 틀립니다.
						</c:when>
						<c:when test='${error == "sns" }'>
							SNS 로그인을 이용해주세요.
						</c:when>
					</c:choose>
				</p>
			</c:if>
		</div>

		<div class="auth-links">
			<a href="/auth/join">회원가입</a>
			<span>|</span>
			<a href="/auth/find_id">아이디 찾기</a>
			<span>|</span>
			<a href="/auth/find_password">비밀번호 찾기</a>
		</div>

		<div class="sns-login coarse">
			<hr>
			<h5>간편 로그인</h5>
			<div class="sns-login-icons">
				<a href="${naverLoginUrl}"><img src="/resources/img/naver_login_mobile.png" alt="네이버 로그인"></a>
				<a href="${kakaoLoginUrl}"><img src="/resources/img/kakao_login_mobile.png" alt="카카오 로그인"></a>
			</div>
		</div>
	</main>
	<%@include file="/footer.jsp" %>
	<script src="/resources/js/auth.js"></script>
</body>
</html>