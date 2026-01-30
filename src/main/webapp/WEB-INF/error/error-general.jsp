<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>행복한 발자국 - 오류 페이지</title>
	<%@include file="/head.jsp" %>
	<style>
		body { display: flex; }
		main {
			text-align: center;
			align-content: center;
		}

		main img {
			width: 500px;
			margin-top: 50px;
			margin-bottom: 50px;
		}

		main a {
			padding: 15px 30px;
			font-size: 20px;
			background-color: #fe8;
			color: black;
			text-decoration: none;
			border-radius: 10px;
			margin-top: 20px;
		}

		main h1 {
			margin-bottom: 15px;
		}

		@media (pointer:coarse) {
			main img {
				width: 100%;
			}
		}
	</style>
</head>
<body>
	<%@include file="/header.jsp" %>
	<main>
		<h1>Error</h1>
		<img src="/resources/images/error-page.png" alt="에러 페이지 사진">
        <h1>문제가 발생했습니다</h1>
        <h4>죄송합니다. 예기치 않은 오류가 발생했습니다.<br>잠시 후 다시 시도해 주세요.</h4>
		<br>
		<a href="/">시작페이지</a>
	</main>
	<%@include file="/footer.jsp" %>
</body>
</html>