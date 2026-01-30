<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
	<script src="${pageContext.request.contextPath}/resources/js/board.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice.css">
</head>
<body data-context-path="${pageContext.request.contextPath}">
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
	<div class="n_view">
		<div class="n_viewform">
			<h1>커뮤니티</h1>
			<div>
				${cmtyview.cmty_category_kr}
			</div>
			<div class="n_title">
				<span class="title">${cmtyview.cmty_title}</span>
				<span class="author" >
					<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${cmtyview.us_profile}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" alt="프로필">
					${cmtyview.us_nick}
				</span>
			</div>
			<div class="n_date">
				<span>${cmtyview.cmty_date}</span>
			</div>
			<div class="n_content">
				${cmtyview.cmty_content}
				
				<div id="cmty_up"><i data-feather="thumbs-up"></i>추천수: ${cmtyup_cnt}</div>
			</div>
			<div class="comments">
			    <span>댓글쓰기</span>
			    <c:set var="isLoggedIn" value="${not empty user.us_id}" />
			    <c:if test="${not empty user.us_id}">
			    <div class="comment-input">
				    <label><textarea id="commentContent" placeholder="댓글을 입력하세요"></textarea></label>
				    <button id="cmty_comment" value="${param.cmty_seq}" data-logged-in="${isLoggedIn}">댓글<br>등록</button>
			    </div>
			    </c:if>
			    <c:if test="${empty user.us_id}">
				<div class="comment-input">
				    <label><textarea id="commentContent" placeholder="로그인후 입력이 가능합니다." disabled></textarea></label>
				    <button id="cmty_comment" value="${param.cmty_seq}" data-logged-in="${isLoggedIn}" disabled >댓글<br>등록</button>
			    </div>
				</c:if>
				<div id="commentList"></div>
			</div>
			
			<div class="n_buttons">
			    <div style="flex-grow: 1; text-align: center;">
			        <button id="cmty_list">글 목록</button>
			    </div>
			    <c:if test="${user.us_id == cmtyview.cmty_id}">
			    <div style="margin-left: -140px;">	
			        <button class="cmty_modify" data-seq="${cmtyview.cmty_seq}">수정</button>
			        <button class="cmty_delete" data-seq="${cmtyview.cmty_seq}">삭제</button>
			    </div>
			    </c:if>
			</div>
		</div>
	</div>
	
	 <script>
	    $(function() {
	        c_loadComments(); // 페이지 로드 시 댓글 목록 불러오기
	        cmty_up_reload();
	    });
	</script>
	
	<form name="hideFrm" style="display:none;">
	  <input type="hidden" name="nowPage" value="${empty param.nowPage ? 1 : param.nowPage}">
	  <input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
	  <input type="hidden" name="searchCondition" value="${param.searchCondition}">
	  <input type="hidden" name="cmty_category" value="${param.cmty_category}">
  	</form>
  	
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>