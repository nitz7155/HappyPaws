<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>행복한 발자국 - 아이디 찾기</title>
	<%@include file="/head.jsp"%>
	<link rel="stylesheet" href="/resources/css/auth.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<main>
		<div class="auth-form">
			<h3>아이디 찾기</h3>
			<form action="/auth/find_id" method="post" name="findIdForm">
				<div><input type="text" name="us_name" id="us_name" placeholder="이름 입력" autofocus></div>
				<p class="error-message">이름을 입력해주세요.</p>
				<div>
					<input type="text" name="us_phone" id="us_phone" placeholder="전화번호 입력">
					<input type="button" value="전화번호 인증">
				</div>
				<p class="error-message">전화번호를 먼저 인증해주세요.</p>
				<div id="us_phone_auth_div" style="display: none;">
					<input type="text" name="us_phone_auth_code" id="us_phone_auth_code" placeholder="인증번호 입력" maxlength="6">
					<span class="timer" id="timer">05:00</span>
					<input type="button" value="인증번호 확인">
				</div>
				<div><input type="submit" value="아이디 찾기"></div>
			</form>
		</div>
		
		<c:if test="${find_ids ne null}">
			<div class="find-id-results">
				<h4>찾은 아이디 목록</h4>
				<ul>
					<c:forEach var="find_id" items="${find_ids}">
						<li class="find-id-item">
							<span class="find-id-value">${find_id}</span>
						</li>
					</c:forEach>
				</ul>
				<a href="/auth/login">로그인 화면으로 돌아가기</a>
			</div>
			<script defer>
				document.querySelector(".auth-form").remove();
			</script>
		</c:if>
	</main>
	<%@include file="/footer.jsp" %>
	<script src="/resources/js/auth.js"></script>
</body>
</html>