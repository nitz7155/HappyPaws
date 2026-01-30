<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<header>
	<div class="header-container">
		<!-- 로고 -->
		<div class="logo">
			<a href="/"><img src="/resources/images/HappyPawsLogo.png" alt="logo"/></a>
		</div>
		<div class="header-menu">
		   	<a href="${pageContext.request.contextPath}/MIA/getLostPetList" class="MIA-link">반려동물</a>
	        <a href="${pageContext.request.contextPath}/product/pr_list" class="pr_-link">반려용품</a>
			<a href="${pageContext.request.contextPath}/board/notice_list" class="notice-link" >공지사항</a>
	        <a href="${pageContext.request.contextPath}/board/qna_list" class="qna-link" >Q&amp;A</a>
	        <a href="${pageContext.request.contextPath}/board/cmty_list?cmty_category=all" class="cmty-link">커뮤니티</a>
	        <c:choose> <c:when test="${user != null}">
	        <a href="/auth/logout" class="header-login-link logout">로그아웃</a>
	        </c:when></c:choose>
		</div>
		<div class="header-login-div">
			<c:choose>
				<c:when test="${user eq null}">
					<!-- 로그인 링크 -->
					<a href="/auth/login" class="header-login-link">로그인</a>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/us_mainmyPage.do" class="header-login-link">
						<img src="/resources/profile_images/${user.us_profile}" onerror="this.onerror=null; this.src='/resources/profile_images/default.jpg';" alt="이미지를 불러오는데 실패하였습니다.">
						${user.us_nick}</a>
					<b>님</b>
					<a href="/auth/logout" class="header-login-link logout">로그아웃</a>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="menu-toggle"><img src="/resources/images/menu.svg" alt="리스트"/></div>
   </div>
   <script>
		$(document).ready(function() {
			 $(".menu-toggle").click(function() {
			        $(".header-menu").toggleClass("show"); // "show" 클래스 토글로 메뉴 열고 닫기
			   });
		});
	</script>
</header>