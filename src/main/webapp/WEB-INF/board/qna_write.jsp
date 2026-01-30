<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
	<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
	<script src="${pageContext.request.contextPath }/resources/js/board.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice.css">
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
	<div class="n_write">
		<h1>Q&amp;A</h1>
		<div class="n_write_form">
			<form action="/board/qna_insert" id="qnaForm" enctype="multipart/form-data" method="post" >
				<div class="n_write_header">
					<span class="left">Q&amp;A 작성</span>
				</div>
				<label><input type="text" name="qna_title" placeholder="제목을 입력해주세요." required></label>
				<input type="hidden" name="qna_id" value="${user.us_id}">
				<input type="hidden" name="qna_content" id="qna_content">
				<div id="editor"></div>
				
				<input type="submit" value="Q&amp;A 등록">
				<button type="button" class="n_backButton">취소</button>
			</form>
		</div>
	</div>
	</main>
</body>
</html>