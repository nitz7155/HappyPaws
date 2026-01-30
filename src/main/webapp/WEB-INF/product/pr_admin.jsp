<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="${pageContext.request.contextPath}/head.jsp"/>
    <style>
        * { box-sizing: border-box; }
        
        body {
            margin: 0;
            padding: 0;
        }
        
        main {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

		.nav-tabs {
		    display: flex;
		    list-style: none;
		    padding: 0;
		    margin: 0;
		    border-bottom: 2px solid #dee2e6;
		}
		
		.tab {
		    padding: 15px 25px;
		    cursor: pointer;
		    border: none;
		    background: transparent;
		    color: #495057;
		    font-size: 16px;
		    font-weight: 500;
		    position: relative;
		}
		
		.tab.active {
		    color: #fcd11e;
		    font-weight: bold;
		}
		
		.tab.active::after {
		    content: '';
		    position: absolute;
		    bottom: -2px;
		    left: 0;
		    width: 100%;
		    height: 2px;
		    background-color: #fcd11e;
		}
		
		.tab-content {
		    display: none;
		    padding: 20px 0;
		}
		
		.tab-content.active {
		    display: block;
		}

        .admin-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border: 1px solid #dee2e6;
            border-left: 0px white;
            border-right: 0px white;
        }

        .admin-table th,
        .admin-table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-paid { background-color: #e3f2fd; color: #2196F3; }
        .status-pending { background-color: #fff3e0; color: #ff9800; }
        .status-cancelled { background-color: #ffebee; color: #f44336; }
        .status-preparation { background-color: #fff3cd; color: #856404; }
        .status-in_transit { background-color: #cce5ff; color: #004085; }
        .status-delivered { background-color: #d4edda; color: #155724; }

        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            margin: 0 2px;
            transition: opacity 0.2s;
        }

        .view-btn { background: #6c757d; color: white; }
        .edit-btn { background: #ffc107; color: black; }
        .delete-btn { background: #dc3545; color: white; }
        .answer-btn { background: #28a745; color: white; }

        .action-btn:hover {
            opacity: 0.8;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            position: relative;
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            width: 70%;
            max-width: 800px;
            border-radius: 8px;
            animation: modalShow 0.3s ease-out;
        }

        @keyframes modalShow {
            from { transform: translateY(-30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .close {
            position: absolute;
            right: 20px;
            top: 15px;
            font-size: 24px;
            cursor: pointer;
            color: #666;
        }

        .close:hover {
            color: #000;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #495057;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-control:focus {
            border-color: #fcd11e;
            outline: none;
        }

        select.form-control {
            height: 40px;
            background-color: white;
        }

        .modal-footer {
            margin-top: 20px;
            text-align: right;
        }

        .star-rating {
            color: #ffd700;
            font-size: 18px;
        }

        .detail-pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin-top: 20px;
        }

        .detail-page-item {
            min-width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .detail-page-item.active {
            position: relative !important; 
            width: 30px !important; 
            height: 30px !important;
            color: black !important;
            background-color: #ffeb994d !important;
            border-radius: 50% !important;
            border: 2px solid #fcd11e !important;
            display: flex !important;
            justify-content: center !important;
            align-items: center !important;
            text-align: center !important;
            line-height: normal !important; 
            padding: 0 !important; 
        }

        .detail-page-link {
            text-decoration: none;
            color: #000;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .detail-page-link:hover {
            color: #fcd11e;
        }
        
		/* 검색 영역 스타일 */
		.search-container {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    position: relative;
		    width: 620px;
		    margin: 0 auto 20px;
		}
		
		#searchForm {
			width: 100%;
		}
		
		.search-input {
		    width: 100%;
		    height: 50px;
		    border: 2px solid #fcd11e;
		    border-radius: 25px;
		    padding: 10px 50px 10px 20px;
		    outline: none;
		    font-size: 16px;
		    line-height: normal;
		}
		
		.search-btn {
		    position: absolute;
		    top: 12px;
		    right: 20px;
		    width: 24px;
		    padding: 0;
		    background: none;
		    border: none;
		    cursor: pointer;
		}
    </style>
    <script>
        $(document).ready(function() {
            // 배송상태 변경 버튼 클릭 이벤트
            $(document).on('click', '.change-delivery-status', function() {
                const orderId = $(this).data('order-id');
                const currentStatus = $(this).data('current-status');
                $('#deliveryStatusModal').data('order-id', orderId).show();
                $('#deliveryStatus').val(currentStatus);
            });

            // 모달 닫기 버튼
            $('.close').click(function() {
                $(this).closest('.modal').hide();
            });

			// 상세 버튼 클릭 이벤트
			$(document).on('click', '.detail-btn', function(e) {
			    e.preventDefault();
			    var orderId = $(this).data('order-id') || 
			                  $(this).closest('tr').find('td:first').text();
			    
			    $.ajax({
			        url: '${pageContext.request.contextPath}/product/get_order_detail',
			        type: 'GET',
			        data: { pror_master_id: orderId },
			        success: function(response) {
			            updateOrderDetailModal(response);
			            $('#orderDetailModal').modal('show');
			        },
			        error: function(xhr, status, error) {
			            console.error('Error:', error);
			            alert('주문 정보를 불러오는데 실패했습니다.');
			        }
			    });
			});
        	
            // URL에서 현재 탭 파라미터 가져오기
            const urlParams = new URLSearchParams(window.location.search);
            const currentTab = urlParams.get('tab') || 'orders'; // 'reviews'

            // 초기 탭 활성화
            $('.tab').removeClass('active');
            $('.tab[data-tab="' + currentTab + '"]').addClass('active');
            $('.tab-content').removeClass('active');
            $('#' + currentTab).addClass('active');

            // 탭 클릭 이벤트
            $('.tab').click(function() {
                const tab = $(this).data('tab');
                location.href = '${pageContext.request.contextPath}/product/pr_admin?tab=' + tab;
            });

            // 리뷰 삭제 버튼 클릭 이벤트
            $(document).on('click', '.delete-review-btn', function() {
                if (confirm('이 리뷰를 삭제하시겠습니까?')) {
                    const reviewNo = $(this).data('review-no');
                    $.ajax({
                        url: '${pageContext.request.contextPath}/product/review_remove',
                        type: 'POST',
                        data: { prc_no: reviewNo },
                        success: function(response) {
                            if (response === 'success') {
                                alert('리뷰가 삭제되었습니다.');
                                location.reload();
                            } else {
                                alert('리뷰 삭제에 실패했습니다.');
                            }
                        },
                        error: function() {
                            alert('서버 오류가 발생했습니다.');
                        }
                    });
                }
            });

            // 문의 답변 버튼 클릭 이벤트 
            $(document).on('click', '.answer-inquiry-btn', function() {
                const inquiryNo = $(this).data('inquiry-no');
                $('#answerInquiryModal').data('inquiry-no', inquiryNo).show();
            });

            // 모달 닫기 버튼
            $('.close').click(function() {
                $(this).closest('.modal').hide();
            });

         	// 배송상태 저장
			$('#saveDeliveryStatus').click(function() {
			    const orderId = $('#deliveryStatusModal').data('order-id');
			    const newStatus = $('#deliveryStatus').val();
			    
			    $.ajax({
			        url: '${pageContext.request.contextPath}/product/update_delivery_status',
			        type: 'POST',
			        data: {
			            pror_master_id: orderId,
			            pror_deli_stat: newStatus
			        },
			        success: function(response) {
			            if (response === 'success') {
			                alert('배송상태가 업데이트되었습니다.');
			                location.reload();
			            } else {
			                alert(response);
			            }
			        },
			        error: function(xhr) {
			            alert(xhr.responseText || '배송상태 업데이트에 실패했습니다.');
			        },
			        beforeSend: function(xhr) {
			            xhr.setRequestHeader("Accept", "text/plain;charset=UTF-8");
			        }
			    });
			});

            // 문의 답변 저장
            $('#saveInquiryAnswer').click(function() {
                const inquiryNo = $('#answerInquiryModal').data('inquiry-no');
                const answer = $('#inquiryAnswer').val();

                if (!answer.trim()) {
                    alert('답변 내용을 입력해주세요.');
                    return;
                }

                $.ajax({
                    url: '${pageContext.request.contextPath}/product/question_answer_write',
                    type: 'POST',
                    data: {
                        prq_no: inquiryNo,
                        prq_comments: answer
                    },
                    success: function(response) {
                        alert('답변이 등록되었습니다.');
                        location.reload();
                    },
                    error: function() {
                        alert('서버 오류가 발생했습니다.');
                    }
                });
            });

            // 엔터키 검색
            $('.search-input').keypress(function(e) {
                if (e.which == 13) {
                    e.preventDefault();
                    $(this).closest('form').submit();
                }
            });

            // 검색 버튼 클릭
            $('.search-btn').click(function(e) {
                e.preventDefault();
                $(this).closest('form').submit();
            });
        });

        function showTab(tab) {
            const targetId = $(tab).data('tab');
            $('.tab').removeClass('active');
            $(tab).addClass('active');
            $('.tab-content').removeClass('active');
            $('#' + targetId).addClass('active');
        }
        
    	// 주문 상세 정보 로드 함수
		function loadOrderDetails(orderId) {
		    $.ajax({
		        url: '${pageContext.request.contextPath}/product/get_order_detail',
		        type: 'GET',
		        data: { pror_master_id: orderId },
		        success: function(response) {
		            // 주소 정보 처리
		            var fullAddress = '';
		            
		            // 우편번호가 있는 경우에만 괄호와 함께 추가
		            if (response.pror_zipcode && response.pror_zipcode.trim() !== '') {
		                fullAddress = '(' + response.pror_zipcode.trim() + ') ';
		            }
		            
		            if (response.pror_addr && response.pror_addr.trim() !== '') {
		                fullAddress += response.pror_addr.trim();
		            }
		            
		            if (response.pror_addr_detail && response.pror_addr_detail.trim() !== '') {
		                fullAddress += ' ' + response.pror_addr_detail.trim();
		            }
		
		            // 기본 정보 업데이트
		            $('.order-id').text(String(response.pror_master_id).padStart(6, '0'));
		            $('.order-date').text(response.pror_date || '');
		            $('.payment-method').text(getPaymentMethodText(response.pror_pay_method));
		            $('.order-status').text(getOrderStatusText(response.pror_status));
		            $('.email').text(response.pror_email || '');
		
		            // 배송 정보 업데이트
		            $('.recipient').text(response.pror_recipient || '');
		            $('.phone').text(response.pror_phone || '');
		            $('.address').text(fullAddress);
		            $('.delivery-status').text(getDeliveryStatusText(response.pror_deli_stat));
		
		            // 상품 목록 업데이트
		            updateOrderItemsList(response.items);
		
		            // 금액 정보 업데이트
		            var product_amt = parseInt(response.pror_product_amt) || 0;
		            var shipping_cost = parseInt(response.pror_ship_cost) || 0;
		            var total_amt = parseInt(response.pror_total_amt) || 0;
		
		            $('.product-amount').text('₩' + product_amt.toLocaleString());
		            $('.shipping-cost').text('₩' + shipping_cost.toLocaleString());
		            $('.total-amount').text('₩' + total_amt.toLocaleString());
		
		            // 모달 표시
		            $('#orderDetailModal').modal('show');
		        },
		        error: function(xhr, status, error) {
		            console.error('Error:', error);
		            alert('주문 정보를 불러오는데 실패했습니다.');
		        }
		    });
		}
		
		function updateOrderItemsList(items) {
		    var productList = $('.product-list');
		    productList.empty();
		    
		    if (items && items.length > 0) {
		        items.forEach(function(item) {
		            var row = $('<tr>');
		            row.append($('<td>').text(item.pr_name || '상품명 없음'));
		            row.append($('<td>').text(item.pr_opt_name || '옵션 없음'));
		            row.append($('<td>').text((item.pror_item_qtt || 0) + '개'));
		            row.append($('<td>').text('₩' + (item.pror_item_amt || 0).toLocaleString()));
		            productList.append(row);
		        });
		    }
		}

        // 상태 텍스트 변환 함수들
        function getPaymentMethodText(method) {
            const methods = {
                'card': '신용카드'
            };
            return methods[method] || method;
        }

        function getOrderStatusText(status) {
            const statuses = {
                'pending': '결제대기',
                'paid': '결제완료',
                'cancelled': '취소됨'
            };
            return statuses[status] || status;
        }

        function getDeliveryStatusText(status) {
            const statuses = {
                'preparation': '배송준비중',
                'in_transit': '배송중',
                'delivered': '배송완료'
            };
            return statuses[status] || status;
        }    
        
     	// 모달 내용 업데이트 함수
		function updateOrderDetailModal(data) {
		    // 기본 정보 업데이트
		    $('.order-id').text(String(data.pror_master_id).padStart(6, '0'));
		    $('.order-date').text(data.pror_date || '');
		    $('.order-status').text(getOrderStatusText(data.pror_status));
		    $('.payment-method').text(getPaymentMethodText(data.pror_pay_method));
		    $('.delivery-status').text(getDeliveryStatusText(data.pror_deli_stat));
		    $('.email').text(data.pror_email || '');
		    
		    // 배송 정보 업데이트
		    $('.recipient').text(data.pror_recipient || '');
		    $('.phone').text(data.pror_phone || '');
		    
		    // 주소 정보 처리
		    var fullAddress = '';
		    
		    if (data.pror_zipcode && String(data.pror_zipcode).trim() !== '') {
		        fullAddress = '(' + String(data.pror_zipcode).trim() + ') ';
		    }
		    if (data.pror_addr && data.pror_addr.trim() !== '') {
		        fullAddress += data.pror_addr.trim();
		    }
		    if (data.pror_addr_detail && data.pror_addr_detail.trim() !== '') {
		        fullAddress += ' ' + data.pror_addr_detail.trim();
		    }
		    
		    $('.address').text(fullAddress);
		
		    // 상품 목록 업데이트
		    var productList = $('.product-list');
		    productList.empty();
		    if (data.items && data.items.length > 0) {
		        data.items.forEach(function(item) {
		            var row = $('<tr>');
		            row.append($('<td>').text(item.pr_name || '상품명 없음'));
		            row.append($('<td>').text(item.pr_opt_name || '옵션 없음'));
		            row.append($('<td>').text((item.pror_item_qtt || 0) + '개'));
		            row.append($('<td>').text('₩' + (item.pror_item_amt || 0).toLocaleString()));
		            productList.append(row);
		        });
		    }
		
		    // 금액 정보 업데이트
		    $('.product-amount').text('₩' + (data.pror_product_amt || 0).toLocaleString());
		    $('.shipping-cost').text('₩' + (data.pror_ship_cost || 0).toLocaleString());
		    $('.total-amount').text('₩' + (data.pror_total_amt || 0).toLocaleString());
		}
     	
        function updateProductList(data) {
            var productList = $('.product-list');
            productList.empty();
            if (data.items && data.items.length > 0) {
                data.items.forEach(function(item) {
                    var row = $('<tr>');
                    row.append($('<td>').text(item.pr_name || ''));
                    row.append($('<td>').text(item.pr_opt_name || ''));
                    row.append($('<td>').text((item.pror_item_qtt || 0) + '개'));
                    row.append($('<td>').text('₩' + (item.pror_item_amt || 0).toLocaleString()));
                    productList.append(row);
                });
            }
        }

        function updatePriceInfo(data) {
            $('.product-amount').text('₩' + (data.pror_product_amt || 0).toLocaleString());
            $('.shipping-cost').text('₩' + (data.pror_ship_cost || 0).toLocaleString());
            $('.total-amount').text('₩' + (data.pror_total_amt || 0).toLocaleString());
        }
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/admin/admin_header.jsp" />
    <main>
<!-- 		<div class="nav-tabs"> -->
<%-- 		    <button class="tab ${param.tab eq 'reviews' ? 'active' : ''}" data-tab="reviews">리뷰 관리</button> --%>
<%-- 		    <button class="tab ${param.tab eq 'inquiries' ? 'active' : ''}" data-tab="inquiries">문의 관리</button> --%>
<%-- 		    <button class="tab ${empty param.tab || param.tab eq 'orders' ? 'active' : ''}" data-tab="orders">주문/배송 관리</button> --%>
<!-- 		</div> -->
        
        <!-- 리뷰 관리 탭 -->
		<div id="reviews" class="tab-content ${param.tab eq 'reviews' ? 'active' : ''}">
		    <div class="search-container">
		        <input type="text" class="search-input" placeholder="상품명 또는 작성자 검색">
		        <button class="search-btn">검색</button>
		    </div>
		    <table class="admin-table">
		        <thead>
		            <tr>
		                <th>리뷰 번호</th>
		                <th>상품명</th>
		                <th>작성자</th>
		                <th>평점</th>
		                <th>리뷰 내용</th>
		                <th>작성일</th>
		                <th>관리</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:choose>
		                <c:when test="${not empty reviews}">
		                    <c:forEach var="review" items="${reviews}">
		                        <tr>
		                            <td>${review.prc_no}</td>
		                            <td>${review.pr_name}</td>
		                            <td>${review.us_id}</td>
		                            <td>
		                                <div class="star-rating">
		                                    <c:forEach begin="1" end="5" var="i">
		                                        <span class="star ${i <= review.prc_rating ? 'filled' : ''}" 
		                                              style="color: ${i <= review.prc_rating ? '#ffd700' : '#ccc'}">★</span>
		                                    </c:forEach>
		                                </div>
		                            </td>
		                            <td>${review.prc_desc}</td>
		                            <td>${review.prc_start_date}</td>
		                            <td>
		                                <button class="action-btn view-btn" 
		                                        onclick="location.href='${pageContext.request.contextPath}/product/pr_detail?pr_id=${review.pr_id}&tab=reviews'">상세</button>
		                                <button class="action-btn delete-btn delete-review-btn" 
		                                        data-review-no="${review.prc_no}">삭제</button>
		                            </td>
		                        </tr>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <tr>
		                        <td colspan="7" class="text-center">등록된 리뷰가 없습니다.</td>
		                    </tr>
		                </c:otherwise>
		            </c:choose>
		        </tbody>
		    </table>
			<c:if test="${not empty reviews}">
			    <div class="detail-pagination">
			        <c:if test="${reviewPaging.btnFirst > 1}">
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=1&tab=reviews">＜＜</a>
			            </span>
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=${reviewPaging.btnFirst-1}&tab=reviews">＜</a>
			            </span>
			        </c:if>
			        
			        <c:forEach var="i" begin="${reviewPaging.btnFirst}" end="${reviewPaging.btnLast}">
			            <span class="detail-page-item ${reviewPaging.btnCur == i ? 'active' : ''}">
			                <a class="detail-page-link" href="?page=${i}&tab=reviews">${i}</a>
			            </span>
			        </c:forEach>
			        
			        <c:if test="${reviewPaging.btnLast < reviewPaging.btnTotalCount}">
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=${reviewPaging.btnLast+1}&tab=reviews">＞</a>
			            </span>
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=${reviewPaging.btnTotalCount}&tab=reviews">＞＞</a>
			            </span>
			        </c:if>
			    </div>
			</c:if>
		</div>
        
        <!-- 문의 관리 탭 -->
		<div id="inquiries" class="tab-content ${param.tab eq 'inquiries' ? 'active' : ''}">
			<div class="search-container">
			    <input type="text" class="search-input" placeholder="주문번호 또는 주문자명 검색">
			    <img src="${pageContext.request.contextPath}/resources/images/searchicon.png" alt="검색" class="search-btn" style="cursor:pointer;">
			</div>
		    <table class="admin-table">
		        <thead>
		            <tr>
		                <th>문의 번호</th>
		                <th>상품명</th>
		                <th>작성자</th>
		                <th>문의 내용</th>
		                <th>답변 상태</th>
		                <th>작성일</th>
		                <th>관리</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:choose>
		                <c:when test="${not empty inquiries}">
		                    <c:forEach var="inquiry" items="${inquiries}">
		                        <tr>
		                            <td>${inquiry.prq_no}</td>
		                            <td>${inquiry.pr_name}</td>
		                            <td>${inquiry.us_id}</td>
		                            <td>${inquiry.prq_desc}</td>
		                            <td>
		                                <span class="status-badge ${empty inquiry.prq_comments ? 'status-pending' : 'status-delivered'}">
		                                    ${empty inquiry.prq_comments ? '답변대기' : '답변완료'}
		                                </span>
		                            </td>
		                            <td>${inquiry.prq_date}</td>
		                            <td>
		                                <button class="action-btn view-btn" 
		                                        onclick="location.href='${pageContext.request.contextPath}/product/pr_detail?pr_id=${inquiry.pr_id}&tab=inquiries'">상세</button>
		                                <c:if test="${empty inquiry.prq_comments}">
		                                    <button class="action-btn answer-btn answer-inquiry-btn" 
		                                            data-inquiry-no="${inquiry.prq_no}">답변</button>
		                                </c:if>
		                            </td>
		                        </tr>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <tr>
		                        <td colspan="7" class="text-center">등록된 문의가 없습니다.</td>
		                    </tr>
		                </c:otherwise>
		            </c:choose>
		        </tbody>
		    </table>
			<c:if test="${not empty inquiries}">
			    <div class="detail-pagination">
			        <c:if test="${inquiryPaging.btnFirst > 1}">
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=1&tab=inquiries">＜＜</a>
			            </span>
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=${inquiryPaging.btnFirst-1}&tab=inquiries">＜</a>
			            </span>
			        </c:if>
			        
			        <c:forEach var="i" begin="${inquiryPaging.btnFirst}" end="${inquiryPaging.btnLast}">
			            <span class="detail-page-item ${inquiryPaging.btnCur == i ? 'active' : ''}">
			                <a class="detail-page-link" href="?page=${i}&tab=inquiries">${i}</a>
			            </span>
			        </c:forEach>
			        
			        <c:if test="${inquiryPaging.btnLast < inquiryPaging.btnTotalCount}">
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=${inquiryPaging.btnLast+1}&tab=inquiries">＞</a>
			            </span>
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=${inquiryPaging.btnTotalCount}&tab=inquiries">＞＞</a>
			            </span>
			        </c:if>
			    </div>
			</c:if>
		</div>
        
        <!-- 주문/배송 관리 탭 -->
		<div id="orders" class="tab-content ${empty param.tab || param.tab eq 'orders' ? 'active' : ''}">
			<div class="search-container">
			    <form id="searchForm" action="${pageContext.request.contextPath}/product/pr_admin" method="get">
			        <input type="hidden" name="tab" value="${param.tab != null ? param.tab : 'orders'}">
			        <input type="text" name="searchKeyword" class="search-input" placeholder="주문번호 또는 주문자명 검색" value="${searchKeyword}">
			        <button type="submit" class="search-btn">
			            <img src="${pageContext.request.contextPath}/resources/images/searchicon.png" alt="검색" title="검색">
			        </button>
			    </form>
			</div>
		    <table class="admin-table">
		        <thead>
		            <tr>
		                <th>주문 번호</th>
		                <th>주문자</th>
		                <th>상품명</th>
		                <th>결제 금액</th>
		                <th>주문 상태</th>
		                <th>배송 상태</th>
		                <th>주문일</th>
		                <th>관리</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:choose>
		                <c:when test="${not empty orders}">
		                    <c:forEach var="order" items="${orders}">
		                        <tr>
		                            <td>${order.pror_master_id}</td>
		                            <td>${order.us_id}</td>
		                            <td>${order.pr_name}</td>
		                            <td>₩<fmt:formatNumber value="${order.pror_total_amt}" pattern="#,###"/></td>
		                            <td>
		                                <span class="status-badge status-${order.pror_status}">
		                                    <c:choose>
		                                        <c:when test="${order.pror_status eq 'paid'}">결제완료</c:when>
		                                        <c:when test="${order.pror_status eq 'pending'}">결제대기</c:when>
		                                        <c:when test="${order.pror_status eq 'cancelled'}">취소됨</c:when>
		                                    </c:choose>
		                                </span>
		                            </td>
		                            <td>
		                                <span class="status-badge status-${order.pror_deli_stat}">
		                                    <c:choose>
		                                        <c:when test="${order.pror_deli_stat eq 'preparation'}">배송준비</c:when>
		                                        <c:when test="${order.pror_deli_stat eq 'in_transit'}">배송중</c:when>
		                                        <c:when test="${order.pror_deli_stat eq 'delivered'}">배송완료</c:when>
		                                    </c:choose>
		                                </span>
		                            </td>
		                            <td>${order.pror_date}</td>
		                            <td>
		                                <button class="action-btn view-btn detail-btn" 
		                                        data-order-id="${order.pror_master_id}">상세</button>
		                                <button class="action-btn edit-btn change-delivery-status"
		                                        data-order-id="${order.pror_master_id}" 
		                                        data-current-status="${order.pror_deli_stat}">배송상태변경</button>
		                            </td>
		                        </tr>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <tr>
		                        <td colspan="8" class="text-center">등록된 주문이 없습니다.</td>
		                    </tr>
		                </c:otherwise>
		            </c:choose>
		        </tbody>
		    </table>
			<c:if test="${not empty orders}">
			    <div class="detail-pagination">
			        <c:if test="${orderPaging.btnFirst > 1}">
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=1&tab=orders">＜＜</a>
			            </span>
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=${orderPaging.btnFirst-1}&tab=orders">＜</a>
			            </span>
			        </c:if>
			        
			        <c:forEach var="i" begin="${orderPaging.btnFirst}" end="${orderPaging.btnLast}">
			            <span class="detail-page-item ${orderPaging.btnCur == i ? 'active' : ''}">
			                <a class="detail-page-link" href="?page=${i}&tab=orders">${i}</a>
			            </span>
			        </c:forEach>
			        
			        <c:if test="${orderPaging.btnLast < orderPaging.btnTotalCount}">
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=${orderPaging.btnLast+1}&tab=orders">＞</a>
			            </span>
			            <span class="detail-page-item">
			                <a class="detail-page-link" href="?page=${orderPaging.btnTotalCount}&tab=orders">＞＞</a>
			            </span>
			        </c:if>
			    </div>
			</c:if>
		</div>
	    <!-- 문의 답변 모달 -->
	    <div id="answerInquiryModal" class="modal">
	        <div class="modal-content">
	            <span class="close">&times;</span>
	            <h2>문의 답변</h2>
	            <div class="form-group">
	                <label for="inquiryAnswer">답변 내용</label>
	                <textarea id="inquiryAnswer" class="form-control" rows="5" required></textarea>
	            </div>
	            <div class="modal-footer">
	                <button class="action-btn view-btn" onclick="$('#answerInquiryModal').hide()">취소</button>
	                <button id="saveInquiryAnswer" class="action-btn answer-btn">답변 등록</button>
	            </div>
	        </div>
	    </div>
	    
		<!-- 배송상태 변경 모달 -->
		<div id="deliveryStatusModal" class="modal">
		    <div class="modal-content">
		        <span class="close">&times;</span>
		        <h2>배송상태 변경</h2>
		        <div class="form-group">
		            <label for="deliveryStatus">배송상태 선택</label>
		            <select id="deliveryStatus" class="form-control">
		                <option value="preparation">배송준비</option>
		                <option value="in_transit">배송중</option>
		                <option value="delivered">배송완료</option>
		            </select>
		        </div>
		        <div class="modal-footer">
		            <button class="action-btn view-btn" onclick="$('#deliveryStatusModal').hide()">취소</button>
		            <button id="saveDeliveryStatus" class="action-btn edit-btn">저장</button>
		        </div>
		    </div>
		</div>
		<div class="modal fade" id="orderDetailModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		    <div class="modal-dialog modal-xl">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title">주문 상세 정보</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <!-- 주문 정보 섹션 -->
		                <div class="order-info-section mb-4">
		                    <h6 class="section-title">주문 정보</h6>
		                    <div class="row">
		                        <div class="col-md-6">
		                            <label>주문번호</label>
		                            <p class="order-id"></p>
		                        </div>
		                        <div class="col-md-6">
		                            <label>주문일자</label>
		                            <p class="order-date"></p>
		                        </div>
		                        <div class="col-md-6">
		                            <label>주문상태</label>
		                            <p class="order-status"></p>
		                        </div>
		                        <div class="col-md-6">
		                            <label>결제방법</label>
		                            <p class="payment-method"></p>
		                        </div>
		                    </div>
		                </div>
		
		                <!-- 상품 정보 섹션 -->
		                <div class="product-info-section mb-4">
		                    <h6 class="section-title">상품 정보</h6>
		                    <div class="table-responsive">
		                        <table class="table">
		                            <thead>
		                                <tr>
		                                    <th>상품명</th>
		                                    <th>옵션</th>
		                                    <th>수량</th>
		                                    <th>상품금액</th>
		                                </tr>
		                            </thead>
		                            <tbody class="product-list"></tbody>
		                        </table>
		                    </div>
		                </div>
		
		                <!-- 배송 정보 섹션 -->
		                <div class="delivery-info-section mb-4">
		                    <h6 class="section-title">배송 정보</h6>
		                    <div class="row">
		                        <div class="col-md-6">
		                            <label>받는사람</label>
		                            <p class="recipient"></p>
		                        </div>
		                        <div class="col-md-6">
		                            <label>연락처</label>
		                            <p class="phone"></p>
		                        </div>
		                        <div class="col-md-12">
		                            <label>배송주소</label>
		                            <p class="address"></p>
		                        </div>
		                        <div class="col-md-6">
		                            <label>배송상태</label>
		                            <p class="delivery-status"></p>
		                        </div>
		                        <div class="col-md-6">
		                            <label>이메일</label>
		                            <p class="email"></p>
		                        </div>
		                    </div>
		                </div>
		
		                <!-- 결제 정보 섹션 -->
		                <div class="price-info-section">
		                    <h6 class="section-title">결제 정보</h6>
		                    <div class="row">
		                        <div class="col-md-6">
		                            <label>상품금액</label>
		                            <p class="product-amount"></p>
		                        </div>
		                        <div class="col-md-6">
		                            <label>배송비</label>
		                            <p class="shipping-cost"></p>
		                        </div>
		                        <div class="col-md-12">
		                            <label>총 결제금액</label>
		                            <p class="total-amount"></p>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>		
    </main>
</body>