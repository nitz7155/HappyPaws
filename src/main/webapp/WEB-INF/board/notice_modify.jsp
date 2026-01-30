<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
		<h1>공지사항</h1>
		<div class="n_write_form">
			<form action="/board/notice_modify" id="noticeForm" enctype="multipart/form-data" method="post" >
				<div class="n_write_header">
					<span class="left">공지사항 수정</span>
					<div class="right">	
						<span>중요 공지사항</span>
						<input type="checkbox" name="n_chk" value="Y" ${noticeview.n_chk == 'Y' ? 'checked' : ''} >		
					</div>
				</div>
				<input type="text" name="n_title" placeholder="제목을 입력해주세요." value="${noticeview.n_title}">
				<input type="hidden" name="n_id" value="${noticeview.n_id}">
				<input type="hidden" name="n_content" id="n_content">
				<input type="hidden" name="n_seq" value="${noticeview.n_seq}">
				<div id="editor">
					${noticeview.n_content}
				</div>
				
				<input type="submit" value="공지 수정">
				<button type="button" class="n_backButton">취소</button>
			</form>
		</div>
	</div>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>