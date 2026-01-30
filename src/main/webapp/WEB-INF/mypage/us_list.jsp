<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
<meta charset="UTF-8">
<title>회원관리 목록</title>

<style>
    #content {
        width: 100%;
        margin: 0 auto;
        text-align: center;
    }
    h3 {
        font-size: 1.5em;
        margin-bottom: 20px;
    }
    .search-bar {
        display: flex;
        justify-content: center;
        margin-top: 15px;
        margin-bottom: 15px;
    }

    .search-bar select,
    .search-bar input[type="search"],
    .search-bar input[type="submit"] {
        padding: 7px 20px;
        margin-right: 10px;
        font-size: 1em;
        border: 2px solid #FFD700; 
        border-radius: 20px; 
        outline: none; 
        background-color: white; 
        cursor: pointer; 
        box-shadow: none;
        height: 40px;
    }

    .search-bar select {
        padding: 7px 40px;
        margin-right: 10px;
        font-size: 1em;
        border: 2px solid #FFD700;
        border-radius: 20px;
        outline: none;
        background-color: white;
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        width: auto;
    }


      table {
        width: 100%;
        margin: 0 auto;
        border-collapse: collapse;
        margin-top: 10px;
        table-layout: auto;
    }
	
	
	tr > td:nth-child(2) ,tr > td:nth-child(5) , tr > td:nth-child(6){
		text-align: left;
	} 
	
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
         white-space: nowrap; 
        overflow: hidden;
          text-align: center;
    }
    
     th {
        background-color: #FFD700;
        font-weight: bold;
        border-radius: 19Spx;
          padding: 10px 15px;
           border: none;
    }
    
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    tr:hover {
        background-color: #ddd;
    }
     .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 20px;
        font-size: 14px;
    }

    .pagination a, .pagination span {
        display: inline-block;
        padding: 8px 12px;
        margin: 0 3px;
        text-decoration: none;
        color: #333;
        border-radius: 50%;
        border: 1px solid #ddd;
        cursor: pointer;
    }
    .pagination a:hover {
        background-color: #f0f0f0;
    }
    .pagination .current-page {
        background-color: #FFD700;
        color: #333;
        font-weight: bold;
        border: 1px solid #FFD700;
    }
    .pagination .disabled {
        color: #ccc;
        cursor: default;
    }
</style>

<script>
if( !('${message}'=='' ||'${message}'==null ) ) alert('${message}');
</script>
</head>
<body>
<jsp:include page="/WEB-INF/admin/admin_header.jsp" />
<main>
<div id="content">
    <h3>회원관리 목록</h3>
    <c:set var="currentPage" value="${param.page != null ? param.page : 1}" scope="request"/>
    <c:set var="itemsPerPage" value="10" scope="request"/>
    <c:set var="startIndex" value="${(currentPage - 1) * itemsPerPage}" scope="request"/>
    <c:set var="endIndex" value="${startIndex + itemsPerPage}" scope="request"/>
    

       <table>
    <tr>
        <th>번호</th>
        <th>아이디</th>
        <th>이름</th>
        <th>닉네임</th>
        <th>이메일</th>
        <th>주소</th>
        <th>가입일</th>
    </tr>
    <c:forEach var="user" items="${userList}" varStatus="status">
        <c:if test="${status.index >= startIndex && status.index < endIndex}">
            <tr>
                <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${status.index + 1}</td>
                <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_id}</td>
                <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_name}</td>
                <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_nick}</td>
                <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_email}</td>
                <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_address}</td>
                <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_date}</td>
            </tr>
        </c:if>
    </c:forEach>
</table>

    
      <div class="search-bar">
        <form action="userList.do" method="get">
            <select name="searchType">
                <option value="us_id">아이디</option>
                <option value="us_name">이름</option>
                <option value="us_email">이메일</option>
            </select>
            <input type="search" name="searchKeyword" placeholder="검색어 입력">
            <input type="submit" value="조회">
        </form>
    </div>
     <div class="pagination">
    <c:set var="totalPages" value="${(fn:length(userList) + itemsPerPage - 1) / itemsPerPage}" />
   
        <c:choose>
            <c:when test="${currentPage > 1}">
                <a href="userList.do?page=${currentPage - 1}">&laquo;</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">&laquo;</span>
            </c:otherwise>
        </c:choose>

      
        <c:forEach begin="1" end="${totalPages}" var="page">
            <c:choose>
               
                <c:when test="${page == currentPage}">
                    <span class="current-page">${page}</span>
                </c:when>
               
                <c:otherwise>
                    <a href="userList.do?page=${page}">${page}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

       
        <c:choose>
            <c:when test="${currentPage < totalPages}">
                <a href="userList.do?page=${currentPage + 1}">&raquo;</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">&raquo;</span>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</main>

</body>

</html>

