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
$(document).on('click', '#submitMod', function() {
    var fpSeq = ${findPet.fp_seq};
    var passwordMod = $("#passwordMod").val();

    $.post("/MIA/verifyPassword", { fp_seq: fpSeq, password: passwordMod }, function(isValid) {
    	console.log(isValid)
        if (isValid == 1) {
            fpMod();
        } else {
            alert("비밀번호가 틀렸습니다.");
        }
    });
    
    function fpMod() {
        document.fm.action = "/MIA/updateFindPet";
        document.fm.method = "get";
        document.fm.submit();
    }
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
			<form name="fm">
				<input type="hidden" name="fp_seq" value="${findPet.fp_seq}">
				<input type="hidden" name="searchKeyword" value="${searchKeyword}">
				<input type="hidden" name="searchCondition" value="${searchCondition}">
				<input type="hidden" name="category" value="${category}">
				<input type="hidden" name="nowPage" value="${nowPage}">
			</form>
	
				<div class="passwordBox">
					<div class="passwordInner">
						<strong>비밀번호를 입력하세요</strong>
    					<input type="password" id="passwordMod">
    					<div class="btn-container">
    						<button id="submitMod" type="button">확인</button>
    						<button id="rollback" type="button">취소</button>
    					</div>
					</div>
				</div>
			</div>
		</div>	
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>

</html>
