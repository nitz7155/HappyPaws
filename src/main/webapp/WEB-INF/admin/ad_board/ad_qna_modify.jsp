<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- jQuery library -->
	<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
	<script src="${pageContext.request.contextPath }/resources/js/board.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice.css">
</head>
<body>
	<jsp:include page="/WEB-INF/admin/admin_header.jsp" />
	<main>
	<div class="n_write">
		<div class="n_write_form">
			<form action="/admin/ad_qna_modify?nowPage=${param.nowPage}" id="qnaForm" enctype="multipart/form-data" method="post" >
				<div class="n_write_header">
					<span class="left">Q&amp;A 수정</span>
				</div>
				<label><input type="text" name="qna_title" placeholder="제목을 입력해주세요." value="${qnaview.qna_title}"></label>
				<input type="hidden" name="qna_id" value="${qnaview.qna_id}">
				<input type="hidden" name="qna_content" id="qna_content">
				<input type="hidden" name="qna_seq" value="${qnaview.qna_seq}">
				<div id="editor">
					${qnaview.qna_content}
				</div>
				
				<input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
	 			<input type="hidden" name="searchCondition" value="${param.searchCondition}">
				
				<input type="submit" value="공지 수정">
				<button type="button" class="n_backButton">취소</button>
			</form>
		</div>
	</div>
	</main>
</body>
</html>