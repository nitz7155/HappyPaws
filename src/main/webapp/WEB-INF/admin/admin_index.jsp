<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin_board.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/css/ad_notice.css">
	 <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
		
      var totalAmountList = [
          <c:forEach var="item" items="${getDaysTotalAmount}">
              ['${fn:substring(item.date, 5, 10)}', ${item.total_amount}]<c:if test="${!itemStatus.last}">,</c:if>
          </c:forEach>
      ];
      
      
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['날짜', '판매량'],
          ...totalAmountList
        ]);

        var options = {
          vAxis: {minValue: 0},
          backgroundColor: {
              fill: 'transparent' // 투명 배경 설정
          },
          chartArea: {
              left: 80,
              top: 40,
              width: '70%',
              height: '80%' 
          }
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
    <style type="text/css">
    	g text {
    		font-size: 15px;
    	}
    	td div {
    		font-size : 20px;
    	}
    </style>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/admin/admin_header.jsp" />
	<main>
		<div>
			<div class="admin_title"><h4>최근7일 매출</h4> <h4>일자별 요약</h4></div>
			<div class="section">
				<div id="chart_div" style="width: 100%; height: 100%;" role="img" aria-label="매출 차트: 각 날짜별 판매량을 보여주는 차트입니다."></div>
			</div>
			<div class="section stats">
				<table>
					<caption style="display:none;">일자별 요약</caption>
					<thead>
						<tr>
							<th>날짜</th>
							<th>매출</th>
							<th>커뮤니티 작성수</th>
							<th>회원가입 수</th>
						</tr>
					</thead>
					<c:choose>
		            	<c:when test="${ not empty info}">
		            		<c:forEach var="info" items="${info}">
		            			<tr>
		            				<td>${info.date}</td>
		            				<td><fmt:formatNumber value="${info.total_amount}"  pattern="#,###"/></td>
		            				<td><fmt:formatNumber value="${info.community_count}"  pattern="#,###"/></td>
		            				<td><fmt:formatNumber value="${info.users_count}"  pattern="#,###"/></td>
		            			</tr>
		            		</c:forEach>
		            	</c:when>
		            </c:choose>
				</table>
			</div>		
		</div>
		<div style="margin-top: 10px;">
			<div class="admin_title"><h4>공지사항</h4> <h4>Q&amp;A</h4></div>
			<div class="section notice">
				<table>
				<caption style="display:none;">공지사항</caption>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>작성자</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
	            		<c:when test="${ not empty noticeList}">
	            			<!-- 중요 공지사항 출력 -->
						    <c:forEach var="notice" items="${noticeList}">
						        <c:if test="${notice.n_chk == 'Y'}">
						            <tr class="ad_notice_view important-notice" data-seq="${notice.n_seq}" data-count="${notice.n_count}" data-nowpage="${paging.nowPage}" data-searchcondition="${searchCondition}" data-searchkeyword="${searchKeyword}">
						                <td>공지</td>
						                <td><div class="title-wrapper">${notice.n_title}</div></td> <!-- 중요 공지사항임을 표시 -->
						                <td>${notice.formattedNoticeDate}</td>
						                <td>
						                	<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${notice.us_profile}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" alt="프로필">
						                	${notice.us_nick}
						                </td>
						            </tr>
						        </c:if>
						    </c:forEach>
						
						    <!-- 일반 공지사항 출력 -->
						    <c:forEach var="notice" items="${noticeList}">
						        <c:if test="${notice.n_chk != 'Y'}">
						            <tr class="ad_notice_view" data-seq="${notice.n_seq}" data-count="${notice.n_count}" data-nowpage="${paging.nowPage}" data-searchcondition="${searchCondition}" data-searchkeyword="${searchKeyword}">
						                <td>${notice.n_seq}</td>
						                <td><div class="title-wrapper">${notice.n_title}</div></td>
						                <td>${notice.formattedNoticeDate}</td>
						                <td>
						                	<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${notice.us_profile}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" alt="프로필" >
						                	${notice.us_nick}
						                </td>
						            </tr>
						        </c:if>
						    </c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">등록된 공지사항이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			</div>
			<div class="section qna">
				<table>
					<caption style="display:none;">Q&amp;A</caption>
					<thead>
						<tr>
							<th>등록일</th>
							<th>제목</th>
							<th>작성자</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
		            		<c:when test="${ not empty qnaList}">		
							    <!-- qna 출력 -->
							    <c:forEach var="qna" items="${qnaList}">
							    	<tr class="ad_qna_view" data-seq="${qna.qna_seq}" data-count="${qna.qna_count}" data-nowpage="${paging.nowPage}" data-searchcondition="${searchCondition}" data-searchkeyword="${searchKeyword}">
							            <td>${qna.formattedQnaDate}</td>
							            <td><div class="title-wrapper">${qna.qna_title}</div><c:if test="${qna.comment_count != 0}"> <span style="color: #b9b9b9"> [${qna.comment_count}]</span></c:if></td>
							            <td>
							            	<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${qna.us_profile}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" alt="프로필">
							            	${qna.us_nick}
							            </td>
							        </tr>
							    </c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="4">등록된 QNA가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>		
		</div>
	</main>
</body>
</html>