<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
	<!-- jQuery library -->
	<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
	<script src="${pageContext.request.contextPath }/resources/js/board.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice.css">
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
	<div class="n_write">
		<h1>커뮤니티</h1>
		<div class="n_write_form">
			<form action="/board/cmty_modify?nowPage=${param.nowPage}&view_cmty_category=${param.cmty_category}" id="cmtyForm" enctype="multipart/form-data" method="post" >
				<div class="n_write_header">
					<span class="left">커뮤니티 수정</span>
				</div>
				<div class="c_category">
					<label for="cmty_category">카테고리 선택:</label>
					<select id="cmty_category" name="cmty_category">
					    <option value="General" ${cmtyview.cmty_category == 'General' ? 'selected' : ''} >자유게시판</option>
					    <option value="AdoptionReview" ${cmtyview.cmty_category == 'AdoptionReview' ? 'selected' : ''}>입양/분양 후기</option>
					    <option value="FoundReview" ${cmtyview.cmty_category == 'FoundReview' ? 'selected' : ''}>찾은 후기</option>
					</select>
				</div>
				<label><input type="text" name="cmty_title" placeholder="제목을 입력해주세요." value="${cmtyview.cmty_title}"></label>
				<input type="hidden" name="cmty_id" value="${cmtyview.cmty_id}">
				<input type="hidden" name="cmty_content" id="cmty_content">
				<input type="hidden" name="cmty_seq" value="${cmtyview.cmty_seq}">
				
				<input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
				<input type="hidden" name="searchCondition" value="${param.searchCondition}">
				
				<div id="editor">
					${cmtyview.cmty_content}
				</div>
				
				<input type="submit" value="수정">
				<button type="button" class="n_backButton">취소</button>
			</form>
		</div>
	</div>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>