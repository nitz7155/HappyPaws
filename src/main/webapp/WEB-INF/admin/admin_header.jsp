<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
header{
	background-color: #fff;
	position: fixed;
}

main{
	width:1200px;
    margin-left: 260px;
    margin-top : 110px;

}

#c_category{
	margin-left: 0px;
}

</style>
<header>
	<div class="admin-header-container">
		<!-- 로고 -->
		<div class="logo">
			<a href="/"><img src="${pageContext.request.contextPath}/resources/images/HappyPawsLogo.png" alt="로고"/></a>
	    </div>
	    <div class="header-menu">
	    	<a href="${pageContext.request.contextPath}/admin" class="main-link">메인</a>
		    <a href="/userList.do" class="user-link">회원관리</a>
		    <a href="/ad_manageProductList" class="ad_manage-link">상품관리</a>
		    <a href="${pageContext.request.contextPath}/admin/ad_notice_list" class="notice-link">공지사항</a>
		    <a href="${pageContext.request.contextPath}/admin/ad_qna_list" class="qna-link" >Q&amp;A</a>
		    <a href="${pageContext.request.contextPath}/admin/ad_cmty_list?cmty_category=all" class="cmty-link">커뮤니티</a>
		    <a href="/ad_myPage.do" class="mypage-link">관리자 비밀번호변경</a>
	    </div>
       	
       	<div id="session-info" data-user-id="${user.us_id}" style="display: none"></div>
       	
       	<div class="header-login-div" style="margin-right: 50px;">
			<img src="${user.us_profile}" onerror="this.onerror=null; this.src='/resources/profile_images/cutecat.jpg';" alt="이미지를 불러오는데 실패하였습니다.">
			<b>${user.us_nick}님</b>
			<a href="/auth/logout" class="header-login-link logout">로그아웃</a>
		</div>
		
   </div>
</header>
<aside>
	<h3>메인</h3>
	<c:if test="${user.us_id ne 'admin'}">
		<script>
			window.location.href = "/";
		</script>
	</c:if>
	 <script>
        $(document).ready(function() {
        	if (window.location.href.endsWith("/admin")){
            	$(".main-link").addClass("active");
            }
        	else if (window.location.href.includes("notice_")) {
                $(".notice-link").addClass("active");
                $("aside").html(
                	'<h3>공지사항</h3>'
                );
            } else if (window.location.href.includes("qna_")) {
                $(".qna-link").addClass("active");
                $("aside").html(
                    '<h3>Q&amp;A</h3>'
                );
            } else if (window.location.href.includes("cmty_")) {
                $(".cmty-link").addClass("active");
                $("aside").html(
                    "<h3>커뮤니티</h3>"+
                		"<div id='c_category'>"+
                    	"<ul><li><a href='/admin/ad_cmty_list?cmty_category=all' data-cmty_category='all' class='category-link'>전체</a></li>"+
            			"<li><a href='/admin/ad_cmty_list?cmty_category=General'  data-cmty_category='General' class='category-link'>자유게시판</a></li>"+
            			"<li><a href='/admin/ad_cmty_list?cmty_category=AdoptionReview' data-cmty_category='AdoptionReview' class='category-link'>입양/분양 후기</a></li>"+
            			"<li><a href='/admin/ad_cmty_list?cmty_category=FoundReview' data-cmty_category='FoundReview' class='category-link'>찾은 후기</a></li>"+
            			"</ul>"+
            		"</div>"
                );
                
            } else if (window.location.href.includes("/ad_manage") || window.location.href.includes("/pr_admin")) {
                $(".ad_manage-link").addClass("active");
                $("aside").html(
                		 "<h3>상품관리</h3>" +
                	        "<ul>" +
                	        "<li><a href='/ad_manageProductList'>상품 리스트</a></li>" +  // 링크 끝에 ">" 추가
                	        "<li><a href='/ad_manageProductAdd'>상품 등록하기</a></li>" +  // 링크 끝에 ">" 추가
                	        "<li><a href='/product/pr_admin'>주문/배송 관리</a></li>" +  // 링크 끝에 ">" 추가
                	        "</ul>"
                );
            } else if (window.location.href.includes("/user")) {
                $(".user-link").addClass("active");
                $("aside").html(
                	"<h3>회원관리</h3>"
                );
            } else if (window.location.href.endsWith("/ad_myPage.do")){
            	$(".mypage-link").addClass("active");
            	$("aside").html(
                    	"<h3>비밀번호 변경</h3>"
                );
            }
            
            
            const urlParams = new URLSearchParams(window.location.search);
            const currentCategory = urlParams.get('cmty_category');

            if (currentCategory) {
        		$('.category-link').removeClass('text-danger');
                // 현재 카테고리와 일치하는 링크에 클래스 추가
                $('.category-link').each(function () {

                    if ($(this).data('cmty_category') === currentCategory) {
                        $(this).addClass('blue');
                    }
                });
            }
            
            
            
        });                   
        
    </script>
</aside>
