<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 등록 게시물</title>
   <style>
        .container {
            width: 80%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .table-container {
            overflow-x: auto;
              margin-top: 10px;
            
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            min-width: 600px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        
         td.title-column {
            text-align: left; /* 제목만 왼쪽 정렬 */
        }
        
        th {
            background-color: #FFD700;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
        }

      .search-container {
    display: flex; 
    justify-content: center; 
    align-items: center; 
    margin: 20px auto;
    gap: 50px; 
    width: 100%;
    flex-wrap: wrap;  
}

.search-container select,
.search-container input[type="search"],
.search-container button {
    padding: 10px 15px;
   
    border: 2px solid #FFD700; 
    border-radius: 20px; 
    outline: none; 
    background-color: white; 
    height: 40px; 
    width: auto; 
    font-size: 16px;
    text-align: center; 
    cursor: pointer; 
     flex: 1;
    min-width: 120px;
    
}

.search-container input[type="search"] {
    padding: 10px 20px; 
    border: 2px solid #FFD700; 
    border-radius: 20px; 
    outline: none; 
    background-color: white; 
    font-size: 14px; 
    width: auto; 
}

.search-container input[type="search"]::placeholder {
    padding-left: 6px; 
    color: #aaa; 
    font-size: 16px; 
}

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            font-size: 12px;
        }

        .pagination a, .pagination span {
            display: inline-block;
            padding: 5px 10px;
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

    @media (max-width: 768px) {
    .search-container {
        flex-direction: column; 
        gap: 30px;
    }

    .search-container select,
    .search-container input[type="search"],
    .search-container button {
     margin-bottom: 10px;
        font-size: 14px;
        padding: 8px;
        width: 100%; 
        gap:50px;
    }
    
    .search-container button:last-child {
        margin-bottom: 0;
    }
    
}
       @media (max-width: 480px) {
    .search-container {
        flex-direction: column; /* 모바일에서 세로 정렬 유지 */
        gap: 40px; /* 모바일 환경에서 세로 간격 더 넓히기 */
    }

    .search-container select,
    .search-container input[type="search"],
    .search-container button {
        width: 100%; /* 모바일 화면 너비에 맞춤 */
        font-size: 14px;
        padding: 10px; 
        gap:50px;
        margin-bottom: 10px;
    }
    
    .search-container button:last-child {
        margin-bottom: 0;
    }
    
}

</style>
    <script>
    function goToDetail(postId, sourceTable) {
        console.log("postId:", postId); // postId 값 출력
        console.log("sourceTable:", sourceTable); // sourceTable 값 출력

        if (sourceTable === '커뮤니티') {
            location.href = '/board/cmty_view?cmty_seq=' + postId + "&cmty_category=all";
        } else if (sourceTable === 'QNA') {
            location.href = '/board/qna_view?qna_seq=' + postId;
        } else if (sourceTable === '공지사항') {
            location.href = '/board/notice_view?notice_seq=' + postId;
        } else if (sourceTable === '아이를 찾아주세요') {
            location.href = '/MIA/getLostPet?lp_seq=' + postId; 
        } else if (sourceTable === '아이를 발견했어요') {
            location.href = '/MIA/getFindPet?fp_seq=' + postId; 
        } else if (sourceTable === '새로운 가족을 찾아요') {
            location.href = '/MIA/getNewFamily?nf_seq=' + postId;
        } else {
            alert("유효하지 않은 게시물입니다.");
            return;
        }
    }



    </script>
</head>
<body>
<%@include file="../../header.jsp" %>
<main>
<div class="container">
    <h2>내 등록 게시물</h2>
    <div class="table-container">
    <table>
        <thead>
            <tr>
                <th>등록게시판</th>
                <th>제목</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty currentPagePosts}">
                    <c:forEach var="post" items="${currentPagePosts}">
                        <tr onclick="goToDetail(${post.post_id}, '${post.source_table}')">
                            <td>${post.source_table}</td> <!-- 등록게시판 -->
                            <td class="title-column">${post.title}</td> <!-- 제목 -->
                            <td>${post.created_date}</td> <!-- 작성일 -->
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="3">등록된 게시물이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

    <div class="search-container">
        <form action="/myPosts" method="get"> <!-- GET 방식으로 서버에 검색 요청 -->
            <select name="searchField">
                <option value="title" <c:if test="${param.searchField == 'title'}">selected</c:if>>제목</option>
                <option value="source_table" <c:if test="${param.searchField == 'source_table'}">selected</c:if>>등록게시판</option>
            </select>
            <input type="search" name="searchQuery" placeholder="검색어 입력" value="<c:out value='${param.searchQuery}'/>">
            <button type="submit">조회</button>
        </form>
    </div>

    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}">&laquo;</a>
        </c:if>
        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <span class="current-page">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}">&raquo;</a>
        </c:if>
    </div>
</div>
</main>
<%@include file="../../footer.jsp" %>
</body>
</html>
