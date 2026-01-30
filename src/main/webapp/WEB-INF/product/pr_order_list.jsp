<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="${pageContext.request.contextPath}/head.jsp"/>
    <style>
		* {
		    box-sizing: border-box;
		}
		
		body {
		    margin: 0;
		    padding: 0;
		}
		
		main {
		    max-width: 1000px;
		    margin: 0 auto;
		}
		
		a {
		    text-decoration: none;
		}
		
		.nav-tabs {
		    display: flex;
		    list-style: none;
		    padding: 0;
		    margin: 0 0 20px 0;
		    border-bottom: 1px solid #dee2e6;
		}
		
		.nav-item {
		    margin-bottom: -1px;
		}
		
		.nav-link {
		    display: block;
		    padding: 12px 20px;
		    color: #495057;
		    border: 1px solid transparent;
		    border-radius: 4px 4px 0 0;
		    font-weight: 500;
		}
		
		.nav-link.active {
		    color: #2196F3;
		    border-color: #dee2e6 #dee2e6 #fff;
		    background-color: #fff;
		    font-weight: bold;
		}
		
		.tab-content {
		    display: none;
		}
		
		.tab-content.active {
		    display: block;
		}
		
		.period-filters {
		    display: flex;
		    gap: 10px;
		    margin-bottom: 20px;
		}
		
		.period-btn {
		    padding: 8px 16px;
		    border: 1px solid #dee2e6;
		    background: white;
		    border-radius: 4px;
		    cursor: pointer;
		}
		
		.period-btn.active {
		    background: #6c757d;
		    color: white;
		}
		
		.search-btn {
		    padding: 8px 20px;
		    background: #2196F3;
		    color: white;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		}
		
		.order-table,
		.wishlist-table {
		    width: 100%;
		    border-collapse: collapse;
		    background: white;
		    margin-top: 20px;
		}
		
		.order-table th,
		.order-table td,
		.wishlist-table th,
		.wishlist-table td {
		    padding: 15px;
		    text-align: center;
		    border: 1px solid #dee2e6;
		}
		
		.order-table th,
		.wishlist-table th {
		    background: #f8f9fa;
		    font-weight: 500;
		}
		
		.status-badge,
		.delivery-badge {
		    display: inline-block;
		    padding: 5px 10px;
		    border-radius: 15px;
		    font-size: 11px;
		    font-weight: 500;
		}
		
		.status-paid {
		    background-color: #e3f2fd;
		    color: #2196F3;
		}
		
		.status-pending {
		    background-color: #fff3e0;
		    color: #ff9800;
		}
		
		.status-cancelled {
		    background-color: #ffebee;
		    color: #f44336;
		}
		
		.delivery-preparation {
		    background-color: #fff3cd;
		    color: #856404;
		}
		
		.delivery-in_transit {
		    background-color: #cce5ff;
		    color: #004085;
		}
		
		.delivery-delivered {
		    background-color: #d4edda;
		    color: #155724;
		}
		
		.detail-btn {
		    padding: 5px 10px;
		    background: #6c757d;
		    color: white;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    text-decoration: none;
		    font-size: 12px;
		}
		
		.wishlist-container {
		    padding: 20px;
		}
		
		.wishlist-img {
		    width: 100px;
		    height: auto;
		    transition: opacity 0.2s;
		}
		
		.product-info {
		    text-align: left;
		    font-size: 20px;
		    color: #fcd11e;
		}
		
		.wishlist-btn-group {
		    display: flex;
		    flex-direction: column;
		    gap: 5px;
		}
		
		.btn-remove,
		.btn-remove-selected {
		    padding: 8px 16px;
		    border-radius: 6px;
		    cursor: pointer;
		    font-size: 13px;
		    transition: all 0.2s ease;
		}
		
		.btn-remove {
		    border: 1px solid #dc3545;
		    background: #fff;
		    color: #dc3545;
		}
		
		.btn-remove:hover {
		    background: #dc3545;
		    color: white;
		    transform: translateY(-1px);
		    box-shadow: 0 2px 4px rgba(220, 53, 69, 0.2);
		}
		
		.btn-remove-selected {
		    background: #fff;
		    color: #495057;
		    border: 1px solid #495057;
		}
		
		.btn-remove-selected:hover {
		    background: #495057;
		    color: white;
		    transform: translateY(-1px);
		    box-shadow: 0 2px 4px rgba(73, 80, 87, 0.2);
		}
		
		.wishlist-controls {
		    display: flex;
		    justify-content: flex-end;
		    margin: 20px 0;
		    padding-right: 20px;
		}
		
		.wishlist-checkbox,
		#selectAllWishlist {
		    width: 16px;
		    height: 16px;
		    border-radius: 4px;
		    border: 1.5px solid #495057;
		    appearance: none;
		    background-color: #fff;
		    cursor: pointer;
		    position: relative;
		    transition: all 0.2s ease;
		}
		
		.wishlist-checkbox:checked,
		#selectAllWishlist:checked {
		    background-color: #495057;
		}
		
		.wishlist-checkbox:checked::after,
		#selectAllWishlist:checked::after {
		    content: '✓';
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    color: white;
		    font-size: 10px;
		}
		
		.detail-pagination {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 5px;
		    margin: 20px 0;
		    flex-wrap: wrap;
		}
		
		.detail-page-item {
		    min-width: 32px;
		    height: 32px;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    cursor: pointer;
		}
		
		.detail-page-item:hover {
		    color: #fcd11e !important;
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
		    font-size: 18px;
		}
		
		.detail-page-link:hover {
		    color: #fcd11e;
		}
		
		.section-title {
		    padding-bottom: 10px;
		    margin-bottom: 20px;
		    border-bottom: 1px solid #dee2e6;
		    font-weight: bold;
		}
		
		.modal label {
		    color: #666;
		    font-size: 14px;
		    margin-bottom: 5px;
		}
		
		.modal p {
		    font-size: 15px;
		    margin-bottom: 15px;
		}
		
		.total-amount {
		    font-weight: bold;
		    color: #dc3545;
		}
		
		.desktop-table {
		    display: table;
		}
		
		.mobile-table {
		    display: none;
		}
		
		.modal-dialog {
		    transform: none !important;
		}
		
		.modal-body {
		    padding: 20px;
		}
		
		.section-title {
		    padding-bottom: 10px;
		    margin-bottom: 20px;
		    border-bottom: 1px solid #dee2e6;
		    font-weight: bold;
		}
		
		.modal label {
		    color: #666;
		    font-size: 14px;
		    margin-bottom: 5px;
		}
		
		.modal p {
		    font-size: 15px;
		    margin-bottom: 15px;
		}
		
		.modal .table th,
		.modal .table td {
		    padding: 12px;
		    vertical-align: middle;
		}
		
		.total-amount {
		    font-weight: bold;
		    color: #dc3545;
		}
		
		@media screen and (max-width: 768px) {
		    main {
		        padding: 0 15px;
		    }
		
		    .period-filters {
		        flex-wrap: wrap;
		    }
		
		    .search-btn {
		        width: 100%;
		        margin-top: 10px;
		    }
		
		    .desktop-table {
		        display: none;
		    }
		
		    .mobile-table {
		        display: table;
		        width: 100%;
		    }
		
		    .mobile-table th {
		        background: #f8f9fa;
		        padding: 12px 8px;
		        font-size: 13px;
		        text-align: center;
		        border-bottom: 2px solid #dee2e6;
		    }
		
		    .mobile-table td {
		        padding: 12px 8px;
		        border-bottom: 1px solid #dee2e6;
		        vertical-align: middle;
		    }
		
		    .order-info-cell {
		        width: 40%;
		    }
		
		    .order-number,
		    .product-name {
		        font-weight: 500;
		        font-size: 13px;
		        color: #495057;
		        margin-bottom: 4px;
		    }
		
		    .order-date {
		        font-size: 12px;
		        color: #868e96;
		    }
		
		    .payment-cell {
		        width: 25%;
		        text-align: right;
		        font-weight: 500;
		        font-size: 13px;
		    }
		
		    .status-cell {
		        width: 35%;
		    }
		
		    .status-wrapper {
		        display: flex;
		        flex-direction: column;
		        gap: 4px;
		        align-items: flex-start;
		    }
		
		    .status-badge,
		    .delivery-badge {
		        width: 100%;
		        text-align: center;
		        font-size: 11px;
		        padding: 4px 0;
		    }
		
		    .detail-btn {
		        width: 100%;
		        text-align: center;
		        font-size: 11px;
		        padding: 4px 0;
		        margin-top: 4px;
		    }
		    
		    .wishlist-container {
		        padding: 10px;
		    }
		
		    .wishlist-table.desktop-table {
		        display: none;
		    }
		
		    .wishlist-table.mobile-table {
		        display: table;
		        width: 100%;
		    }
		
		    .wishlist-table.mobile-table th,
		    .wishlist-table.mobile-table td {
		        padding: 12px 8px;
		        font-size: 14px;
		    }
		
		    .product-info-cell {
		        text-align: left;
		    }
		
		    .product-name {
		        font-size: 14px;
		        margin-bottom: 8px;
		        font-weight: 500;
		    }
		
		    .product-name a {
		        color: #000;
		        text-decoration: none;
		    }
		
		    .product-price {
		        font-size: 15px;
		        color: #2196F3;
		        font-weight: 500;
		    }
		
		    .btn-remove {
		        width: 100%;
		        padding: 8px 12px;
		        font-size: 13px;
		    }
		
		    .wishlist-checkbox,
		    #selectAllWishlistMobile {
		        width: 20px;
		        height: 20px;
		    }
		
		    .wishlist-controls {
		        padding: 10px;
		    }
		
		    .btn-remove-selected {
		        padding: 10px 20px;
		        width: auto;
		        min-width: 120px;
		    }		
		    
		    .modal-body {
		        padding: 15px;
		    }
		
		    .modal .table {
		        font-size: 14px; 
		    }
		
		    .modal .table th,
		    .modal .table td {
		        padding: 8px; 
		    }
		
		    .section-title {
		        font-size: 16px;
		        margin-bottom: 15px;
		    }
		
		    .modal label {
		        font-size: 13px;
		    }
		
		    .modal p {
		        font-size: 14px;
		        margin-bottom: 10px;
		    }
		
		    .product-info-section .table {
		        font-size: 13px; 
		    }
		
		    .product-info-section .table th,
		    .product-info-section .table td {
		        padding: 6px 4px; 
		        word-break: break-word; 
		    }    
		}
		
		@media screen and (max-width: 480px) {
		    .mobile-table th,
		    .mobile-table td {
		        padding: 8px 4px;
		    }
		
		    .order-number,
		    .product-name {
		        font-size: 12px;
		    }
		
		    .order-date {
		        font-size: 11px;
		    }
		
		    .payment-cell {
		        font-size: 12px;
		    }
		
		    .status-badge,
		    .delivery-badge,
		    .detail-btn {
		        font-size: 10px;
		    }
		
		    .period-btn {
		        font-size: 13px;
		        padding: 6px 12px;
		    }
		
		    .detail-page-item {
		        min-width: 24px;
		        height: 24px;
		    }
		
		    .detail-page-link {
		        padding: 3px 6px;
		        font-size: 13px;
		    }
		    
		    .wishlist-table.mobile-table th,
		    .wishlist-table.mobile-table td {
		        padding: 8px 6px;
		        font-size: 13px;
		    }
		
		    .product-name {
		        font-size: 13px;
		    }
		
		    .product-price {
		        font-size: 14px;
		    }
		
		    .btn-remove {
		        padding: 6px 10px;
		        font-size: 12px;
		    }
		
		    .btn-remove-selected {
		        padding: 8px 16px;
		        font-size: 12px;
		    }	
		    
		    .modal-body {
		        padding: 10px;
		    }
		
		    .modal .table {
		        font-size: 12px; 
		    }
		
		    .modal .table th,
		    .modal .table td {
		        padding: 6px 4px; 
		    }
		
		    .product-info-section .table {
		        font-size: 11px; 
		    }
		
		    .product-info-section .table th,
		    .product-info-section .table td {
		        padding: 4px 2px; 
		    }
		
		    .section-title {
		        font-size: 15px;
		        margin-bottom: 10px;
		    }
		
		    .modal label {
		        font-size: 12px;
		    }
		
		    .modal p {
		        font-size: 13px;
		        margin-bottom: 8px;
		    }	    
		}		
    </style>
	<script>
		$(document).ready(function() {
		    // 현재 활성화된 탭 확인
		    const currentTab = '${activeTab}';
		
		    // 주문내역 탭 관련 코드
		    if (currentTab === 'orders' || !currentTab) {
		        // 날짜 관련 코드는 주문내역 탭에서만 실행
		        const today = new Date();
		        
		        // 기간 필터 버튼 클릭 이벤트
		        $('.period-btn').click(function() {
		            $('.period-btn').removeClass('active');
		            $(this).addClass('active');
		            
		            const period = $(this).data('period');
		            window.location.href = '/product/pr_order_list?period=' + period + '&tab=orders';
		        });
		        
		        // 조회 버튼 클릭 이벤트
		        $('.search-btn').click(function() {
		            const startDate = $('#startDate').val();
		            const endDate = $('#endDate').val();
		            
		            if (!startDate || !endDate) {
		                alert('조회 기간을 선택해주세요.');
		                return;
		            }
		            
		            if (startDate > endDate) {
		                alert('시작일은 종료일보다 클 수 없습니다.');
		                return;
		            }
		            
		            window.location.href = '/product/pr_order_list?startDate=' + startDate + 
		                                 '&endDate=' + endDate + '&tab=orders';
		        });
		
		        // 현재 선택된 기간에 따라 버튼 활성화
		        const currentPeriod = '${period}';
		        if (currentPeriod) {
		            $('.period-btn[data-period="' + currentPeriod + '"]').addClass('active');
		        }
		
		        // 상세보기 버튼 클릭 이벤트
		        $('.detail-btn').click(function(e) {
		            e.preventDefault();
		            const orderId = $(this).data('order-id');
		            loadOrderDetails(orderId);
		        });
		
		     	// 주문 취소 버튼 클릭 이벤트
		        $('.cancel-order-btn').click(function() {
		            if (!confirm('주문을 취소하시겠습니까?')) return;
		            
		            const orderId = $(this).data('order-id');
		            
		            // 주문 정보 조회
		            $.ajax({
		                url: '${pageContext.request.contextPath}/product/get_order_detail',
		                type: 'GET',
		                data: { pror_master_id: orderId },
		                success: function(response) {
	
		                    // merchant_uid 체크
		                    if (!response.merchant_uid) {
		                        alert('결제 정보(merchant_uid)를 찾을 수 없습니다.');
		                        return;
		                    }
	
		                    // 주문 상태 체크
		                    if (response.pror_status !== 'paid' || response.pror_deli_stat !== 'preparation') {
		                        alert('배송준비 상태의 주문만 취소가 가능합니다.');
		                        return;
		                    }
	
		                    // 포트원 결제 취소 요청
		                    $.ajax({
		                        url: '${pageContext.request.contextPath}/product/payCancel',
		                        type: 'POST',
		                        data: { merchant_uid: response.merchant_uid },
		                        success: function(cancelResponse) {
		                            if (cancelResponse.success) {
		                                alert('주문이 취소되었습니다.');
		                                location.reload();
		                            } else {
		                                alert(cancelResponse.message || '주문 취소에 실패했습니다.');
		                            }
		                        },
		                        error: function(xhr) {
		                            console.error('결제 취소 오류:', xhr);
		                            alert('결제 취소 중 오류가 발생했습니다.');
		                        }
		                    });
		                },
		                error: function(xhr) {
		                    console.error('주문 정보 조회 오류:', xhr);
		                    alert('주문 정보를 불러오는데 실패했습니다.');
		                }
		            });
		        });
		    }
		
		    // 위시리스트 탭 관련 코드
		    if (currentTab === 'wishlist') {
		        // 데스크톱 전체 선택 체크박스
		        $('#selectAllWishlist').on('change', function() {
		            const isChecked = $(this).prop('checked');
		            $('.wishlist-checkbox').prop('checked', isChecked);
		        });
		        
		        // 모바일 전체 선택 체크박스
		        $('#selectAllWishlistMobile').on('change', function() {
		            const isChecked = $(this).prop('checked');
		            $('.wishlist-checkbox').prop('checked', isChecked);
		            // 데스크톱 체크박스와 동기화
		            $('#selectAllWishlist').prop('checked', isChecked);
		        });
		        
		        // 개별 체크박스 변경 시
		        $('.wishlist-checkbox').on('change', function() {
		            const totalCheckboxes = $('.wishlist-checkbox').length;
		            const checkedCheckboxes = $('.wishlist-checkbox:checked').length;
		            // 데스크톱과 모바일 전체 선택 체크박스 모두 업데이트
		            $('#selectAllWishlist, #selectAllWishlistMobile').prop('checked', totalCheckboxes === checkedCheckboxes);
		        });
		
		     	// 선택 삭제 버튼 클릭
		        $('.btn-remove-selected').click(function() {
		            const selectedItems = $('.wishlist-checkbox:checked').map(function() {
		                return parseInt($(this).val());
		            }).get();
		            
		            if (selectedItems.length === 0) {
		                alert('삭제할 상품을 선택해주세요.');
		                return;
		            }
		            
		            if (confirm('선택한 상품을 위시리스트에서 삭제하시겠습니까?')) {
		                $.ajax({
		                    url: '${pageContext.request.contextPath}/product/remove_from_wishlist',
		                    type: 'POST',
		                    contentType: 'application/json',
		                    data: JSON.stringify({ prwl_nos: selectedItems }),
		                    success: function(response) {
		                        if (response === 'success') {
		                            alert('선택한 상품이 삭제되었습니다.');
		                            location.reload();
		                        } else {
		                            alert(response);
		                        }
		                    },
		                    error: function(xhr) {
		                        if (xhr.status === 401) {
		                            if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
		                                window.location.href = '${pageContext.request.contextPath}/auth/login';
		                            }
		                        } else {
		                            alert('삭제 중 오류가 발생했습니다.');
		                        }
		                    }
		                });
		            }
		        });
		    }
		
		    // 공통 코드 (탭 클릭 이벤트)
		    $('.nav-link').click(function(e) {
		        e.preventDefault();
		        const tabId = $(this).parent().find('a').attr('href').split('tab=')[1];
		        window.location.href = '/product/pr_order_list?tab=' + tabId;
		    });
		});
	
		function loadOrderDetails(orderId) {
		    $.ajax({
		        url: '${pageContext.request.contextPath}/product/get_order_detail',
		        type: 'GET',
		        data: { pror_master_id: orderId },
		        success: function(response) {
		            var masterId = response.pror_master_id;
		            var formattedId = String(masterId).padStart(6, '0'); 
		
		            // 주문 정보 채우기
		            $('.order-id').text(formattedId);
		            $('.order-date').text(response.pror_date);
		            $('.payment-method').text(getPaymentMethodText(response.pror_pay_method));
		            $('.order-status').text(getOrderStatusText(response.pror_status));
		            $('.email').text(response.pror_email || '');
		
		            // 상품 목록 채우기
		            const productList = $('.product-list');
		            productList.empty();
		            if (response.items && response.items.length > 0) {
		                response.items.forEach(function(item) {
		                    const row = $('<tr>');
		                    row.append($('<td>').text(item.pr_name ? item.pr_name : '상품명 없음'));
		                    row.append($('<td>').text(item.pr_opt_name ? item.pr_opt_name : '옵션 없음'));
		                    row.append($('<td>').text((item.pror_item_qtt ? item.pror_item_qtt : 0) + '개'));
		                    row.append($('<td>').text('₩' + (item.pror_item_amt ? item.pror_item_amt : 0).toLocaleString()));
		                    productList.append(row);
		                });
		            } else {
		                productList.append($('<tr>').append($('<td colspan="4">').text('주문 상품이 없습니다.')));
		            }
		
		            // 배송 정보 채우기
		            $('.recipient').text(response.pror_recipient || '');
		            $('.phone').text(response.pror_phone || '');
		
		            // 주소 정보 처리
		            let address = '';
		            if (response.pror_zipcode) {
		                address = '(' + response.pror_zipcode + ') ';
		            }
		            if (response.pror_addr) {
		                address += response.pror_addr;
		            }
		            if (response.pror_addr_detail) {
		                address += ' ' + response.pror_addr_detail;
		            }
		            $('.address').text(address);
		            
		            $('.delivery-status').text(getDeliveryStatusText(response.pror_deli_stat));
		
		            // 금액 정보 채우기
		            const product_amt = parseInt(response.pror_product_amt) || 0;
		            const shipping_cost = parseInt(response.pror_ship_cost) || 0;
		            const total_amt = parseInt(response.pror_total_amt) || 0;
		
		            $('.product-amount').text('₩' + product_amt.toLocaleString());
		            $('.shipping-cost').text('₩' + shipping_cost.toLocaleString());
		            $('.total-amount').text('₩' + total_amt.toLocaleString());
		
		            // 취소 버튼 표시 여부 설정
		            const canCancel = response.pror_status === 'pending' || 
		                            (response.pror_status === 'paid' && 
		                             response.pror_deli_stat === 'preparation');
		            $('.cancel-order-btn').toggle(canCancel).data('order-id', orderId);
		
		            // 모달 표시
		            new bootstrap.Modal(document.getElementById('orderDetailModal')).show();
		        },
		        error: function(xhr, status, error) {
		            if (xhr.status === 401) {
		                if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
		                    window.location.href = '${pageContext.request.contextPath}/auth/login';
		                }
		            } else {
		                alert('주문 정보를 불러오는데 실패했습니다.');
		            }
		        }
		    });
		}
	
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
	
		function removeFromWishlist(prwl_no) {
		    if (confirm('선택한 상품을 위시리스트에서 삭제하시겠습니까?')) {
		        $.ajax({
		            url: '/product/remove_from_wishlist',
		            type: 'POST',
		            contentType: 'application/json', // content type 설정 추가
		            data: JSON.stringify({ prwl_nos: [prwl_no] }), // 배열로 감싸서 전송
		            success: function(response) {
		                if (response === 'success') {
		                    alert('삭제되었습니다.');
		                    location.reload();
		                } else {
		                    alert('삭제에 실패했습니다.');
		                }
		            },
		            error: function(xhr) {
		                if (xhr.status === 401) {
		                    if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
		                        window.location.href = '${pageContext.request.contextPath}/auth/login';
		                    }
		                } else {
		                    alert('삭제 중 오류가 발생했습니다.');
		                }
		            }
		        });
		    }
		}
	</script>    
