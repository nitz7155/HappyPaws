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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/lostPet.js"></script>
<script>
$(document).on('click', '#lpcMod', function() {
    let lpCommentDiv = $(this).closest(".comment");
    let content = $.trim(lpCommentDiv.find("textarea").val());
    let lp_seq = lpCommentDiv.find("input[name='lp_seq']").val();
    let lpc_seq = lpCommentDiv.find("input[name='lpc_seq']").val();

    if (!content) {
        alert("댓글 내용을 입력해야 합니다.");
        lpCommentDiv.find("textarea").focus();
        return;
    }

    if (lp_seq && lpc_seq) {
        location.href = "/MIA/updateLpComment?lp_seq=" + lp_seq +
            "&lpc_seq=" + lpc_seq +
            "&lpc_content=" + encodeURIComponent(content) +
            "&searchKeyword=" + encodeURIComponent("${searchKeyword}") +
            "&searchCondition=" + encodeURIComponent("${searchCondition}") +
            "&category=" + encodeURIComponent("${category}") +
            "&nowPage=" + "${nowPage}";
    } else {
        console.error("수정할 수 없는 댓글입니다.");
    }
});

// 댓글 삭제
$(document).on('click', '#lpcDel', function() {
    if (confirm("정말로 삭제하시겠습니까?")) {
        let lp_seq = $(this).closest(".comment").find("input[name='lp_seq']").val();
        let lpc_seq = $(this).closest(".comment").find("input[name='lpc_seq']").val();

        if (lp_seq && lpc_seq) {
            location.href = "/MIA/deleteLpComment?lp_seq=" + lp_seq +
                "&lpc_seq=" + lpc_seq +
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
				<h1>아이를 찾아주세요</h1>
				<div class="n_title">
					<span class="title">
						${lostPet.lp_title}
						<c:if test="${lostPet.lp_ok == 'Y'}">
							<div style="color: red; font-weight: bold;">[찾았어요]</div>
						</c:if>
					</span>
					
					<span class="author">
					 <img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${lostPet.us_profile}" 
					 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" 
					 alt="프로필">
					${lostPet.us_nick}</span>
				</div>
				<div class="n_second">
					<span class="cnt">조회수: ${lostPet.lp_cnt}</span>
					<span class="date">작성일: ${lostPet.lp_date}</span>
				</div>

				<div class="n_third">
					<div class="ph">연락처: ${lostPet.lp_ph}</div>
					<img src="${pageContext.request.contextPath}/resources/MIA-img/lostPetImg/${lostPet.lp_img}" 
					onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/MIA-img/default.png';"
					alt="Lost Pet Image" class="lost-pet-image">
					<table class="detail-table">
						<tr class="detail-row">
							<td class="label">실종 장소</td>
							<td class="value">${lostPet.lp_place}</td>
						</tr>
						<tr class="detail-row">
							<td class="label">실종 날짜</td>
							<td class="value">${lostPet.lp_time}</td>
						</tr>
						<tr class="detail-row">
							<td class="label">품종</td>
							<td class="value">${lostPet.lp_breed}</td>
						</tr>
						<tr class="detail-row">
							<td class="label">사례금</td>
							<td class="value">${lostPet.formattedReward}원</td>
						</tr>
					</table>
				</div>

				<form name="fm">
					<input type="hidden" name="lp_seq" value="${lostPet.lp_seq}">
					<input type="hidden" name="searchKeyword" value="${searchKeyword}">
					<input type="hidden" name="searchCondition" value="${searchCondition}">
					<input type="hidden" name="category" value="${category}">
					<input type="hidden" name="nowPage" value="${nowPage}">
					<div class="n_content"><pre>${fn:replace(lostPet.lp_content, lf, "<br>")}</pre></div>
				</form>
			</div>
		</div>

		<form name="hideFrm">
			<input type="hidden" name="searchKeyword" value="${searchKeyword}">
			<input type="hidden" name="searchCondition" value="${searchCondition}">
			<input type="hidden" name="category" value="${category}">
			<input type="hidden"  name="nowPage" value="${nowPage}">
		</form>

		<div class="commentlist">
			<c:forEach var="lpComment" items="${lpComment}">
				<div class="comment">
				<form name="cfm" style="display: none;">
					<input type="hidden" name="lp_seq" value="${lpComment.lp_seq}">
					<input type="hidden" name="lpc_seq" value="${lpComment.lpc_seq}">
					<input type="hidden" name="searchKeyword" value="${searchKeyword}">
					<input type="hidden" name="searchCondition" value="${searchCondition}">
					<input type="hidden" name="category" value="${category}">
					<input type="hidden" name="nowPage" value="${nowPage}">
				</form>
					<div>
						<strong>
						 <img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${lpComment.us_profile}" 
						 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" 
						 alt="프로필">
						<c:out value="${lpComment.us_nick}" />
						</strong>
						<span><c:out value="${lpComment.lpc_date}" /></span>
					</div>
					<div>
						<pre class="lpcMod1"><c:out value="${lpComment.lpc_content}" /></pre>
						
						<div class="lpcMod2" style="display: none">
							<textarea cols="100" wrap="hard" name="lpc_content" required>${lpComment.lpc_content}</textarea>
							<div class="btn-container">
								<button id="lpcMod" type="button">수정</button>
								<button id="close" type="button">닫기</button>
							</div>
						</div>
						
					<c:if test="${user.us_id == lpComment.lpc_id || user.us_id == 'admin'}">
						<div class="btn-container lpcMod3">
							<button id="open" type="button">수정</button>
							<button id="lpcDel" type="button">삭제</button>
						</div>
					</c:if>
					</div>
				</div>
			</c:forEach>
		</div>

	
		<form action="/MIA/insertLpComment" method="post" class="commentWrite">
			<div class="comment">
				<input type="hidden" name="lpc_id" value="${user.us_id}">
				<input type="hidden" name="lp_seq" value="${lostPet.lp_seq}">
				<input type="hidden" name="searchCondition" value="${searchCondition}">
				<input type="hidden" name="searchKeyword" value="${searchKeyword}">
				<input type="hidden" name="category" value="${category}">
				<input type="hidden" name="nowPage" value="${nowPage}">
				<strong>
				 <img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${user.us_profile}" 
				 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" 
				 alt="프로필">
				${user.us_nick}</strong>
				<c:if test="${not empty user.us_id}">
				<textarea cols="100" wrap="hard" id="lpc_content" name="lpc_content" required></textarea>
				<div class="btn-container">
					<button type="submit">등록</button>
				</div>
				</c:if>
				<c:if test="${empty user.us_id}">
				<textarea id="lpc_content" name="lpc_content" placeholder="로그인 후 입력이 가능합니다." required disabled></textarea>
				<div class="btn-container">
    				<button type="button" id="login_button">등록</button>
				</div>
				</c:if>
			</div>
		</form>
		
		<section class="commandList">
			<div class="btn-container">
			<c:if test="${user.us_id == lostPet.lp_id || user.us_id == 'admin'}">
				<button id="lpMod" type="button">글 수정</button>
				<button id="lpDel" type="button">글 삭제</button>
			</c:if>
				<button id="lpList" type="button">글 목록</button>
			</div>
		</section>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>

</html>
