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
			<form action="/board/cmty_insert" id="cmtyForm" enctype="multipart/form-data" method="post" >
				<div class="n_write_header">
					<span class="left">커뮤니티 작성</span>
				</div>
				<div class="c_category">
					<label for="cmty_category">카테고리 선택:</label>
					<select id="cmty_category" name="cmty_category">
					    <option value="General" selected >자유게시판</option>
					    <option value="AdoptionReview">입양/분양 후기</option>
					    <option value="FoundReview">찾은 후기</option>
					</select>
				</div>
				<label><input type="text" name="cmty_title" placeholder="제목을 입력해주세요." required></label>
				<input type="hidden" name="cmty_id" value="${user.us_id}"> 
				<input type="hidden" name="cmty_content" id="cmty_content">
				<div id="editor"></div>
				
				<input type="submit" value="등록">
				<button type="button" class="n_backButton">취소</button>
			</form>
		</div>
	</div>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>