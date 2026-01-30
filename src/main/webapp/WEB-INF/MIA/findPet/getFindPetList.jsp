<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../MIA.jsp"%>
<%
    java.util.List<String> categories = java.util.Arrays.asList("", "dog", "cat", "small", "etc");
    pageContext.setAttribute("categories", categories);
%>
<head>
    <jsp:include page="${pageContext.request.contextPath}/head.jsp" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/MIA.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/findPet.js"></script>
</head>
<body>
    <jsp:include page="${pageContext.request.contextPath}/header.jsp" />
    <main>
        <div class="n_list">
			<div class="c_category">
				<ul>
			    	<li><a href="/MIA/getLostPetList">아이를 찾아주세요</a></li>
			    	<li><span>아이를 발견했어요</span> </li>
				    <li><a href="/MIA/getNewFamilyList">새로운 가족을 찾아요</a></li>
				</ul>
			</div>
			
			<div class="c_category_ph">
				<ul>
			    	<li><a href="/MIA/getLostPetList">찾아주세요</a></li>
			    	<li><span>발견했어요</span> </li>
				    <li><a href="/MIA/getNewFamilyList">가족을 찾아요</a></li>
				</ul>
			</div>
			
			<div class="n_seachform">
				<form>
					<label style="display: none;"><select name="searchCondition" >
						<option value="TITLE" ${searchCondition == 'TITLE' ? 'selected' : ''} >제목</option>
						<option value="CONTENT" ${searchCondition == 'CONTENT' ? 'selected' : ''}>내용</option>
					</select></label>
					<div class="custom-select-wrapper">
		                <div class="custom-select-display">
		                    <span></span>
		                    <i class="fas fa-chevron-down"></i>
		                </div>
		                <div class="custom-options">
		                    <div data-value="TITLE">제목</div>
		                    <div data-value="CONTENT">내용</div>
		                </div>
		                <label>
						<input type="search" name="searchKeyword" value="${searchKeyword}" placeholder="검색어를 입력해주세요">
						<button type="submit"><img src="${pageContext.request.contextPath}/resources/images/searchicon.png" alt="검색" title="검색"></button>
						</label>
		            </div>
				</form>
				<button class="fpIns">글쓰기</button>
			</div>

            <div class="n_categoryform">
    			<form action="/MIA/getFindPetList" method="post" style="display: inline;">
        			<input type="hidden" name="searchCondition" value="${searchCondition}">
	        		<input type="hidden" name="searchKeyword" value="${searchKeyword}">
    		    	<input type="hidden" name="category" value="">
	        		<input type="hidden" name="nowPage" value="1">
	    	    	<input class="category ${category == '' ? 'active' : ''}" type="submit" value="전체">
    			</form>

			    <form action="/MIA/getFindPetList" method="post" style="display: inline;">
			        <input type="hidden" name="searchCondition" value="${searchCondition}">
	    		    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
        			<input type="hidden" name="category" value="dog">
			        <input type="hidden" name="nowPage" value="1">
			        <input class="category ${category == 'dog' ? 'active' : ''}" type="submit" value="강아지">
			    </form>

    			<form action="/MIA/getFindPetList" method="post" style="display: inline;">
			        <input type="hidden" name="searchCondition" value="${searchCondition}">
			        <input type="hidden" name="searchKeyword" value="${searchKeyword}">
			        <input type="hidden" name="category" value="cat">
			        <input type="hidden" name="nowPage" value="1">
			        <input class="category ${category == 'cat' ? 'active' : ''}" type="submit" value="고양이">
			    </form>

			    <form action="/MIA/getFindPetList" method="post" style="display: inline;">
  			    	<input type="hidden" name="searchCondition" value="${searchCondition}">
      				<input type="hidden" name="searchKeyword" value="${searchKeyword}">
					<input type="hidden" name="category" value="small">
					<input type="hidden" name="nowPage" value="1">
					<input class="category ${category == 'small' ? 'active' : ''}" type="submit" value="소동물">
			    </form>

  				<form action="/MIA/getFindPetList" method="post" style="display: inline;">
					<input type="hidden" name="searchCondition" value="${searchCondition}">
   					<input type="hidden" name="searchKeyword" value="${searchKeyword}">
       				<input type="hidden" name="category" value="etc">
      				<input type="hidden" name="nowPage" value="1">
      				<input class="category ${category == 'etc' ? 'active' : ''}" type="submit" value="기타">
    			</form>
			</div>

            <div class="n_listform">
                <c:forEach items="${findPetList}" var="findPet">
                    <div class="n_list_item" onclick="selFp(${findPet.fp_seq}, '${searchCondition}', '${searchKeyword}', '${category}', ${paging.nowPage})" style="cursor: pointer;">
                        <a href="/MIA/getFindPet?fp_seq=${findPet.fp_seq}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}&nowPage=${paging.nowPage}">
                            <img src="${pageContext.request.contextPath}/resources/MIA-img/findPetImg/${findPet.fp_img}" 
                            onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/MIA-img/default.png';"
                            alt="Found Pet Image" class="pet-image">
                        </a>
                        <p class="title">${findPet.fp_title}</p>
                        <p class="mark">
                            <c:if test="${findPet.fp_ok == 'Y'}">
                                <span>[찾았어요]</span>
                            </c:if>
                        </p>
                        <p class="place">지역: ${findPet.fp_place}</p>
                        <p class="date">${findPet.fp_date} &nbsp댓글:${findPet.commentCount}</p>
                    </div>
                </c:forEach>
            </div>

            <ul class="pagination">
                <c:if test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
                    <li class="page-item"><a class="page-link" href="/MIA/getFindPetList?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">이전</a></li>
                </c:if>
                <c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}" step="1">
                    <c:choose>
                        <c:when test="${paging.nowPage==i}">
                            <li class="page-item active"><a class="page-link">${i}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="/MIA/getFindPetList?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${paging.nowPage < paging.lastBtn && paging.lastBtn > paging.viewBtnCnt}">
                    <li class="page-item"><a class="page-link" href="/MIA/getFindPetList?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">다음</a></li>
                </c:if>
            </ul>
            <br><br>
        </div>
    </main>
    <jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
    
    <button class="fpIns ph_write"><img src="/resources/images/edit-3.svg" alt="글쓰기"/></button>
</body>
</html>
