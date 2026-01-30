<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../MIA.jsp"%>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/MIA.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/findPet.js"></script>
<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
<script>
document.addEventListener("DOMContentLoaded", function() {
    var now_utc = Date.now();
    var timeOff = new Date().getTimezoneOffset() * 60000;
    var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
    document.getElementById("Date").setAttribute("max", today);
});

function checkNull(){
	var imgValue = $('#file2').val();
	
	if(imgValue == null || imgValue ==''){
		alert("사진을 첨부해주세요.");
		return false;
	}
}
</script>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
		<div class="n_write">
			<div class="n_writeform">
				<h1>아이를 발견했어요</h1>
				<form action="/MIA/insertFindPet" method="post" enctype="multipart/form-data" name="boardform" onsubmit="return checkNull()">
					
					<div class="n_write_header">
						<span class="left">글 작성</span>
					</div>
					
					<c:if test="${empty user.us_id}">
					<div class="n_title">
					<input id="fp_id" type="text" class="form-control" name="fp_id" placeholder="닉네임을 입력하세요."  value="${user.us_id}"> 
					<input type="password" class="form-control" name="fp_code" placeholder="비밀번호를 입력하세요."  value="${user.us_id}">
					<input type="hidden" name="fp_login" value="N"> 
					</div>
					</c:if>
					
					<c:if test="${not empty user.us_id}">
					<input type="hidden" name="fp_id" value="${user.us_id}"> 
					<input type="hidden" name="fp_code" value="${user.us_id}">
					<input type="hidden" name="fp_login" value="Y"> 
					</c:if>
					
					<div class="n_title">
					<input type="text" class="form-control" name="fp_title" placeholder="제목을 입력하세요." required maxlength="30">
					</div>
					
					<div class="n_ph">
   						 <input type="text" class="form-control" name="fp_ph" id="fp_ph" placeholder="연락처를 입력하세요" required 
   						 oninput="formatPhoneNumber(this)" maxlength="13">
					</div>
					
					<div class="n_img">
					<label for="file2" class="upload-btn" style="cursor: pointer;">
						<img src="${pageContext.request.contextPath}/resources/MIA-img/default.png"
						class="find-pet-image">
						<div class="img_save">
						<input id="file2" type="file" name="uploadFile" accept="image/*" style="display: none;"> 
						<span>사진 첨부</span>
						</div>
					</label>
					</div>

					<div class="n_detail">
						<table class="detail-table">
							<tr class="detail-row">
								<td class="label">발견 장소</td>
								<td class="value"><input type="text" class="form-control"
									name="fp_place" placeholder="발견 장소 입력" required maxlength="30"></td>
							</tr>
							<tr class="detail-row">
								<td class="label">발견 날짜</td>
								<td class="value">
								<input type="date" id="Date" class="form-control" name="fp_time" required></td>
							</tr>
							<tr class="detail-row">
								<td class="label">분류</td>
								<td class="value"><select class="form-control"
									name="fp_category" required>
										<option value="dog">강아지</option>
										<option value="cat">고양이</option>
										<option value="small">소동물</option>
										<option value="etc">기타</option>
								</select></td>
							</tr>
							<tr class="detail-row">
								<td class="label">품종</td>
								<td class="value"><input type="text" class="form-control"
									name="fp_breed" placeholder="품종 입력" required maxlength="10"></td>
							</tr>
						</table>

					</div>
					<div class="n_content">
						<textarea cols="100" wrap="soft" class="form-control" rows="5" name="fp_content"
							placeholder="상세 설명을 입력하세요" required onKeyDown="if(event.keyCode == 13) return false;" 
							onKeyUp="if(event.keyCode == 13) return false;" onKeyPress="if(event.keyCode == 13) return false;"></textarea>					
					</div>
					<input type="hidden" name="fp_ok" value="N"> 
					<input type="hidden" name="fp_del" value="N">

					<div class="btn-container">
						<button id="submit" type="submit">글 등록</button>
						<button id="rollback" type="button">취소</button>
					</div>
				</form>
			</div>
		</div>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>
