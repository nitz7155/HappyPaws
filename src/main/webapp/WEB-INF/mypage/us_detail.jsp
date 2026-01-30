<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
<meta charset="UTF-8">
<title>회원상세보기</title>
<style>
    #content {
        width: 80%;
        margin: 0 auto;
        text-align: center;
    }
    h2 {
        font-size: 1.5em;
        margin-bottom: 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
        font-weight: bold;
        width: 20%;
    }
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    .button-container {
        margin-top: 20px;
    }
       .button-container button,
    .button-container input[type="submit"] {
        padding: 5px 10px;
        font-size: 1em;
        margin: 0 5px;
        background-color: #e0e0e0;
        border: 1px solid #ccc;
        cursor: pointer;
        transition: background-color 0.3s, color 0.3s;
    }
      
    .button-container button:hover,
    .button-container input[type="submit"]:hover {
        background-color: #d0d0d0; 
    }

   
    .button-container button:focus,
    .button-container input[type="submit"]:focus {
        outline: 2px solid #005fcc; 
        outline-offset: 2px;
        background-color: #d0d0d0;
    }

 
    .button-container button:active,
    .button-container input[type="submit"]:active {
        background-color: #a0a0a0;
        color: white;
    }
    
</style>
<script>
    // 페이지 로드 시 alertMessage가 있으면 알림창을 띄우고, 목록으로 이동합니다.
    window.onload = function() {
        var alertMessage = "${alertMessage}";
        if (alertMessage) {
            alert(alertMessage);
            window.location.href = "userList.do";
        }
    };

    function confirmDelete() {
        return confirm("정말로 회원 정보를 탈퇴하시겠습니까?");
    }
</script>
</head>
<body>
<jsp:include page="/WEB-INF/admin/admin_header.jsp" />
<main>
<div id="content">
    <h2>회원 상세 정보</h2>
    <table>
        <tr>
            <th>아이디</th>
            <td>${detailUser.us_id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${detailUser.us_name}</td>
        </tr>
        <tr>
            <th>닉네임</th>
            <td>${detailUser.us_nick}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${detailUser.us_email}</td>
        </tr>
        <tr>
            <th>주소</th>
            <td>${detailUser.us_address}</td>
        </tr>
        
         <tr>
            <th>우편번호</th>
         	<td>${detailUser.postcode}</td>
        </tr>
        <tr>
            <th>가입일</th>
         	<td>${detailUser.us_date}</td>
        </tr>
    </table>
   
    <div class="button-container">
    <button onclick="location.href='userUpdate.do?us_id=${detailUser.us_id}'">수정</button>
    
    
   <form action="userDelete.do" method="post" onsubmit="return confirmDelete()" style="display:inline;">
    <input type="hidden" name="us_id" value="${detailUser.us_id}">
    <input type="submit" value="탈퇴">
</form>

    
    <button onclick="location.href='userList.do'">목록으로</button>
</div>
</div>

</main>

</body>
</html>
