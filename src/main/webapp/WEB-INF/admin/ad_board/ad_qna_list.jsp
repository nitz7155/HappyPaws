<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- jQuery library -->
	<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
	<script src="${pageContext.request.contextPath}/resources/js/board.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin_board.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice.css">
	
</head>
<body>
	<jsp:include page="/WEB-INF/admin/admin_header.jsp" />
	<main>
	<div class="n_list">
		<div class="n_seachform">
			<form>
				<label style="display:none;">
				<select name="searchCondition" >
					<option value="TITLE" ${searchCondition == 'TITLE' ? 'selected' : ''} >제목</option>
					<option value="CONTENT" ${searchCondition == 'CONTENT' ? 'selected' : ''}>내용</option>
				</select>
				</label>
				<div class="custom-select-wrapper">
	                <div class="custom-select-display">
	                    <span></span>
	                    <i class="fas fa-chevron-down"></i>
	                </div>
	                <div class="custom-options">
	                    <div data-value="TITLE">제목</div>
	                    <div data-value="CONTENT">내용</div>
	                </div>
	                <label>
					<input type="search" name="searchKeyword" value="${searchKeyword}" placeholder="검색어를 입력해주세요">
					<button type="submit"><img src="${pageContext.request.contextPath}/resources/images/searchicon.png" alt="검색" title="검색"></button>
	            	</label>
	            </div>
			</form>
			<c:set var="isLoggedIn" value="${not empty user.us_id}" />
			<button class="ad_qna_write" data-logged-in="${isLoggedIn}">글쓰기</button>
		</div>
		<table>
			<caption style="display:none;">Q&amp;A</caption>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>등록일</th>
					<th>작성자</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
            		<c:when test="${ not empty qnaList}">		
					    <!-- qna 출력 -->
					    <c:forEach var="qna" items="${qnaList}">
					    	<tr class="ad_qna_view" data-seq="${qna.qna_seq}" data-count="${qna.qna_count}" data-nowpage="${paging.nowPage}" data-searchcondition="${searchCondition}" data-searchkeyword="${searchKeyword}">
					        	<td>${qna.qna_seq}</td>
					            <td><div class="title-wrapper">${qna.qna_title}</div><c:if test="${qna.comment_count != 0}"> <span style="color: #b9b9b9"> [${qna.comment_count}]</span></c:if></td>
					            <td>${qna.formattedQnaDate}</td>
					            <td>
					            	<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${qna.us_profile}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" alt="프로필">
					            	${qna.us_nick}
					            </td>
					        </tr>
					    </c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">등록된 QNA가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	<ul class="pagination">
			<c:if test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link" href="/admin/ad_qna_list?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이전</a></li>
			</c:if>
			<c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}" step="1">
				<c:choose>
					<c:when test="${paging.nowPage==i}"><li class="page-item active"><a class="page-link" >${i}</a></li></c:when>
					<c:otherwise><li class="page-item"><a class="page-link" href="/admin/ad_qna_list?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">${i}</a></li></c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.nowPage < paging.lastBtn  && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link" href="/admin/ad_qna_list?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이후</a></li>
			</c:if>
		</ul>
	</main>
	
	<button class="qna_write ph_write" data-logged-in="${isLoggedIn}"><img src="/resources/images/edit-3.svg" alt="글쓰기"/></button>
</body>
</html>