<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행복한 발자국</title>
</head>
<body>
	<p id="logoutMassage" style="display: none;">${logoutMassage}</p>
	<script>
		let logoutMassage = document.querySelector("#logoutMassage").innerText;
        alert(logoutMassage);
        location.href = "/";
    </script>
</body>
</html>