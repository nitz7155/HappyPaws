<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../MIA.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>행복한 발자국</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/MIA.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/findPet.js"></script>
<script>
//댓글 수정 완료
 function fpcMod() {
    let fpCommentDiv = $(this).closest(".comment");
    let content = $.trim(fpCommentDiv.find("textarea").val());
    let fp_seq = fpCommentDiv.find("input[name='fp_seq']").val();
    let fpc_seq = fpCommentDiv.find("input[name='fpc_seq']").val();

    if (!content) {
        alert("댓글 내용을 입력해야 합니다.");
        fpCommentDiv.find("textarea").focus();
        return;
    }

    if (fp_seq && fpc_seq) {
        location.href = "/MIA/updateFpComment?fp_seq=" + fp_seq +
            "&fpc_seq=" + fpc_seq +
            "&fpc_content=" + encodeURIComponent(content) +
            "&searchKeyword=" + encodeURIComponent("${searchKeyword}") +
            "&searchCondition=" + encodeURIComponent("${searchCondition}") +
            "&category=" + encodeURIComponent("${category}") +
            "&nowPage=" + "${nowPage}";
    } else {
        console.error("수정할 수 없는 댓글입니다.");
    }
};

// 댓글 삭제
 function fpcDel() {
    if (confirm("정말로 삭제하시겠습니까?")) {
        let fp_seq = $(this).closest(".comment").find("input[name='fp_seq']").val();
        let fpc_seq = $(this).closest(".comment").find("input[name='fpc_seq']").val();

        if (fp_seq && fpc_seq) {
            location.href = "/MIA/deleteFpComment?fp_seq=" + fp_seq +
                "&fpc_seq=" + fpc_seq +
                "&searchKeyword=" + encodeURIComponent("${searchKeyword}") +
                "&searchCondition=" + encodeURIComponent("${searchCondition}") +
                "&category=" + encodeURIComponent("${category}") +
                "&nowPage=" + "${nowPage}";
        } else {
            console.error("삭제할 수 없는 댓글입니다.");
        }
    }
};

//댓글 수정
$(document).on("click", "#fpcMod", fpcMod);

// 댓글 삭제
$(document).on("click", "#fpcDel", fpcDel);


// 수정 후 확인 버튼 클릭 시
$(document).on('click', '[id^="submitOpenFpcMod_"]', function() {
    let fpcSeq = $(this).attr('id').split('_')[1];
    let passwordMod = $("#passwordOpenFpcMod_" + fpcSeq).val();
    let fpCommentDiv = $(this).closest(".comment");

    $.post("/MIA/verifyFpcPassword", { fpc_seq: fpcSeq, password: passwordMod }, function(isValid) {
        if (isValid == 1) {
            fpCommentDiv.find(".fpcMod1").hide();
            fpCommentDiv.find(".fpcMod2").show();
            fpCommentDiv.find(".fpcMod4").hide();
            fpCommentDiv.find(".fpcMod").hide();
        } else {
            alert("비밀번호가 틀렸습니다.");
        }
    });
});


// 삭제 후 확인 버튼 클릭 시
$(document).on('click', '[id^="submitFpcDel_"]', function() {
	let fpSeq = $(this).closest(".comment").find("input[name='fp_seq']").val();
    let fpcSeq = $(this).attr('id').split('_')[1];
    let passwordDel = $("#passwordFpcDel_" + fpcSeq).val();
    
    $.post("/MIA/verifyFpcPassword", { fpc_seq: fpcSeq, password: passwordDel }, function(isValid) {
        if (isValid == 1) {
        	if (fpSeq && fpSeq) {
                location.href = "/MIA/deleteFpComment?fp_seq=" + fpSeq +
                    "&fpc_seq=" + fpcSeq +
                    "&searchKeyword=" + encodeURIComponent("${searchKeyword}") +
                    "&searchCondition=" + encodeURIComponent("${searchCondition}") +
                    "&category=" + encodeURIComponent("${category}") +
                    "&nowPage=" + "${nowPage}";
            } else {
                console.error("삭제할 수 없는 댓글입니다.");
            }
        } else {
            alert("비밀번호가 틀렸습니다.");
        }
    });
});


//수정 버튼 클릭 시
$(document).on('click', '[id^="openFpcModCheck_"]', function () {
    let fpCommentDiv = $(this).closest(".comment");
    let fpcSeq = $(this).attr('id').split('_')[1]; // 동적으로 fpcSeq 추출
    fpCommentDiv.find("#fpcModCheck_" + fpcSeq).show(); // 고유한 fpcSeq로 비밀번호 모달 열기
    fpCommentDiv.find(".fpcMod4").hide();
});

