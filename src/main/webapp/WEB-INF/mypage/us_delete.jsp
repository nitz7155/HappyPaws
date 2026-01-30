<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<script>
function confirmDelete() {
    if (confirm("정말로 회원탈퇴를 진행하시겠습니까?")) {
        alert("탈퇴 처리가 완료되었습니다."); // 알림창을 직접 호출
        return true; // 폼 제출 진행
    } else {
        return false; // 폼 제출 중단
    }
}

</script>
</head>
<body>
<%@include file="../../header.jsp" %>
<main>
<div id="content">
    <h3>회원탈퇴</h3>
   
    <form action="userDelete.do" method="post" onsubmit="return confirmDelete()">
        <input type="hidden" name="us_id" value="${user.us_id}">
        <input type="submit" value="탈퇴">
        <input type="button" value="취소" onclick="history.back()">
    </form>
</div>
</main>
<%@include file="../../footer.jsp" %>  
</body>
</html>
