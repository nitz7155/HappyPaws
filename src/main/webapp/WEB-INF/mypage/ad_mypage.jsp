<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
    <meta charset="UTF-8">
    <title>관리자 마이페이지</title>
    <style>
        #content {
            width: 80%;
            margin: 0 auto;
            text-align: center;
        }
        h3 {
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
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #ddd;
        }
        
        .logout-btn {
            color: white;
            text-decoration: none;
            background-color: #FF6347; 
            padding: 12px 20px;
            border-radius: 20px;
            display: inline-block;
            font-size: 16px;
            margin-top: 10px;
        }
    </style>
    <script>
        function validateForm() {
            var newPassword = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            
            // 비밀번호 정규식 (최소 8자, 영문자, 숫자, 특수문자 포함)
            var passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,64}$/;
            
            if (!passwordPattern.test(newPassword)) {
                alert("비밀번호는 8자 이상이어야 하며, 영문자, 숫자, 특수문자를 포함해야 합니다.");
                return false;
            }

            if (newPassword !== confirmPassword) {
                alert("새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
                return false;
            }

            return true;
        }

        // 알림 메시지를 띄우는 함수
        function showMessage(message) {
            if (message) {
                alert(message);
            }
        }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/admin/admin_header.jsp" />
    <main>
    
    <div id="content">
        <!-- 서버에서 전달된 메시지 확인 -->
        <c:if test="${not empty message}">
            <script>
                // 서버에서 전달된 메시지를 자바스크립트 함수로 전달
                showMessage("<c:out value='${message}' escapeXml='false'/>");
            </script>
        </c:if>
        <c:if test="${not empty error}">
            <script>
                // 서버에서 전달된 메시지를 자바스크립트 함수로 전달
                showMessage("<c:out value='${error}' escapeXml='false'/>");
            </script>
        </c:if>

        <form action="updateAdminInfo.do" method="post" onsubmit="return validateForm()">
            
            <table>
                <tr>
                    <td>현재 비밀번호:</td>
                    <td><input type="password" name="currentPassword" required></td>
                </tr>
                <tr>
                    <td>새 비밀번호:</td>
                    <td><input type="password" name="newPassword" id="newPassword" required></td>
                </tr>
                <tr>
                    <td>새 비밀번호 확인:</td>
                    <td><input type="password" name="confirmPassword" id="confirmPassword" required></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="비밀번호 변경">
                        <input type="button" value="취소" onclick="history.back()">
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div style="text-align: center; margin-top: 30px;">
        <a href="logout" class="logout-btn">로그아웃</a>
    </div>
    </main>
</body>
</html>
