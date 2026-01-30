<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../MIA.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>행복한 발자국</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/MIA.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newFamily.js"></script>
<script>
function checkNull(){
	var imgValue = $('#file2').val();
	
	if(imgValue == null || imgValue ==''){
		alert("사진을 첨부해주세요.");
		return false;
	}
}
</script>
<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
		<div class="n_write">
			<h1>새로운 가족을 찾아요</h1>
			<div class="n_writeform">
				<form action="/MIA/insertNewFamily" method="post" enctype="multipart/form-data" name="boardform" onsubmit="return checkNull()">

					<div class="n_write_header">
						<span class="left">글 작성</span>
					</div>

					<div class="n_title">
						<input type="hidden" name="nf_id" value="${user.us_id}"> <input
							type="text" class="form-control" name="nf_title"
							placeholder="제목을 입력하세요." required maxlength="30">
					</div>

					<div class="n_ph">
   						 <input type="text" class="form-control" name="nf_ph" id="nf_ph" placeholder="연락처를 입력하세요" required 
   						 oninput="formatPhoneNumber(this)" maxlength="13">
					</div>

					<div class="n_img">
					<label for="file2" class="upload-btn" style="cursor: pointer;">
						<img src="${pageContext.request.contextPath}/resources/MIA-img/default.png;"
						alt="New Family Image" class="new-family-image">
						<div class="img_save">
								<input id="file2" type="file" name="uploadFile" accept="image/*" style="display: none;"> <span>사진 첨부</span>
						</div>
						</label>
					</div>

					<div class="n_detail">
						<table class="detail-table">
							<tr class="detail-row">
								<td class="label">분양 지역</td>
								<td class="value"><input type="text" class="form-control"
									name="nf_place" placeholder="분양 지역를 입력해주세요" required maxlength="30"></td>
							</tr>
							<tr class="detail-row">
								<td class="label">나이</td>
								<td class="value"><input type="text" class="form-control"
									name="nf_age" placeholder="나이를 입력해주세요" required maxlength="10"></td>
							</tr>
							<tr class="detail-row">
								<td class="label">성별</td>
								<td class="value"><select class="form-control"
									name="nf_gender" required>
										<option value="M">남아</option>
										<option value="F">여아</option>
								</select></td>
							</tr>
							<tr class="detail-row">
								<td class="label">분류</td>
								<td class="value"><select class="form-control"
									name="nf_category" required>
										<option value="dog">강아지</option>
										<option value="cat">고양이</option>
										<option value="small">소동물</option>
										<option value="etc">기타</option>
								</select></td>
							</tr>
							<tr class="detail-row">
								<td class="label">품종</td>
								<td class="value"><input type="text" class="form-control"
									name="nf_breed" placeholder="품종 입력" required maxlength="10"></td>
							</tr>
						</table>

					</div>
					<div class="n_content">
						<textarea cols="100" wrap="soft" class="form-control" rows="5" name="nf_content"
							placeholder="상세 설명을 입력하세요"></textarea>
					</div>
					<input type="hidden" name="nf_ok" value="N"> <input
						type="hidden" name="nf_del" value="N">

					<div class="btn-container">
						<button id="submit" type="submit">글 등록</button>
						<button id="rollback" type="button" onclick="history.back()">취소</button>
					</div>
				</form>
			</div>
		</div>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>
