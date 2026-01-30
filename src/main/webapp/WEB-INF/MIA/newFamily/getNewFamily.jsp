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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/MIA.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newFamily.js"></script>
<script>
// 댓글 수정 완료
$(document).on('click', '#nfcMod', function() {
    let nfCommentDiv = $(this).closest(".nfComment");
    let content = $.trim(nfCommentDiv.find("textarea").val());
    let nf_seq = nfCommentDiv.find("input[name='nf_seq']").val();
    let nfc_seq = nfCommentDiv.find("input[name='nfc_seq']").val();

    if (!content) {
        alert("댓글 내용을 입력해야 합니다.");
        nfCommentDiv.find("textarea").focus();
        return;
    }

    if (nf_seq && nfc_seq) {
        location.href = "/MIA/updateNfComment?nf_seq=" + nf_seq +
            "&nfc_seq=" + nfc_seq +
            "&nfc_content=" + encodeURIComponent(content) +
            "&searchKeyword=" + encodeURIComponent("${searchKeyword}") +
            "&searchCondition=" + encodeURIComponent("${searchCondition}") +
            "&category=" + encodeURIComponent("${category}") +
            "&nowPage=" + "${nowPage}";
    } else {
        console.error("수정할 수 없는 댓글입니다.");
    }
});

// 댓글 삭제
$(document).on('click', '#nfcDel', function() {
    if (confirm("정말로 삭제하시겠습니까?")) {
        let nf_seq = $(this).closest(".comment").find("input[name='nf_seq']").val();
        let nfc_seq = $(this).closest(".comment").find("input[name='nfc_seq']").val();

        if (nf_seq && nfc_seq) {
            location.href = "/MIA/deleteNfComment?nf_seq=" + nf_seq +
                "&nfc_seq=" + nfc_seq +
                "&searchKeyword=" + encodeURIComponent("${searchKeyword}") +
                "&searchCondition=" + encodeURIComponent("${searchCondition}") +
                "&category=" + encodeURIComponent("${category}") +
                "&nowPage=" + "${nowPage}";
        } else {
            console.error("삭제할 수 없는 댓글입니다.");
        }
    }
});