</head>
<body>
    <jsp:include page="${pageContext.request.contextPath}/header.jsp"/>
	<%@ include file="./cartOrderWishCommon.jsp" %>  
    <main>
		<ul class="nav-tabs">
		    <li class="nav-item">
		        <a class="nav-link ${activeTab eq 'orders' || empty activeTab ? 'active' : ''}" href="/product/pr_order_list?tab=orders">주문내역</a>
		    </li>
		    <li class="nav-item">
		        <a class="nav-link ${activeTab eq 'wishlist' ? 'active' : ''}" href="/product/pr_order_list?tab=wishlist">위시리스트</a>
		    </li>
		</ul>
        <div class="tab-content ${activeTab eq 'orders' || empty activeTab ? 'active' : ''}" id="orders">
            <c:if test="${activeTab eq 'orders' || empty activeTab}">
                <div class="period-filters">
                    <button class="period-btn" data-period="1w">1주일</button>
                    <button class="period-btn" data-period="1m">1개월</button>
                    <button class="period-btn" data-period="3m">3개월</button>
                    <button class="period-btn" data-period="6m">6개월</button>
                    <button class="period-btn" data-period="1y">1년</button>
                </div>
                <div class="notice">
                    <ul>
                        <li>최근 1년간의 주문 내역을 조회하실 수 있습니다.</li>
                        <li>상세보기 클릭 시 주문 상세 내역을 확인하실 수 있습니다.</li>
                        <li>주문취소는 배송준비 일때만 가능합니다.</li>
                    </ul>
                </div>
				<table class="order-table desktop-table">
				    <thead>
				        <tr>
				            <th>결제번호</th>
				            <th>상품명</th>
				            <th>결제수단</th>
				            <th>결제금액</th>
				            <th>주문일자</th>
				            <th>결제상태</th>
				            <th>배송상태</th>
				            <th>비고</th>
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach var="order" items="${orderList}">
				            <tr>
				                <td><fmt:formatNumber value="${order.pror_master_id}" pattern="000000"/></td>
				                <td>${order.pr_name}</td>
				                <td>
				                    <c:choose>
				                        <c:when test="${order.pror_pay_method eq 'card' || order.pror_pay_method eq '신용카드'}">신용카드</c:when>
				                    </c:choose>
				                </td>
				                <td>₩<fmt:formatNumber value="${order.pror_total_amt}" pattern="#,###"/></td>
				                <td>${order.pror_date}</td>
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
				                    <span class="delivery-badge delivery-${order.pror_deli_stat}">
				                        <c:choose>
				                            <c:when test="${order.pror_deli_stat eq 'preparation'}">배송준비</c:when>
				                            <c:when test="${order.pror_deli_stat eq 'in_transit'}">배송중</c:when>
				                            <c:when test="${order.pror_deli_stat eq 'delivered'}">배송완료</c:when>
				                        </c:choose>
				                    </span>
				                </td>
				                <td>
				                    <a href="#" class="detail-btn" data-order-id="${order.pror_master_id}">상세보기</a>
				                </td>
				            </tr>
				        </c:forEach>
				    </tbody>
				</table>
				<table class="order-table mobile-table">
				    <thead>
				        <tr>
				            <th>주문정보</th>
				            <th>결제금액</th>
				            <th>상태</th>
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach var="order" items="${orderList}">
				            <tr>
				                <td class="order-info-cell">
				                    <div class="product-name">${order.pr_name}</div>
				                    <div class="order-date">${order.pror_date}</div>
				                </td>
				                <td class="payment-cell">
				                    ₩<fmt:formatNumber value="${order.pror_total_amt}" pattern="#,###"/>
				                </td>
				                <td class="status-cell">
				                    <div class="status-wrapper">
				                        <span class="status-badge status-${order.pror_status}">
				                            <c:choose>
				                                <c:when test="${order.pror_status eq 'paid'}">결제완료</c:when>
				                                <c:when test="${order.pror_status eq 'pending'}">결제대기</c:when>
				                                <c:when test="${order.pror_status eq 'cancelled'}">취소됨</c:when>
				                            </c:choose>
				                        </span>
				                        <span class="delivery-badge delivery-${order.pror_deli_stat}">
				                            <c:choose>
				                                <c:when test="${order.pror_deli_stat eq 'preparation'}">배송준비</c:when>
				                                <c:when test="${order.pror_deli_stat eq 'in_transit'}">배송중</c:when>
				                                <c:when test="${order.pror_deli_stat eq 'delivered'}">배송완료</c:when>
				                            </c:choose>
				                        </span>
				                        <a href="#" class="detail-btn" data-order-id="${order.pror_master_id}">상세보기</a>
				                    </div>
				                </td>
				            </tr>
				        </c:forEach>
				    </tbody>
				</table>
                <div class="detail-pagination">
                    <c:if test="${paging.btnCur > 1}">
                        <div class="detail-page-item">
                            <a class="detail-page-link" href="/product/pr_order_list?page=1&period=${period}&startDate=${startDate}&endDate=${endDate}&tab=${activeTab}">＜＜</a>
                        </div>
                        <div class="detail-page-item">
                            <a class="detail-page-link" href="/product/pr_order_list?page=${paging.btnCur-1}&period=${period}&startDate=${startDate}&endDate=${endDate}&tab=${activeTab}">＜</a>
                        </div>
                    </c:if>
                    <c:forEach var="i" begin="${paging.btnFirst}" end="${paging.btnLast}" step="1">
                        <c:choose>
                            <c:when test="${paging.btnCur == i}">
                                <div class="detail-page-item active">
                                    <a class="detail-page-link">${i}</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="detail-page-item">
                                    <a class="detail-page-link" href="/product/pr_order_list?page=${i}&period=${period}&startDate=${startDate}&endDate=${endDate}&tab=${activeTab}">${i}</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${paging.btnCur < paging.btnTotalCount}">
                        <div class="detail-page-item">
                            <a class="detail-page-link" href="/product/pr_order_list?page=${paging.btnCur+1}&period=${period}&startDate=${startDate}&endDate=${endDate}&tab=${activeTab}">＞</a>
                        </div>
                        <div class="detail-page-item">
                            <a class="detail-page-link" href="/product/pr_order_list?page=${paging.btnTotalCount}&period=${period}&startDate=${startDate}&endDate=${endDate}&tab=${activeTab}">＞＞</a>
                        </div>
                    </c:if>
                </div>
            </c:if>
        </div>
        <div class="tab-content ${activeTab eq 'wishlist' ? 'active' : ''}" id="wishlist">
            <c:if test="${activeTab eq 'wishlist'}">
                <div class="wishlist-container">
                    <table class="wishlist-table desktop-table">
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="selectAllWishlist"></th>
                                <th>이미지</th>
                                <th>상품정보</th>
                                <th>판매가</th>
                                <th>선택</th>
                            </tr>
                        </thead>
						<tbody>
						    <c:forEach var="item" items="${wishlist}">
						        <tr data-wishlist-id="${item.prwl_no}">
						            <td>
						                <input type="checkbox" class="wishlist-checkbox" value="${item.prwl_no}">
						            </td>
						            <td>
						                <a href="/product/pr_detail?pr_id=${item.pr_id}" class="product-link">
						                    <c:if test="${item.imageExists}">
						                        <img src="${pageContext.request.contextPath}/product/getImage/${item.pr_thumbnail}" alt="${item.pr_name}" class="wishlist-img">
						                    </c:if>
						                    <c:if test="${!item.imageExists}">
						                        <div class="no-image">이미지 없음</div>
						                    </c:if>
						                </a>
						            </td>
						            <td class="product-info">
						                <a href="/product/pr_detail?pr_id=${item.pr_id}" class="product-link">
						                    ${item.pr_name}
						                </a>
						            </td>
						            <td>₩<fmt:formatNumber value="${item.pr_opt_price}" pattern="#,###"/></td>
						            <td>
						                <div class="wishlist-btn-group">
										<button type="button" class="btn-remove" onclick="removeFromWishlist(${item.prwl_no})">삭제</button>
						                </div>
						            </td>
						        </tr>
						    </c:forEach>
						    <c:if test="${empty wishlist}">
						        <tr>
						            <td colspan="5" class="no-items">위시리스트가 비어있습니다.</td>
						        </tr>
						    </c:if>
						</tbody>
                    </table>
					<table class="wishlist-table mobile-table">
					    <thead>
					        <tr>
					            <th><input type="checkbox" id="selectAllWishlistMobile"></th>
					            <th>상품정보</th>
					            <th>선택</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach var="item" items="${wishlist}">
					            <tr data-wishlist-id="${item.prwl_no}">
					                <td>
					                    <input type="checkbox" class="wishlist-checkbox" value="${item.prwl_no}">
					                </td>
					                <td class="product-info-cell">
					                    <div class="product-name">
					                        <a href="/product/pr_detail?pr_id=${item.pr_id}">${item.pr_name}</a>
					                    </div>
					                    <div class="product-price">₩<fmt:formatNumber value="${item.pr_opt_price}" pattern="#,###"/></div>
					                </td>
					                <td>
					                    <button type="button" class="btn-remove" onclick="removeFromWishlist(${item.prwl_no})">삭제</button>
					                </td>
					            </tr>
					        </c:forEach>
					        <c:if test="${empty wishlist}">
					            <tr>
					                <td colspan="3" class="no-items">위시리스트가 비어있습니다.</td>
					            </tr>
					        </c:if>
					    </tbody>
					</table>                    
                    <div class="wishlist-controls">
                        <button type="button" class="btn-remove-selected">선택 삭제</button>
                    </div>
                </div>
            </c:if>
        </div>
		<div class="modal fade" id="orderDetailModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		    <div class="modal-dialog modal-lg modal-dialog-centered">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title">주문 상세 정보</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <div class="order-info-section mb-4">
		                    <h6 class="section-title">주문 정보</h6>
		                    <div class="row">
		                        <div class="col-6">
		                            <label>주문번호</label>
		                            <p class="order-id"></p>
		                        </div>
		                        <div class="col-6">
		                            <label>주문일자</label>
		                            <p class="order-date"></p>
		                        </div>
		                        <div class="col-6">
		                            <label>결제방법</label>
		                            <p class="payment-method"></p>
		                        </div>
		                        <div class="col-6">
		                            <label>주문상태</label>
		                            <p class="order-status"></p>
		                        </div>
		                    </div>
		                </div>
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
						<div class="delivery-info-section mb-4">
						    <h6 class="section-title">배송 정보</h6>
						    <div class="row">
						        <div class="col-6">
						            <label>받는사람</label>
						            <p class="recipient"></p>
						        </div>
						        <div class="col-6">
						            <label>연락처</label>
						            <p class="phone"></p>
						        </div>
						        <div class="col-6">
						            <label>배송상태</label>
						            <p class="delivery-status"></p>
						        </div>
						        <div class="col-6">
						            <label>이메일</label>
						            <p class="email"></p>
						        </div>
						        <div class="col-12">
						            <label>배송지</label>
						            <p class="address"></p>
						        </div>
						    </div>
						</div>
		                <div class="price-info-section">
		                    <h6 class="section-title">결제 정보</h6>
		                    <div class="row">
		                        <div class="col-6">
		                            <label>상품금액</label>
		                            <p class="product-amount"></p>
		                        </div>
		                        <div class="col-6">
		                            <label>배송비</label>
		                            <p class="shipping-cost"></p>
		                        </div>
		                        <div class="col-6">
		                            <label>총 결제금액</label>
		                            <p class="total-amount"></p>
		                        </div>
		                    </div>
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		                <button type="button" class="btn btn-danger cancel-order-btn">주문취소</button>
		            </div>
		        </div>
		    </div>
		</div>
    </main>
    <jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>