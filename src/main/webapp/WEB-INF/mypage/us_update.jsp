<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <style>
         body {
            margin: 0;
            padding: 0;
        }

          .container {
            max-width: 500px;
            margin: 60px auto;
            background-color: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h3 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .profile-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: #ddd;
           background-image: url('<c:url value="/resources/profile_images/cutecat.jpg"/>');

            background-size: cover;
            background-position: center;
            margin: 0 auto 20px; 
        }
        table {
            width: 100%;
            border-spacing: 0 10px;
        }
        td {
            padding: 5px 0;
            vertical-align: middle;
            
        }
        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }
        
          input[name="us_id"],
    input[name="us_password"] {
        background-color: #e0e0e0;
    }
        
        .submit-btn {
            background-color: #FFD700;
            border: none;
            padding: 10px 0;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
        }
        .cancel-btn {
            background-color: #e0e0e0;
            border: none;
            padding: 10px 0;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 5px;
        }
        
        .zipcode-container {
    display: flex;
    align-items: center;
    gap: 1px;
}

.zipcode-container button {
    padding: 10px 12px;
    font-size: 14px;
    border-radius: 5px;
    background-color: #e0e0e0;
    border: 1px solid #ddd;
    cursor: pointer;
    box-sizing: border-box;
}
    </style>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 우편번호와 주소 정보를 해당 필드에 넣습니다.
                    document.getElementById('zipcode').value = data.zonecode;
                    document.getElementById('address').value = data.address;
                }
            }).open();
        }
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/admin/admin_header.jsp" />
    <main>
    <div class="container">
        <h3>회원정보 수정</h3>
                
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    ${message}
                </div>
            </c:if>
         <c:choose>
        <c:when test="${not empty detailUser.us_profile}">
            <div class="profile-image" style="background-image: url('<c:url value='/resources/profile_images/${user.us_profile}' />');"></div>
        </c:when>
        <c:otherwise>
            <div class="profile-image" style="background-image: url('<c:url value='/resources/profile_images/cutecat.jpg' />');"></div>
        </c:otherwise>
    </c:choose>

       <form action="${pageContext.request.contextPath}/userUpdate.do" method="post" onsubmit="return confirm('수정하시겠습니까?')">

            <table>
                <tr>
                    <td>아이디:</td>
                    <td><input type="text" name="us_id" value="${detailUser.us_id}" readonly></td>
                </tr>
                <tr>
                    <td>비밀번호:</td>
                    <td><input type="password" value="******" readonly></td>
                </tr>
                <tr>
                    <td>이름:</td>
                    <td><input type="text" name="us_name" value="${detailUser.us_name}"></td>
                </tr>
                <tr>
                    <td>닉네임:</td>
                    <td><input type="text" name="us_nick" value="${detailUser.us_nick}"></td>
                </tr>
                <tr>
                    <td>이메일:</td>
                    <td><input type="email" name="us_email" value="${detailUser.us_email}"></td>
                </tr>
 <!--     <tr>
	    <td colspan="2">
	        <div class="zipcode-container" style="display: flex; align-items: center;">
	            <button type="button" onclick="execDaumPostcode()" style="padding: 8px 12px; font-size: 14px; margin-right: 8px; border-radius: 5px; background-color: #e0e0e0; border: 1px solid #ddd; cursor: pointer;">우편번호 찾기</button>
	            <input type="text" id="zipcode" name="us_zipcode" readonly style="flex: 1; padding: 8px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; font-size: 14px;">
	        </div>
	    </td>
	</tr> -->
                <tr>
                    <td>주소:</td>
                    <td><input type="text" id="address" name="us_address" value="${detailUser.us_address}"></td>
                </tr>
                
                   <input type="hidden" name="us_is_del" value="${detailUser.us_is_del != null ? detailUser.us_is_del : 0}">
                
            </table>
            <button type="submit" class="submit-btn">정보 수정</button>
            <button type="button" class="cancel-btn" onclick="history.back()">취소</button>
        </form>
    </div>
    
    </main>
    <%@include file="../../footer.jsp" %>  
</body>
</html>