//로그인 필요 알림
$(document).on('click', '#login_button', function() {
    const currentUri = encodeURIComponent(window.location.href);
    location.href = "/auth/login?returi=" + currentUri;
});
</script>
<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
		<div class="n_view">
			<div class="n_viewform">
				<h1>새로운 가족을 찾아요</h1>
				<div class="n_title">
					<span class="title"> ${newFamily.nf_title} <c:if
							test="${newFamily.nf_ok == 'Y'}">
							<div style="color: red; font-weight: bold;">[찾았어요]</div>
						</c:if>
					</span>
					 <span class="author">
					 <img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${newFamily.us_profile}" 
					 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" 
					 alt="프로필">
					 ${newFamily.us_nick}</span>
				</div>
				<div class="n_second">
					<span class="cnt">조회수: ${newFamily.nf_cnt}</span> <span
						class="date">작성일: ${newFamily.nf_date}</span>
				</div>

				<div class="n_third">
					<div class="ph">연락처: ${newFamily.nf_ph}</div>
					<img src="${pageContext.request.contextPath}/resources/MIA-img/newFamilyImg/${newFamily.nf_img}"
					onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/MIA-img/default.png';"
					alt="New Family Image" class="new-family-image">
					<table class="detail-table">
						<tr class="detail-row">
							<td class="label">분양 지역</td>
							<td class="value">${newFamily.nf_place}</td>
						</tr>
						<tr class="detail-row">
							<td class="label">나이</td>
							<td class="value">${newFamily.nf_age}</td>
						</tr>

						<tr class="detail-row">
							<td class="label">성별</td>
							<td class="value" id="pet_gender">${newFamily.nf_gender}</td>
						</tr>

						<tr class="detail-row">
							<td class="label">품종</td>
							<td class="value">${newFamily.nf_breed}</td>
						</tr>
					</table>
				</div>

				<form name="fm">
					<input type="hidden" name="nf_seq" value="${newFamily.nf_seq}">
					<input type="hidden" name="searchKeyword" value="${searchKeyword}">
					<input type="hidden" name="searchCondition" value="${searchCondition}"> 
					<input type="hidden" name="category" value="${category}"> 
					<input type="hidden" name="nowPage" value="${nowPage}">
					<div class="n_content"><pre>${fn:replace(newFamily.nf_content, lf, "<br>")}</pre></div>
				</form>
			</div>
		</div>

		<form name="hideFrm" style="display: none;">
			<input type="hidden" name="searchKeyword" value="${searchKeyword}">
			<input type="hidden" name="searchCondition"
				value="${searchCondition}"> <input type="hidden"
				name="category" value="${category}"> <input type="hidden"
				name="nowPage" value="${nowPage}">
		</form>

		<div class="commentlist">
			<c:forEach var="nfComment" items="${nfComment}">
				<div class="comment">
					<input type="hidden" name="nf_seq" value="${nfComment.nf_seq}">
					<input type="hidden" name="nfc_seq" value="${nfComment.nfc_seq}">
					<input type="hidden" name="searchKeyword" value="${searchKeyword}">
					<input type="hidden" name="searchCondition"
						value="${searchCondition}"> <input type="hidden"
						name="category" value="${category}"> <input type="hidden"
						name="nowPage" value="${nowPage}">
					<div>
						<strong>
						<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${nfComment.us_profile}" 
						onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" 
						alt="프로필">
						<c:out value="${nfComment.us_nick}" /></strong> <span><c:out
								value="${nfComment.nfc_date}" /></span>
					</div>
					<div>
						<pre class="nfcMod1"><c:out value="${nfComment.nfc_content}" /></pre>
						<div class="nfcMod2" style="display: none">
							<textarea cols="100" wrap="hard" name="nfc_content" required>${nfComment.nfc_content}</textarea>
							<div class="btn-container">
								<button id="nfcMod" type="button">수정</button>
								<button id="close" type="button">닫기</button>
							</div>
						</div>
						<c:if test="${user.us_id == nfComment.nfc_id || user.us_id == 'admin'}">
						<div class="btn-container nfcMod3">
							<button id="open" type="button">수정</button>
							<button id="nfcDel" type="button">삭제</button>
						</div>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>

	
		<form action="/MIA/insertNfComment" method="post" class="commentWrite">
			<div class="comment">
				<input type="hidden" name="nfc_id" value="${user.us_id}"> <input
					type="hidden" name="nf_seq" value="${newFamily.nf_seq}"> <input
					type="hidden" name="searchCondition" value="${searchCondition}">
				<input type="hidden" name="searchKeyword" value="${searchKeyword}">
				<input type="hidden" name="category" value="${category}"> <input
					type="hidden" name="nowPage" value="${nowPage}"> 
					<strong>
					<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${user.us_profile}" 
					onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" 
					alt="프로필">
					${user.us_nick}</strong>
		<c:if test="${not empty user.us_id}">
				<textarea cols="100" wrap="hard" id="nfc_content" name="nfc_content" required></textarea>
				<div class="btn-container">
					<button type="submit">등록</button>
				</div>
		</c:if>
		<c:if test="${empty user.us_id}">
				<textarea id="nfc_content" name="nfc_content" placeholder="로그인 후 입력이 가능합니다." required disabled></textarea>
				<div class="btn-container">
					<button type="button" id="login_button">등록</button>
				</div>
		</c:if>
			</div>
		</form>

	
		<section class="commandList">
			<div class="btn-container">
			<c:if test="${user.us_id == newFamily.nf_id || user.us_id == 'admin'}">
				<button id="nfMod" type="button">글 수정</button>
				<button id="nfDel" type="button">글 삭제</button>
			</c:if>	
				<button id="nfList" type="button">글 목록</button>
			</div>
		</section>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>

</html>
