<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
	<script src="${pageContext.request.contextPath}/resources/js/board.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice.css">
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
	<div class="n_list">
		<h1>커뮤니티</h1>
		<div class="n_seachform">
			<form>
				<label style="display: none;"><select name="searchCondition">
					<option value="TITLE" ${searchCondition == 'TITLE' ? 'selected' : ''} >제목</option>
					<option value="CONTENT" ${searchCondition == 'CONTENT' ? 'selected' : ''}>내용</option>
				</select></label>
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
				<input type="hidden" name="cmty_category" value="${param.cmty_category != null ? param.cmty_category : 'all'}">
				
			</form>
			<c:set var="isLoggedIn" value="${not empty user.us_id}" />
			<button class="cmty_write" data-logged-in="${isLoggedIn}">글쓰기</button>
		</div>
		<div id="c_category">
			<ul>
			    <li><a data-cmty_category="all" class="category-link">전체</a></li>
			    <li><a data-cmty_category="General" class="category-link">자유게시판</a></li>
			    <li><a data-cmty_category="AdoptionReview" class="category-link">입양/분양 후기</a></li>
			    <li><a data-cmty_category="FoundReview" class="category-link">찾은 후기</a></li>
			</ul>
		</div>
		<c:choose>
            <c:when test="${ not empty cmtyList}">
				<c:forEach var="cmty" items="${cmtyList}">
					<div class="cmty_view" id="cmty_view" data-seq="${cmty.cmty_seq}" data-count="${cmty.cmty_count}" data-nowpage="${paging.nowPage}" data-searchcondition="${searchCondition}" data-searchkeyword="${searchKeyword}" data-cmty_category="${param.cmty_category}">
					    <div class="text-content">
						    <h5>${cmty.cmty_category_kr}</h5>
						    <h3><span class="title-wrapper">${cmty.cmty_title}</span><c:if test="${cmty.comment_count != 0}"><span style="color: #b9b9b9">  [${cmty.comment_count}]</span></c:if></h3>
						    <div class="cmty_content" style="display: none">${cmty.cmty_content}</div>
						    <div class="cmty_meta">
							    <img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${cmty.us_profile}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" alt="프로필">
							    ${cmty.us_nick} / ${cmty.formattedCmtyDate}</div>
					    </div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div>등록된 글이 없습니다.</div>
			</c:otherwise>
		</c:choose>
	</div>
	<ul class="pagination">
			<c:if test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link" href="/board/cmty_list?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&cmty_category=${param.cmty_category}">&lt;</a></li>
			</c:if>
			<c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}" step="1">
				<c:choose>
					<c:when test="${paging.nowPage==i}"><li class="page-item active"><a class="page-link" >${i}</a></li></c:when>
					<c:otherwise><li class="page-item"><a class="page-link" href="/board/cmty_list?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&cmty_category=${param.cmty_category}">${i}</a></li></c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.nowPage < paging.lastBtn  && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link" href="/board/cmty_list?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&cmty_category=${param.cmty_category}"> &gt;</a></li>
			</c:if>
		</ul>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
	
	<button class="cmty_write ph_write" data-logged-in="${isLoggedIn}"><img src="/resources/images/edit-3.svg" alt="글쓰기"/></button>
</body>

</html>