// 삭제 버튼 클릭 시
$(document).on('click', '[id^="openFpcDelCheck_"]', function () {
    let fpCommentDiv = $(this).closest(".comment");
    let fpcSeq = $(this).attr('id').split('_')[1]; // 동적으로 fpcSeq 추출
    fpCommentDiv.find("#fpcDelCheck_" + fpcSeq).show(); // 고유한 fpcSeq로 비밀번호 모달 열기
    fpCommentDiv.find(".fpcMod4").hide();
});

// 비밀번호 확인 후 수정 닫기
$(document).on('click', '[id^="closeFpcModCheck_"]', function () {
    let fpCommentDiv = $(this).closest(".comment");
    let fpcSeq = $(this).attr('id').split('_')[1]; // 동적으로 fpcSeq 추출
    fpCommentDiv.find(".fpcMod4").show(); // 원래의 버튼들 다시 보여주기
    fpCommentDiv.find("#fpcModCheck_" + fpcSeq).hide(); // 수정 비밀번호 모달 닫기
});

// 비밀번호 확인 후 삭제 닫기
$(document).on('click', '[id^="closeFpcDelCheck_"]', function () {
    let fpCommentDiv = $(this).closest(".comment");
    let fpcSeq = $(this).attr('id').split('_')[1]; // 동적으로 fpcSeq 추출
    fpCommentDiv.find(".fpcMod4").show(); // 원래의 버튼들 다시 보여주기
    fpCommentDiv.find("#fpcDelCheck_" + fpcSeq).hide(); // 삭제 비밀번호 모달 닫기
});

</script>

<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
</head>

<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
		<div class="n_view">
			<div class="n_viewform">
				<h1>아이를 발견했어요</h1>
				<div class="n_title">
					<span class="title">
						${findPet.fp_title}
						<c:if test="${findPet.fp_ok == 'Y'}">
							<div style="color: red; font-weight: bold;">[찾았어요]</div>
						</c:if>
					</span>
					<c:if test="${not empty findPet.us_nick}">
					<span class="author">
					<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${findPet.us_profile}" 
					onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" alt="프로필">
					${findPet.us_nick}</span>
					</c:if>
					<c:if test="${empty findPet.us_nick}">
					<span class="author">${findPet.fp_id}</span>
					</c:if>
				</div>
				<div class="n_second">
					<span class="cnt">조회수: ${findPet.fp_cnt}</span>
					<span class="date">작성일: ${findPet.fp_date}</span>
				</div>

				<div class="n_third">
					<div class="ph">연락처: ${findPet.fp_ph}</div>
					<img src="${pageContext.request.contextPath}/resources/MIA-img/findPetImg/${findPet.fp_img}"
					onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/MIA-img/default.png';" 
					alt="Find Pet Image" class="find-pet-image">
					<table class="detail-table">
						<tr class="detail-row">
							<td class="label">발견 장소</td>
							<td class="value">${findPet.fp_place}</td>
						</tr>
						<tr class="detail-row">
							<td class="label">발견 날짜</td>
							<td class="value">${findPet.fp_time}</td>
						</tr>
						<tr class="detail-row">
							<td class="label">품종</td>
							<td class="value">${findPet.fp_breed}</td>
						</tr>
					</table>
				</div>

				<form name="fm">
					<input type="hidden" name="fp_seq" value="${findPet.fp_seq}">
					<input type="hidden" name="searchKeyword" value="${searchKeyword}">
					<input type="hidden" name="searchCondition" value="${searchCondition}">
					<input type="hidden" name="category" value="${category}">
					<input type="hidden" name="nowPage" value="${nowPage}">
					<div class="n_content"><pre>${fn:replace(findPet.fp_content, lf, "<br>")}</pre></div>
				</form>
			</div>
		</div>

		<form name="hideFrm" style="display: none;">
			<input type="hidden" name="searchKeyword" value="${searchKeyword}">
			<input type="hidden" name="searchCondition" value="${searchCondition}">
			<input type="hidden" name="category" value="${category}">
			<input type="hidden" name="nowPage" value="${nowPage}">
		</form>

<div class="commentlist">
    <c:forEach var="fpComment" items="${fpComment}">
        <div class="comment">
            <form name="cfm" style="display: none;">
                <input type="hidden" name="fp_seq" value="${fpComment.fp_seq}">
                <input type="hidden" name="fpc_seq" value="${fpComment.fpc_seq}">
                <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                <input type="hidden" name="searchCondition" value="${searchCondition}">
                <input type="hidden" name="category" value="${category}">
                <input type="hidden" name="nowPage" value="${nowPage}">
            </form>
            <div>
                <c:if test="${not empty fpComment.us_nick}">
                    <strong>
                    <img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${fpComment.us_profile}" 
                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" alt="프로필">
                    <c:out value="${fpComment.us_nick}" /></strong>
                </c:if>
                <c:if test="${empty fpComment.us_nick}">
                    <strong><c:out value="${fpComment.fpc_id}" /></strong>
                </c:if>
                <span><c:out value="${fpComment.fpc_date}" /></span>
            </div>
            <div>
            <pre class="fpcMod1"><c:out value="${fpComment.fpc_content}" /></pre>

                <div class="fpcMod2" style="display: none">
                    <textarea cols="100" wrap="hard" name="fpc_content" required>${fpComment.fpc_content}</textarea>
                    <div class="btn-container">
                        <button id="fpcMod" type="button">수정</button>
                        <button id="close" type="button">닫기</button>
                    </div>
                </div>

                <c:if test="${user.us_id == fpComment.fpc_id || user.us_id == 'admin'}">
                    <div class="btn-container fpcMod3">
                        <button id="open" type="button">수정</button>
                        <button id="fpcDel" type="button">삭제</button>
                    </div>
                </c:if>

                <c:if test="${fpComment.fpc_login eq 'N' && user.us_id ne 'admin'}">
                    <div class="btn-container fpcMod4">
                        <button id="openFpcModCheck_${fpComment.fpc_seq}" type="button">수정</button>
                        <button id="openFpcDelCheck_${fpComment.fpc_seq}" type="button">삭제</button>
                    </div>                
                </c:if>

                <div class="btn-container fpcMod" id="fpcModCheck_${fpComment.fpc_seq}" style="display: none">
                    <input type="password" id="passwordOpenFpcMod_${fpComment.fpc_seq}" placeholder="비밀번호를 입력해주세요">
                    <button id="submitOpenFpcMod_${fpComment.fpc_seq}" type="button">확인</button>
                    <button id="closeFpcModCheck_${fpComment.fpc_seq}" type="button">닫기</button>
                </div>

                <div class="btn-container" id="fpcDelCheck_${fpComment.fpc_seq}" style="display: none">
                    <input type="password" id="passwordFpcDel_${fpComment.fpc_seq}" placeholder="비밀번호를 입력해주세요">
                    <button id="submitFpcDel_${fpComment.fpc_seq}" type="button">확인</button>
                    <button id="closeFpcDelCheck_${fpComment.fpc_seq}" type="button">닫기</button>
                </div>
            </div>
        </div>
    </c:forEach>
</div>



		<c:if test="${not empty user.us_id}">
		<form action="/MIA/insertFpComment" method="post" class="commentWrite">
			<div class="comment">
				<input type="hidden" name="fp_seq" value="${findPet.fp_seq}">
				<input type="hidden" name="fpc_id" value="${user.us_id}">
				<input type="hidden" name="fpc_code" value="${user.us_id}">
				<input type="hidden" name="fpc_login" value="Y">
				<input type="hidden" name="searchCondition" value="${searchCondition}">
				<input type="hidden" name="searchKeyword" value="${searchKeyword}">
				<input type="hidden" name="category" value="${category}">
				<input type="hidden" name="nowPage" value="${nowPage}">
				<strong>
				<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${user.us_profile}" 
				onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" alt="프로필">
				${user.us_nick}</strong>
				<textarea cols="100" wrap="hard" id="fpc_content" name="fpc_content" required></textarea>
				<div class="btn-container">
					<button type="submit">등록</button>
				</div>
			</div>
		</form>
		</c:if>
		
		<c:if test="${empty user.us_id}">
		<form action="/MIA/insertFpComment" method="post" class="commentWrite">
			<div class="comment">
				<input type="hidden" name="fp_seq" value="${findPet.fp_seq}">
				<input type="text" name="fpc_id" placeholder="닉네임" required>
				<input type="password" name="fpc_code" placeholder="비밀번호" required>
				<input type="hidden" name="fpc_login" value="N">
				<input type="hidden" name="searchCondition" value="${searchCondition}">
				<input type="hidden" name="searchKeyword" value="${searchKeyword}">
				<input type="hidden" name="category" value="${category}">
				<input type="hidden" name="nowPage" value="${nowPage}">
				<textarea cols="100" wrap="hard" id="fpc_content" name="fpc_content" required></textarea>
				<div class="btn-container">
					<button type="submit">등록</button>
				</div>
			</div>
		</form>
		</c:if>
	
	<section class="commandList">
	   <div class="btn-container">
 	       <c:if test="${findPet.fp_login eq 'Y' && user.us_id == findPet.fp_id || user.us_id == 'admin'}">
            	<button id="fpMod" type="button">글 수정</button>
            	<button id="fpDel" type="button">글 삭제</button>
        	</c:if>

        	<c:if test="${findPet.fp_login eq 'N' && user.us_id ne 'admin'}">
            	<button id="fpModCheck" type="button">글 수정</button>
            	<button id="fpDelCheck" type="button">글 삭제</button>
        	</c:if>

        	<button id="fpList" type="button">글 목록</button>
    	</div>
	</section>
		
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>

</html>
