<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<jsp:include page="${pageContext.request.contextPath}/head.jsp"/>
    <style>
        * {
            box-sizing: border-box;
        }   

        body {
            margin: 0;
            padding: 0;
        }

		a {
		    text-decoration: none;
		}
		
        .quantity-input::-webkit-outer-spin-button,
        .quantity-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        main {
            max-width: 1000px;
            margin: 0 auto;
        }

        .cart-title {
            text-align: center;
            font-size: 40px;
            margin: 40px 0;
        }

	    .cart-table {
	        width: 100%;
	        border-collapse: collapse;
	        margin-bottom: 20px;
	        table-layout: fixed;
	    }
        
        .cart-table a {
		    text-decoration: none;
		    color: inherit;
		}

        .cart-table th {
            padding: 12px;
            background: white;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            font-weight: normal;
            font-size: 13px;
        }

        .cart-table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
            vertical-align: middle;
        }
        
	    .cart-table th,
	    .cart-table td {
	        padding: 12px;
	        border-bottom: 1px solid #ddd;
	        text-align: center;
	        vertical-align: middle;
	        word-break: break-all; 
	        height: auto;
	    }
	    
	    * 각 열의 너비 고정 */
	    .cart-table th:nth-child(1),
	    .cart-table td:nth-child(1) {
	        width: 5%;
	    }
	    
	    .cart-table th:nth-child(2),
	    .cart-table td:nth-child(2) { 
	        width: 15%;
	    }
	    
	    .cart-table th:nth-child(3),
	    .cart-table td:nth-child(3) { 
	        width: 25%;
	    }
	    
	    .cart-table th:nth-child(4),
	    .cart-table td:nth-child(4) { 
	        width: 10%;
	    }
	    
	    .cart-table th:nth-child(5),
	    .cart-table td:nth-child(5) { 
	        width: 10%;
	    }
	    
	    .cart-table th:nth-child(6),
	    .cart-table td:nth-child(6) { 
	        width: 10%;
	    }
	    
	    .cart-table th:nth-child(7),
	    .cart-table td:nth-child(7) {
	        width: 10%;
	    }
	    
	    .cart-table th:nth-child(8),
	    .cart-table td:nth-child(8) { 
	        width: 15%;
	    }
	
	    .product-info {
	        text-align: left;
	        font-size: 14px;
	        white-space: normal; 
	    }
	
	    .cart-table td:nth-child(4),
	    .cart-table td:nth-child(6),
	    .cart-table td:nth-child(7) {
	        min-width: 80px;
	        word-wrap: break-word; 
	        white-space: normal; 
	    }

		.product-img {
		    width: 100px;
		    height: auto;
		    transition: opacity 0.2s;
		}
		
        .product-info {
            text-align: left;
            font-size: 14px;
        }
        
        .product-info a {
		    text-decoration: none;
		    color: inherit;
		}
		
        .product-info span {
            display: block;
            color: #666;
            font-size: 14px;
            margin-top: 5px;
        }

        .quantity-wrap {
            display: inline-block;
            width: auto;
            text-align: center;
        }

        .quantity-input-group {
            display: inline-block;
            position: relative;
            width: 50px;
            height: 23px;
            border: 1px solid #ddd;
            margin-bottom: 3px;
        }

        .quantity-input {
            width: 100%;
            height: 100%;
            border: none;
            text-align: center;
            padding: 0 15px 0 5px;
            margin: 0;
        }

        .quantity-buttons {
            position: absolute;
            right: 0;
            top: 0;
            bottom: 0;
            width: 15px;
            display: flex;
            flex-direction: column;
            border-left: 1px solid #ddd;
        }

        .quantity-button {
            height: 50%;
            border: none;
            background: #f8f8f8;
            cursor: pointer;
            padding: 0;
            font-size: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quantity-button:first-child {
            border-bottom: 1px solid #ddd;
        }

        .quantity-btn {
            display: block;
            width: 50px;
            padding: 2px 0;
            border: 1px solid #ddd;
            background: white;
            font-size: 12px;
            cursor: pointer;
            margin: 0 auto;
        }

        .btn-list {
            display: flex;
            flex-direction: column;
            gap: 3px;
        }

        .btn {
            width: 100px;
            padding: 7px 0;
            font-size: 12px;
            cursor: pointer;
        }

        .btn-order {
            background: #fcd11e;
            color: black;
            border: none;
            opacity: 0.8;
        }

        .btn-normal {
            background: white;
            border: 1px solid #ddd;
        }
        
        .wish {
            background: #6c757d;
            color: white;
            border: 1px solid #ddd;
        }

        .cart-footer {
            margin-top: 20px;
        }

        .footer-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .delete-selected {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 13px;
        }

        .delete-btn {
            background: #f5f5f5;
            border: 1px solid #ddd;
            padding: 5px 10px;
            font-size: 12px;
            cursor: pointer;
        }

        .action-buttons button {
            background: white;
            border: 1px solid #ddd;
            padding: 5px 15px;
            font-size: 12px;
            cursor: pointer;
        }

	    .price-summary {
	        display: flex;
	        justify-content: space-between;
	        align-items: center;
	        padding: 30px 0;
	        text-align: center;
	        border-bottom: 1px solid #ddd;
	    }
	
	    .price-item {
	        flex: 1;
	        display: flex;
	        flex-direction: column;
	        align-items: center;
	        text-align: center;
	    }
	
	    .price-label {
	        font-size: 14px;
	        color: #666;
	        margin-bottom: 10px;
	        width: 100%;
	    }
	
	    .price-value {
	        font-size: 24px;
	        font-weight: bold;
	        text-align: center;
	        color: 5e5a14;
	        width: 100%;
	    }
	
	    .price-value span {
	        font-size: 16px;
	        font-weight: normal;
	        margin-left: 2px;
	    }
	
	    .price-separator {
	        font-size: 20px;
	        color: #666;
	        padding: 0 20px;
	        display: flex;
	        align-items: center;
	        margin-top: 20px;
	    }

        .purchase-buttons {
            text-align: center;
            margin: 30px 0;
        }

        .purchase-btn {
            padding: 15px 40px;
            font-size: 14px;
            cursor: pointer;
            margin: 0 2px;
        }

        .btn-buy-all {
            background: #fcd11e;
            color: black;
            border: none;
            opacity: 0.8;
        }

        .btn-buy-selected {
            background: white;
            border: 1px solid #ddd;
        }
        
        .modal.no-move {
		    pointer-events: none;
		}
		
		.modal.no-move .modal-dialog {
		    pointer-events: all;
		}
		
		.modal-backdrop {
		    pointer-events: none !important;
		}
		
		.modal-content {
		    position: relative !important;
		    margin: 0 auto !important;
		}
		
		.modal {
		    padding-right: 0 !important;
		}
		
		.modal {
		    pointer-events: none;
		}
		
		.modal .modal-dialog {
		    pointer-events: all;
		}
		
		.modal-backdrop {
		    pointer-events: none !important;
		}
		
		.mobile-cart-items {
		    display: none;
		}
		
		.cart-table {
		    display: table;
		}
		
		.mobile-cart-footer {
		    display: none;
		}
		
		.pc-cart-footer {
		    display: block;
		    margin-top: 20px;
		}
		
		.sales-sell {
			font-size: 16px;
		}
		
		.sales-sum {
			font-size: 16px;
		}
		
		.sales-deli {
			font-size: 16px;
		}
		
		@media screen and (max-width: 768px) {
		    .mobile-cart-items {
		        display: block;
		    }
		
		    .cart-table {
		        display: none;
		    }
		    
		    main {
		        padding: 0 10px;
		    }
		
		    .cart-title {
		        font-size: 24px;
		        margin: 20px 0;
		    }
		
		    .cart-item-card {
		        background: white;
		        border: 1px solid #dee2e6;
		        border-radius: 8px;
		        margin-bottom: 15px;
		        padding: 15px;
		    }
		
		    .cart-item-header {
		        display: flex;
		        align-items: center;
		        margin-bottom: 10px;
		    }
		
		    .cart-item-checkbox {
		        margin-right: 10px;
		    }
		
		    .cart-item-image {
		        width: 80px;
		        height: 80px;
		        object-fit: cover;
		        margin-right: 15px;
		    }
		
		    .cart-item-info {
		        flex: 1;
		    }
		
		    .cart-item-name {
		        font-size: 16px;
		        margin-bottom: 5px;
		    }
		    
		    .cart-item-name a {
			    text-decoration: none;
			    outline: none;
			    color: black;
			}
			
		    .cart-item-option {
		        font-size: 12px;
		        color: #666;
		    }
		
		    .cart-item-price {
		    	display: none;
		    }
		
		    .cart-item-quantity {
		        display: flex;
		        align-items: center;
		        margin: 10px 0;
		    }
		
		    .quantity-label {
		        font-size: 12px;
		        margin-right: 10px;
		    }
		
		    .mobile-quantity-input-group {
		        display: flex;
		        align-items: center;
		        border: 1px solid #dee2e6;
		        border-radius: 4px;
		        overflow: hidden;
		    }
		
		    .mobile-quantity-button {
		        width: 30px;
		        height: 30px;
		        border: none;
		        background: #f8f9fa;
		        font-size: 16px;
		    }
		
		    .mobile-quantity-input {
		        width: 40px;
		        height: 30px;
		        border: none;
		        text-align: center;
		        -webkit-appearance: none;
		        -moz-appearance: textfield;
		    }
		
		    .cart-item-subtotal {
		        font-size: 14px;
		        font-weight: bold;
		        text-align: right;
		        margin: 10px 0;
		    }
		
		    .cart-item-buttons {
		        display: flex;
		        gap: 8px;
		        margin-top: 15px;
		    }
		
		    .cart-item-button {
		        flex: 1;
		        padding: 8px;
		        font-size: 12px;
		        border: 1px solid #dee2e6;
		        border-radius: 4px;
		        background: white;
		    }
		
		    .cart-item-button.order {
		        background: #fcd11e;
		        color: black;
		        border: none;
		        opacity: 0.8;
		    }
		
		    .price-summary {
		        flex-direction: column;
		        padding: 20px 15px;
		        gap: 15px;
		    }
		
		    .price-separator {
		        transform: rotate(90deg);
		        margin: 10px 0;
		    }
		
		    .price-item {
		        width: 100%;
		    }
		
		    .price-label {
		        font-size: 12px;
		    }
		
		    .price-value {
		        font-size: 18px;
		    }
		
		    .purchase-buttons {
		        padding: 0 15px;
		        margin: 20px 0;
		    }
		
		    .purchase-btn {
		        width: 100%;
		        margin-bottom: 10px;
		        padding: 12px 0;
		    }
		
		    .pc-cart-footer {
		        display: none;
		    }
		
		    .mobile-cart-footer {
		        display: block;
		        padding: 0 15px;
		    }
		
		    .mobile-price-summary {
		        background: #f8f9fa;
		        padding: 15px;
		        border-radius: 8px;
		        margin-bottom: 15px;
		    }
		
		    .mobile-price-row {
		        display: flex;
		        justify-content: space-between;
		        align-items: center;
		        padding: 8px 0;
		        border-bottom: 1px solid #dee2e6;
		    }
		
		    .mobile-price-row span {
		        color: #495057;
		        font-size: 14px;
		    }
		
		    .mobile-price-row strong {
		        font-size: 14px;
		    }
		
		    .mobile-price-total {
		        display: flex;
		        justify-content: space-between;
		        align-items: center;
		        padding: 15px 0 5px 0;
		    }
		
		    .mobile-price-total span {
		        font-weight: bold;
		        color: #212529;
		        font-size: 16px;
		    }
		
		    .mobile-price-total strong {
		        font-size: 20px;
		    }
		
		    .mobile-cart-actions {
		        margin-top: 20px;
		    }
		
		    .mobile-action-row {
		        display: flex;
		        gap: 8px;
		        margin-bottom: 10px;
		    }
		
		    .mobile-action-row button {
		        flex: 1;
		        padding: 10px;
		        border: 1px solid #dee2e6;
		        background: white;
		        border-radius: 4px;
		        font-size: 13px;
		    }
		
		    .mobile-order-buttons {
		        display: flex;
		        flex-direction: column;
		        gap: 8px;
		    }
		
		    .mobile-order-btn {
		        width: 100%;
		        padding: 15px 0;
		        border: none;
		        border-radius: 4px;
		        font-size: 14px;
		        font-weight: bold;
		    }
		
		    .mobile-order-btn.order-all {
		        background: #fcd11e;
		        opacity: 0.8;
		        color: black;
		    }
		
		    .mobile-order-btn.order-selected {
		        background: #6c757d;
		        color: white;
		        border: 1px solid #dee2e6;
		    }
		    
		    .wishm {
		        background: #6c757d;
		        color: white;		    	
		    }
		}
    </style>
	<script>
		$(document).ready(function() {
		    const originalConsoleLog = console.log; // 기존 console.log를 저장
		    console.log = function (...args) {
		      if (args[0] && typeof args[0] === 'string' && args[0].includes('Request from Merchant')) {
		        return; // "Request from Merchant" 로그를 무시
		      }
		      originalConsoleLog.apply(console, args); // 나머지 로그는 정상 출력
		    };
			
		    var IMP = window.IMP;
		    IMP.init("imp21007778"); // 포트원 가맹점 식별코드

		    // 가격 포맷팅 함수
		    function formatPrice(price) {
		        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    }
		
		    let products = {};
		    let totalPrice = 0;
			// products 객체에 stock 정보 추가
		    <c:forEach var="item" items="${cartList}" varStatus="status">
		        products['quantity_${item.prsc_no}'] = {
		            price: ${item.pr_opt_price},
		            pr_id: ${item.pr_id},
		            pr_opt_name: '${item.pr_opt_name}',
		            quantity: ${item.prsc_quantity},
		            prsc_no: ${item.prsc_no},
		            stock: 0  // 초기값 설정
		        };
		        
		        // 각 상품의 재고 정보를 가져옴
		        $.get('${pageContext.request.contextPath}/product/get_stock', {
		            pr_id: ${item.pr_id},
		            pr_opt_name: '${item.pr_opt_name}'
		        }, function(stock) {
		            products['quantity_${item.prsc_no}'].stock = stock;
		            
		            // 재고보다 현재 수량이 많으면 재고량으로 조정
		            var $input = $('#quantity_${item.prsc_no}');
		            if (parseInt($input.val()) > stock) {
		                $input.val(stock);
		                updateProductTotal('quantity_${item.prsc_no}');
		                updateTotalPrice();
		                updateCartQuantity('quantity_${item.prsc_no}', stock);
		            }
		            
		            // max 속성 설정
		            $input.attr('max', stock);
		        });
		    </c:forEach>
		
		    // 상품별 총액 업데이트
		    function updateProductTotal(targetId) {
		        const $input = $('#' + targetId);
		        if (!$input.length) return;
		
		        const quantity = parseInt($input.val());
		        const key = targetId;
		        
		        if (products[key]) {
		            const basePrice = products[key].price;
		            const totalPrice = basePrice * quantity;
		            
		            const $row = $input.closest('tr');
		            $row.find('td:eq(3)').text('₩' + formatPrice(basePrice));
		            $row.find('td:nth-last-child(2)').text('₩' + formatPrice(totalPrice));
		
		            products[key].quantity = quantity;
		            
		            // 체크된 상품들의 총액만 업데이트
		            updateTotalPrice();
		        }
		    }
		
		    // 총 금액 계산 및 업데이트 함수 수정
			function updateTotalPrice() {
			    var totalProductPrice = 0;
			    var totalShipping = 0;
			    var checkedCount = $('.product-checkbox:checked').length;
			    var totalCount = $('.product-checkbox').length;
			
			    // 모바일과 PC 구분하여 체크된 상품의 가격 계산
			    if (checkedCount === 0 || checkedCount === totalCount) {
			        // PC 버전 - 전체 상품 계산
			        $('.cart-table tbody tr').each(function() {
			            var quantity = parseInt($(this).find('.quantity-input').val()) || 0;
			            var price = parseInt($(this).find('td:eq(3)').text().replace(/[^0-9]/g, '')) || 0;
			            var itemTotal = quantity * price;
			            
			            $(this).find('td:nth-last-child(2)').text('₩' + itemTotal.toLocaleString());
			            totalProductPrice += itemTotal;
			        });
			
			        // 모바일 버전 - 전체 상품 계산
			        $('.cart-item-card').each(function() {
			            var quantity = parseInt($(this).find('.mobile-quantity-input').val()) || 0;
			            var price = parseInt($(this).find('.cart-item-price').text().replace(/[^0-9]/g, '')) || 0;
			            var itemTotal = quantity * price;
			            
			            $(this).find('.cart-item-subtotal').text('합계: ₩' + itemTotal.toLocaleString());
			            // 모바일에서는 이미 PC에서 계산된 값을 사용하므로 totalProductPrice에 더하지 않음
			        });
			    } else {
			        // PC 버전 - 체크된 상품만 계산
			        $('.cart-table tbody tr').each(function() {
			            var isChecked = $(this).find('.product-checkbox').prop('checked');
			            var quantity = parseInt($(this).find('.quantity-input').val()) || 0;
			            var price = parseInt($(this).find('td:eq(3)').text().replace(/[^0-9]/g, '')) || 0;
			            var itemTotal = quantity * price;
			            
			            $(this).find('td:nth-last-child(2)').text('₩' + itemTotal.toLocaleString());
			            
			            if (isChecked) {
			                totalProductPrice += itemTotal;
			            }
			        });

			        // 모바일 버전 - 체크된 상품만 계산
			        $('.cart-item-card').each(function() {
			            var isChecked = $(this).find('.product-checkbox').prop('checked');
			            var quantity = parseInt($(this).find('.mobile-quantity-input').val()) || 0;
			            var price = parseInt($(this).find('.cart-item-price').text().replace(/[^0-9]/g, '')) || 0;
			            var itemTotal = quantity * price;
			            
			            $(this).find('.cart-item-subtotal').text('합계: ₩' + itemTotal.toLocaleString());
			            
			            // 체크된 상품의 금액을 총액에 더함
			            if (isChecked && !$(this).closest('tr').length) { // PC 버전에서 계산되지 않은 경우에만
			                totalProductPrice += itemTotal;
			            }
			        });
			    }
			
			    // 배송비 계산
			    totalShipping = totalProductPrice > 0 ? 3000 : 0;
			
			    // PC 버전 총액 업데이트
			    var finalTotal = totalProductPrice + totalShipping;
			    $('.price-summary .price-value').eq(0).html(totalProductPrice.toLocaleString() + '<span>원</span>');
			    $('.price-summary .price-value').eq(1).html(totalShipping.toLocaleString() + '<span>원</span>');
			    $('.price-summary .price-value').eq(2).html(finalTotal.toLocaleString() + '<span>원</span>');
			
			    // 모바일 버전 총액 업데이트
			    $('.mobile-price-row').eq(0).find('strong').text(totalProductPrice.toLocaleString() + '원');
			    $('.mobile-price-row').eq(1).find('strong').text(totalShipping.toLocaleString() + '원');
			    $('.mobile-price-total strong').text(finalTotal.toLocaleString() + '원');
			
			    // 전체 선택 체크박스 상태 업데이트
			    $('#selectAll').prop('checked', checkedCount === totalCount && totalCount > 0);
			}
		
		    // 장바구니 수량 DB 업데이트
			function updateCartQuantity(targetId, quantity) {
			    const product = products[targetId];
			    if (!product) return;
			
			    $.ajax({
			        url: '${pageContext.request.contextPath}/product/update_cart_quantity',
			        type: 'POST',
			        contentType: 'application/json',
			        data: JSON.stringify({
			            prsc_no: product.prsc_no,
			            prsc_quantity: quantity,
			            pr_opt_price: product.price,
			            prsc_price: product.price * quantity
			        }),
			        success: function(response) {
			            if (response !== "success") {
			                alert('수량 업데이트에 실패했습니다.');
			                location.reload();
			            }
			        },
			        error: function() {
			            alert('수량 업데이트 중 오류가 발생했습니다.');
			            location.reload();
			        }
			    });
			}
		
		    // 상품 삭제
		    window.removeFromCart = function(prId, prOptName) {
		        if (!confirm('선택하신 상품을 장바구니에서 삭제하시겠습니까?')) {
		            return;
		        }
		
		        $.ajax({
		            url: '${pageContext.request.contextPath}/product/remove_from_cart',
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify({
		                pr_id: prId,
		                pr_opt_name: prOptName
		            }),
		            success: function(response) {
		                if (response === 'success') {
		                    location.reload();
		                } else {
		                    alert('삭제에 실패했습니다.');
		                }
		            },
		            error: function() {
		                alert('삭제 중 오류가 발생했습니다.');
		            }
		        });
		    };
		
		    // 개별 체크박스
		    $('.product-checkbox').on('change', function() {
		        const allChecked = $('.product-checkbox:not(:checked)').length === 0;
		        $('#selectAll').prop('checked', allChecked);
		    });
		
		    // 선택 상품 삭제
			$('.delete-btn').on('click', function() {
			    const selectedItems = $('.product-checkbox:checked').map(function() {
			        let $container;
			        
			        if ($(this).closest('tr').length) {
			            $container = $(this).closest('tr');
			        } else if ($(this).closest('.cart-item-card').length) {
			            $container = $(this).closest('.cart-item-card');
			        } else {
			            console.error('Row or container not found for checkbox:', $(this));
			            return null;
			        }
			
			        const $input = $container.find('.quantity-input, .mobile-quantity-input');
			        if (!$input.length) {
			            console.error('Quantity input not found for container:', $container);
			            return null;
			        }
			
			        const inputId = $input.attr('id');
			        if (!products[inputId]) {
			            console.error('Product not found for inputId:', inputId);
			            return null; // 데이터가 없는 경우 건너뜀
			        }
			
			        return {
			            pr_id: products[inputId].pr_id,
			            pr_opt_name: products[inputId].pr_opt_name
			        };
			    }).get().filter(item => item !== null);
			
			    if (selectedItems.length === 0) {
			        alert('삭제할 상품을 선택해주세요.');
			        return;
			    }
			
			    if (confirm('선택한 상품을 삭제하시겠습니까?')) {
			        Promise.all(selectedItems.map(item =>
			            $.ajax({
			                url: '${pageContext.request.contextPath}/product/remove_from_cart',
			                type: 'POST',
			                contentType: 'application/json',
			                data: JSON.stringify(item)
			            })
			        )).then(() => {
			            location.reload();
			        }).catch(() => {
			            alert('삭제 중 오류가 발생했습니다.');
			        });
			    }
			});
		    
		    // 전체 선택 체크박스
		    $('#selectAll').on('change', function() {
		        const isChecked = $(this).prop('checked');
		        $('.product-checkbox').prop('checked', isChecked);
		    });
		    
		 	// PC 버전 - 수량 증가 버튼
		    $(document).on('click', '.quantity-button.plus', function() {
		        var input = $(this).closest('.quantity-input-group').find('.quantity-input');
		        var targetId = input.attr('id');
		        var currentValue = parseInt(input.val());
		        var mobileInput = $('#mobile_' + targetId);
		        
		        if (!products[targetId]) {
		            console.error('Product not found:', targetId);
		            return;
		        }
		        
		        var maxStock = products[targetId].stock;
		        
		        if (currentValue < maxStock) {
		            currentValue += 1;
		            input.val(currentValue);
		            mobileInput.val(currentValue);
		            updateProductTotal(targetId);
		            updateTotalPrice();
		            updateCartQuantity(targetId, currentValue);
		        } else {
		            alert('재고가 부족합니다.');
		        }
		    });

		 	// PC 버전 - 수량 감소 버튼
		    $(document).on('click', '.quantity-button.minus', function() {
		        var input = $(this).closest('.quantity-input-group').find('.quantity-input');
		        var targetId = input.attr('id');
		        var currentValue = parseInt(input.val());
		        var mobileInput = $('#mobile_' + targetId);
		        
		        if (currentValue > 1) {
		            currentValue -= 1;
		            input.val(currentValue);
		            mobileInput.val(currentValue);
		            updateProductTotal(targetId);
		            updateTotalPrice();
		            updateCartQuantity(targetId, currentValue);
		        }
		    });
		 	
		 	// PC 버전 - 수량 직접 입력 처리
		    $(document).on('change', '.quantity-input:not(.mobile-quantity-input)', function() {
		        var targetId = $(this).attr('id');
		        
		        if (!products[targetId]) {
		            console.error('Product not found:', targetId);
		            return;
		        }
		        
		        var value = parseInt($(this).val());
		        var maxStock = products[targetId].stock;
		        
		        if (isNaN(value) || value < 1) {
		            value = 1;
		        } else if (value > maxStock) {
		            value = maxStock;
		            alert('재고가 부족합니다.');
		        }
		        
		        $(this).val(value);
		        $('#mobile_' + targetId).val(value);
		        
		        updateProductTotal(targetId);
		        updateTotalPrice();
		        updateCartQuantity(targetId, value);
		    });
		 	
			// 숫자만 입력되도록 처리
			$('.quantity-input').on('input', function() {
			    var value = $(this).val().replace(/[^0-9]/g, '');
			    $(this).val(value);
			});
		    
		    // 체크박스 이벤트 통합 처리 함수 수정
		    function initializeCheckboxes() {
		        // 전체 선택 체크박스 (PC & 모바일)
		        $('#selectAll').on('change', function() {
		            var isChecked = $(this).prop('checked');
		            $('.product-checkbox').prop('checked', isChecked);
		            updateTotalPrice(); // 전체 선택/해제 시 금액 업데이트
		        });

		        // 개별 체크박스 (PC & 모바일)
		        $('.product-checkbox').on('change', function() {
		            var allChecked = $('.product-checkbox:not(:checked)').length === 0;
		            $('#selectAll').prop('checked', allChecked);
		            updateTotalPrice(); // 개별 체크박스 변경 시 금액 업데이트
		        });
		    }
		 	
		    // 선택 주문하기 버튼 클릭 이벤트
		    $('.btn-buy-selected').on('click', function() {
		        const selectedItems = $('.product-checkbox:checked').map(function() {
		            const $row = $(this).closest('tr');
		            return {
		                pr_id: $(this).val(),
		                pr_name: $row.find('.product-info a').first().text().trim(),
		                pr_opt_name: $row.find('.product-info span').text().replace('[옵션: ', '').replace(']', ''),
		                pr_opt_price: parseInt($row.find('td:eq(3)').text().replace(/[^0-9]/g, '')),
		                pror_qtt: parseInt($row.find('.quantity-input').val()),
		                pror_product_amt: parseInt($row.find('td:nth-last-child(2)').text().replace(/[^0-9]/g, '')),
		                pror_ship_cost: 3000
		            };
		        }).get();

		        if (selectedItems.length === 0) {
		            alert('주문할 상품을 선택해주세요.');
		            return;
		        }

		        processOrder(selectedItems);
		    });
		    
		    // 전체 주문하기 버튼 클릭 이벤트
		    $('.btn-buy-all').on('click', function() {
		        const allItems = $('tr').slice(1).map(function() {
		            const $row = $(this);
		            if($row.find('.product-checkbox').length === 0) return null;
		            
		            return {
		                pr_id: $row.find('.product-checkbox').val(),
		                pr_name: $row.find('.product-info a').first().text().trim(),
		                pr_opt_name: $row.find('.product-info span').text().replace('[옵션: ', '').replace(']', ''),
		                pr_opt_price: parseInt($row.find('td:eq(3)').text().replace(/[^0-9]/g, '')),
		                pror_qtt: parseInt($row.find('.quantity-input').val()),
		                pror_product_amt: parseInt($row.find('td:nth-last-child(2)').text().replace(/[^0-9]/g, '')),
		                pror_ship_cost: 3000
		            };
		        }).get().filter(item => item !== null);

		        if (allItems.length === 0) {
		            alert('장바구니가 비어있습니다.');
		            return;
		        }

		        processOrder(allItems);
		    });
		    
		    function processOrder(items) {
		        var shippingModal = new bootstrap.Modal(document.getElementById('shippingModal'));
		        shippingModal.show();

		        $('#shippingForm').off('submit').on('submit', function(e) {
		            e.preventDefault();
		            
		            // 모바일 체크 함수
		            function isMobileDevice() {
		                var mobileKeywords = [
		                    'Mobile', 'iPhone', 'iPad', 'Android', 'BlackBerry', 
		                    'Opera Mini', 'Windows Phone'
		                ];
		                var userAgent = navigator.userAgent;
		                
		                if (mobileKeywords.some(function(keyword) { return userAgent.includes(keyword); })) {
		                    return true;
		                }
		                
		                if (/Chrome/.test(userAgent) && window.innerWidth <= 768) {
		                    return true;
		                }
		                
		                return false;
		            }
		            
		            var isMobile = isMobileDevice();
		            var productTotalAmount = items.reduce(function(sum, item) {
		                return sum + (item.pr_opt_price * item.pror_qtt);
		            }, 0);
		            var shippingCost = 3000;
		            
		            // 테스트용 결제 금액
		            // var payAmount = isMobile ? 100 : 1;
		            
		            // 실제 결제 금액
		            var payAmount = productTotalAmount + shippingCost;
		            
		            var shippingData = {
		                pror_recipient: $('#recipient').val(),
		                pror_phone: $('#phone').val(),
		                pror_addr: $('#addr').val(),
		                pror_addr_detail: $('#addr_detail').val(),
		                pror_zipcode: $('#zipcode').val(),
		                pror_pay_method: 'card',
		                pror_ship_cost: shippingCost,
		                pror_total_amt: payAmount
		            };

		            var today = new Date();
		            var merchantUid = 'PR_' + today.getTime();
		            
		            var firstItemName = items[0].pr_name.replace(/[\n\t\r\s]+/g, ' ').trim();
		            var productName = items.length > 1 ? 
		                firstItemName + " 외 " + (items.length - 1) + "건" :
		                firstItemName;
		                
		            var modal = bootstrap.Modal.getInstance(document.getElementById('shippingModal'));

		            if (isMobile) {
		                var currentDomain = window.location.origin;
		                
		                // 선택된 상품 정보를 객체 배열로 생성
		                var orderItems = items.map(function(item) {
		                	console.log(item.pr_opt_name);
		                    var orderItem = {
		                        pr_id: item.pr_id,
		                        pr_name: item.pr_name, 
		                        pr_opt_name: item.pr_opt_name,
		                        pr_opt_price: item.pr_opt_price,
		                        pror_qtt: item.pror_qtt,
		                        pror_product_amt: item.pror_product_amt
		                    };
		                    return orderItem;
		                });

		                // 폼 생성과 히든 필드 추가
		                var form = $('<form>')
		                    .attr('method', 'post')
		                    .attr('action', currentDomain + '/product/mobile_process_payment')
		                    .appendTo('body');

		                // 선택된 상품들 정보를 JSON 문자열로 변환하여 히든 필드로 추가
		                orderItems.forEach(function(item, index) {
		                    var itemJson = JSON.stringify(item);
		                    $('<input>').attr({
		                        type: 'hidden',
		                        name: 'orderItems',
		                        value: itemJson
		                    }).appendTo(form);
		                });

		                // 배송 정보 히든 필드 추가
		                Object.entries(shippingData).forEach(function([key, value]) {
		                    $('<input>').attr({
		                        type: 'hidden',
		                        name: key,
		                        value: value
		                    }).appendTo(form);
		                });

		                var mobilePaymentData = {
		                    pg: 'html5_inicis',
		                    pay_method: 'card',
		                    merchant_uid: merchantUid,
		                    name: productName,
		                    amount: payAmount,
		                    buyer_email: '${user.us_email}',
		                    buyer_name: shippingData.pror_recipient,
		                    buyer_tel: shippingData.pror_phone,
		                    buyer_addr: shippingData.pror_addr + ' ' + shippingData.pror_addr_detail,
		                    buyer_postcode: shippingData.pror_zipcode,
		                    m_redirect_url: currentDomain + '/product/mobile_process_payment?' + 
		                       'selectedItems=' + encodeURIComponent(items.map(item => item.pr_id + '|' + item.pr_opt_name).join(','))
		                };

		                modal.hide();
		                IMP.request_pay(mobilePaymentData);
		                return false;
		            } else {
		                var pcPaymentData = {
		                    pg: 'html5_inicis',
		                    pay_method: 'card',
		                    merchant_uid: merchantUid,
		                    name: productName,
		                    amount: payAmount,
		                    buyer_email: '${user.us_email}',
		                    buyer_name: shippingData.pror_recipient,
		                    buyer_tel: shippingData.pror_phone,
		                    buyer_addr: shippingData.pror_addr + ' ' + shippingData.pror_addr_detail,
		                    buyer_postcode: shippingData.pror_zipcode
		                };

		                IMP.request_pay(pcPaymentData, function(rsp) {
		                    if (rsp.success) {
		                        modal.hide();
		                        var finalOrderData = items.map(function(item) {
		                            return {
		                                pr_id: item.pr_id,
		                                pr_name: item.pr_name,
		                                pr_opt_name: item.pr_opt_name,
		                                pr_opt_price: item.pr_opt_price,
		                                pror_item_qtt: item.pror_qtt,
		                                pror_item_amt: item.pror_product_amt,
		                                merchant_uid: rsp.merchant_uid,
		                                imp_uid: rsp.imp_uid,
		                                pror_recipient: shippingData.pror_recipient,
		                                pror_phone: shippingData.pror_phone,
		                                pror_addr: shippingData.pror_addr,
		                                pror_addr_detail: shippingData.pror_addr_detail,
		                                pror_zipcode: shippingData.pror_zipcode,
		                                pror_pay_method: 'card',
		                                pror_total_amt: rsp.paid_amount
		                            };
		                        });

		                        $.ajax({
		                            url: '${pageContext.request.contextPath}/product/process_payment',
		                            type: 'POST',
		                            contentType: 'application/json',
		                            data: JSON.stringify(finalOrderData)
		                        })
		                        .done(function(response) {
		                            if (response.success) {
		                                alert('주문이 완료되었습니다.');
		                                window.location.href = '${pageContext.request.contextPath}/product/pr_order_list';
		                            } else {
		                                alert(response.message || '주문 처리 중 오류가 발생했습니다.');
		                            }
		                        })
		                        .fail(function(xhr) {
		                            alert('주문 처리 중 오류가 발생했습니다.');
		                            console.error('Error:', xhr.responseText);
		                        });
		                    } else {
		                        alert('결제에 실패하였습니다.\n' + rsp.error_msg);
		                    }
		                });
		            }
		        });
		    }
		 	
		    // 주소 검색 버튼 클릭 이벤트
		    $('#searchAddrBtn').on('click', function() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                $('#zipcode').val(data.zonecode);
		                $('#addr').val(data.address);
		                $('#addr_detail').focus();
		            }
		        }).open();
		    });
		    
			 // 개별 상품 주문하기 버튼 클릭 이벤트
		    $('.btn-order').on('click', function() {
		        const $row = $(this).closest('tr');
		        
		        // 해당 상품의 정보 수집
		        const orderItem = {
		            pr_id: $row.find('.product-checkbox').val(),
		            pr_name: $row.find('.product-info a').first().text().trim(),
		            pr_opt_name: $row.find('.product-info span').text().replace('[옵션: ', '').replace(']', ''),
		            pr_opt_price: parseInt($row.find('td:eq(3)').text().replace(/[^0-9]/g, '')),
		            pror_qtt: parseInt($row.find('.quantity-input').val()),
		            pror_product_amt: parseInt($row.find('td:nth-last-child(2)').text().replace(/[^0-9]/g, '')),
		            pror_ship_cost: 3000
		        };

		        // 주문 처리
		        processOrder([orderItem]);
		    });
		    
		    // PC 버전 위시리스트 버튼 클릭 이벤트
		    $('.btn-normal:contains("위시리스트")').off('click').on('click', function() {
		        if ('${user}' === '') {
		            if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
		                window.location.href = '${pageContext.request.contextPath}/auth/login';
		            }
		            return;
		        }
		        
		        const $row = $(this).closest('tr');
		        const $thumbnail = $row.find('.product-img');
		        const productId = $row.find('.product-checkbox').val();
		        const optionName = $row.find('.product-info span').text().replace('[옵션: ', '').replace(']', '');
		        
		        // 상품 데이터 준비
		        const productData = {
		            pr_id: productId,
		            pr_name: $row.find('.product-info a').first().contents().filter(function() {
		                return this.nodeType === 3;
		            }).text().trim(),
		            pr_thumbnail: $thumbnail.length > 0 ? $thumbnail.attr('src').split('/').pop() : 'no-image.jpg',
		            pr_opt_name: optionName,
		            pr_opt_price: parseInt($row.find('td:eq(3)').text().replace(/[^0-9]/g, ''))
		        };

		        // 위시리스트 중복 체크 후 추가
		        $.ajax({
		            url: '${pageContext.request.contextPath}/product/check_wishlist_item',
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify({
		                pr_id: productId,
		                pr_opt_name: optionName
		            })
		        })
		        .then(response => {
		            if (!response.exists) {
		                return $.ajax({
		                    url: '${pageContext.request.contextPath}/product/add_to_wishlist',
		                    type: 'POST',
		                    contentType: 'application/json',
		                    data: JSON.stringify(productData)
		                });
		            } else {
		                alert('이미 위시리스트에 있는 상품입니다.');
		                return Promise.reject('duplicate');
		            }
		        })
		        .then(response => {
		            if (response === 'success') {
		                alert('위시리스트에 추가되었습니다.');
		            }
		        })
		        .catch(error => {
		            if (error !== 'duplicate') {
		                alert('위시리스트 추가 중 오류가 발생했습니다.');
		            }
		        });
		    });
			
		 	// 모바일 버전 - 개별 상품 주문하기 버튼
		    $(document).on('click', '.cart-item-button.order', function() {
		        const $card = $(this).closest('.cart-item-card');
		        const inputId = $card.find('.mobile-quantity-input').attr('id').replace('mobile_', '');
		        const product = products[inputId];
		        const quantity = parseInt($card.find('.mobile-quantity-input').val());
		        
		        const orderItem = {
		            pr_id: $card.find('.product-checkbox').val(),
		            pr_name: $card.find('.cart-item-name').text().trim(),
		            pr_opt_name: $card.find('.cart-item-option').text().replace('[옵션: ', '').replace(']', ''),
		            pr_opt_price: product.price,
		            pror_qtt: quantity,
		            pror_product_amt: product.price * quantity,
		            pror_ship_cost: 3000
		        };

		        processOrder([orderItem]);
		    });

		    // 모바일 버전 - 위시리스트 버튼 클릭 이벤트 수정
		    $(document).on('click', '.cart-item-button:contains("위시리스트")', function() {
		        if ('${user}' === '') {
		            if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
		                window.location.href = '${pageContext.request.contextPath}/auth/login';
		            }
		            return;
		        }
		        
		        const $card = $(this).closest('.cart-item-card');
		        const $thumbnail = $card.find('.cart-item-image');
		        const productId = $card.find('.product-checkbox').val();
		        const optionName = $card.find('.cart-item-option').text().replace('[옵션: ', '').replace(']', '');
		        
		        let thumbnailPath = $thumbnail.length > 0 ? 
		            $thumbnail.attr('src').split('/').pop() : 
		            'no-image.jpg';
		        
		        const productData = {
		            pr_id: productId,
		            pr_name: $card.find('.cart-item-name').text().trim(),
		            pr_thumbnail: thumbnailPath,
		            pr_opt_name: optionName,
		            pr_opt_price: parseInt($card.find('.cart-item-price').text().replace(/[^0-9]/g, ''))
		        };

		        checkWishlistDuplicate(productId, optionName)
		            .then(response => {
		                if (!response.exists) {
		                    return $.ajax({
		                        url: '${pageContext.request.contextPath}/product/add_to_wishlist',
		                        type: 'POST',
		                        contentType: 'application/json',
		                        data: JSON.stringify(productData)
		                    });
		                } else {
		                    throw new Error('duplicate');
		                }
		            })
		            .then(response => {
		                if (response === 'success') {
		                    alert('위시리스트에 추가되었습니다.');
		                }
		            })
		            .catch(error => {
		                if (error.message === 'duplicate') {
		                    alert('이미 위시리스트에 있는 상품입니다.');
		                } else {
		                    alert('위시리스트 추가 중 오류가 발생했습니다.');
		                }
		            });
		    });

		    // 모바일 버전 - 선택 상품 삭제 버튼
		    $('.delete-selected-btn').on('click', function() {
		        const selectedItems = $('.mobile-cart-items .product-checkbox:checked').map(function() {
		            const $card = $(this).closest('.cart-item-card');
		            const inputId = $card.find('.mobile-quantity-input').attr('id');
		            return {
		                pr_id: products[inputId.replace('mobile_', '')].pr_id,
		                pr_opt_name: products[inputId.replace('mobile_', '')].pr_opt_name
		            };
		        }).get();

		        if (selectedItems.length === 0) {
		            alert('삭제할 상품을 선택해주세요.');
		            return;
		        }

		        if (confirm('선택한 상품을 삭제하시겠습니까?')) {
		            Promise.all(selectedItems.map(item => 
		                $.ajax({
		                    url: '${pageContext.request.contextPath}/product/remove_from_cart',
		                    type: 'POST',
		                    contentType: 'application/json',
		                    data: JSON.stringify(item)
		                })
		            )).then(() => {
		                location.reload();
		            }).catch(() => {
		                alert('삭제 중 오류가 발생했습니다.');
		            });
		        }
		    });

		 	// 모바일 버전 - 선택 상품 주문 버튼 클릭 이벤트 
			$('.mobile-order-btn.order-selected').on('click', function() {
			    const selectedItems = $('.mobile-cart-items .product-checkbox:checked').map(function() {
			        const $card = $(this).closest('.cart-item-card');
			        const inputId = $card.find('.mobile-quantity-input').attr('id').replace('mobile_', '');
			        
			        if (!products[inputId]) {
			            console.error('Product not found:', inputId);
			            return null;
			        }
			
			        const product = products[inputId];
			        const quantity = parseInt($card.find('.mobile-quantity-input').val());
			        
			        return {
			            pr_id: $card.find('.product-checkbox').val(),
			            pr_name: $card.find('.cart-item-name').text().trim(),
			            pr_opt_name: $card.find('.cart-item-option').text().replace('[옵션: ', '').replace(']', ''),
			            pr_opt_price: product.price,
			            pror_qtt: quantity,
			            pror_product_amt: product.price * quantity,
			            pror_ship_cost: 3000
			        };
			    }).get().filter(item => item !== null);
			
			    if (selectedItems.length === 0) {
			        alert('주문할 상품을 선택해주세요.');
			        return;
			    }
			
			    processOrder(selectedItems);
			});

		 	// 모바일 버전 - 전체 상품 주문 버튼
			$('.mobile-order-btn.order-all').on('click', function() {
			    const allItems = $('.cart-item-card').map(function() {
			        const $card = $(this);
			        const inputId = $card.find('.mobile-quantity-input').attr('id').replace('mobile_', '');
			        const product = products[inputId];
			        const quantity = parseInt($card.find('.mobile-quantity-input').val());
			        
			        return {
			            pr_id: $card.find('.product-checkbox').val(),
			            pr_name: $card.find('.cart-item-name').text().trim(),
			            pr_opt_name: $card.find('.cart-item-option').text().replace('[옵션: ', '').replace(']', ''),
			            pr_opt_price: product.price,
			            pror_qtt: quantity,
			            pror_product_amt: product.price * quantity,
			            pror_ship_cost: 3000
			        };
			    }).get();
			
			    if (allItems.length === 0) {
			        alert('장바구니가 비어있습니다.');
			        return;
			    }
			
			    processOrder(allItems);
			});
					    
		 	// 모바일 버전 - 수량 증가 버튼
		    $(document).on('click', '.mobile-quantity-button.plus', function() {
		        var input = $(this).siblings('.mobile-quantity-input');
		        var mobileInputId = input.attr('id');
		        var pcInputId = mobileInputId.replace('mobile_quantity_', 'quantity_');
		        var pcInput = $('#' + pcInputId);
		        
		        if (!products[pcInputId]) {
		            console.error('Product not found:', pcInputId);
		            return;
		        }
		        
		        var currentValue = parseInt(input.val());
		        var maxStock = products[pcInputId].stock;
		        var basePrice = products[pcInputId].price;
		        
		        if (currentValue < maxStock) {
		            currentValue += 1;
		            
		            // 모바일과 PC input 값 동기화
		            input.val(currentValue);
		            pcInput.val(currentValue);
		            
		            // 개별 상품 금액 계산
		            var totalPrice = basePrice * currentValue;
		            
		            // 모바일 버전 개별 상품 금액 업데이트
		            $(this).closest('.cart-item-card')
		                  .find('.cart-item-subtotal')
		                  .text('합계: ₩' + totalPrice.toLocaleString());
		            
		            // PC 버전도 업데이트
		            updateProductTotal(pcInputId);
		            // 전체 금액 업데이트
		            updateTotalPrice();
		            // DB 업데이트
		            updateCartQuantity(pcInputId, currentValue);
		        } else {
		            alert('재고가 부족합니다.');
		        }
		    });

		 	// 모바일 버전 - 수량 감소 버튼
		    $(document).on('click', '.mobile-quantity-button.minus', function() {
		        var input = $(this).siblings('.mobile-quantity-input');
		        var mobileInputId = input.attr('id');
		        var pcInputId = mobileInputId.replace('mobile_quantity_', 'quantity_');
		        var pcInput = $('#' + pcInputId);
		        var currentValue = parseInt(input.val());
		        var basePrice = products[pcInputId].price;
		        
		        if (currentValue > 1) {
		            currentValue -= 1;
		            
		            // 모바일과 PC input 값 동기화
		            input.val(currentValue);
		            pcInput.val(currentValue);
		            
		            // 개별 상품 금액 계산
		            var totalPrice = basePrice * currentValue;
		            
		            // 모바일 버전 개별 상품 금액 업데이트
		            $(this).closest('.cart-item-card')
		                  .find('.cart-item-subtotal')
		                  .text('합계: ₩' + totalPrice.toLocaleString());
		            
		            // PC 버전도 업데이트
		            updateProductTotal(pcInputId);
		            // 전체 금액 업데이트
		            updateTotalPrice();
		            // DB 업데이트
		            updateCartQuantity(pcInputId, currentValue);
		        }
		    });

			// 모바일 버전 - 수량 직접 입력 처리
			$(document).on('change', '.mobile-quantity-input', function() {
			    var mobileInputId = $(this).attr('id');
			    
			    // mobile_quantity_ 접두사를 quantity_로 변경
			    var pcInputId = mobileInputId.replace('mobile_quantity_', 'quantity_');
			    
			    if (!products[pcInputId]) {
			        console.error('Product not found:', pcInputId);
			        return;
			    }
			    
			    var value = parseInt($(this).val());
			    var maxStock = products[pcInputId].stock;
			    var basePrice = products[pcInputId].price;
			    
			    if (isNaN(value) || value < 1) {
			        value = 1;
			    } else if (value > maxStock) {
			        value = maxStock;
			        alert('재고가 부족합니다.');
			    }
			    
			    // 모바일과 PC input 값 동기화
			    $(this).val(value);
			    $('#' + pcInputId).val(value);
			    
			    // 개별 상품 금액 계산
			    var totalPrice = basePrice * value;
			    
			    // 모바일 버전 개별 상품 금액 업데이트
			    $(this).closest('.cart-item-card')
			          .find('.cart-item-subtotal')
			          .text('합계: ₩' + totalPrice.toLocaleString());
			    
			    // PC 버전도 업데이트
			    updateProductTotal(pcInputId);
			    // 전체 금액 업데이트
			    updateTotalPrice();
			    // DB 업데이트
			    updateCartQuantity(pcInputId, value);
			});

			// 숫자만 입력되도록 처리 (PC & 모바일 공통)
			$(document).on('input', '.quantity-input, .mobile-quantity-input', function() {
			    var value = $(this).val().replace(/[^0-9]/g, '');
			    $(this).val(value);
			});
		 	
		    // 위시리스트 중복 체크 API 엔드포인트 수정
		    function checkWishlistDuplicate(productId, optionName) {
		        return $.ajax({
		            url: '${pageContext.request.contextPath}/product/check_wishlist_item', // 엔드포인트 변경
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify({
		                pr_id: productId,
		                pr_opt_name: optionName
		            })
		        });
		    }
			
		    // 장바구니 비우기 함수
		    function clearCart() {
		        if (!confirm('장바구니를 비우시겠습니까?')) {
		            return;
		        }

		        // PC와 모바일 버전 모두에서 아이템 수집
		        const allItems = [];
		        $('.cart-table tbody tr, .cart-item-card').each(function() {
		            const $element = $(this);
		            const productId = $element.find('.product-checkbox').val();
		            const optionName = $element.find('.product-info span, .cart-item-option')
		                                     .text().replace('[옵션: ', '').replace(']', '');
		            
		            if (productId && optionName) {
		                allItems.push({
		                    pr_id: productId,
		                    pr_opt_name: optionName
		                });
		            }
		        });

		        if (allItems.length === 0) {
		            alert('장바구니가 이미 비어있습니다.');
		            return;
		        }

		        // 한 번의 요청으로 모든 아이템 삭제
		        $.ajax({
		            url: '${pageContext.request.contextPath}/product/remove_all_from_cart',
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify(allItems)
		        })
		        .then(() => {
		            location.reload();
		        })
		        .catch(() => {
		            alert('장바구니 비우기 중 오류가 발생했습니다.');
		        });
		    }

		    // PC 버전 장바구니 비우기 버튼
		    $('.action-buttons button:contains("장바구니비우기")').off('click').on('click', clearCart);
		    
		    // 모바일 버전 장바구니 비우기 버튼
		    $('.clear-cart-btn').off('click').on('click', clearCart);
		    
		    // 초기 상태 설정
		    initializeCheckboxes();
		    updateTotalPrice();		 
		});
		
	    // 연락처 유효성 검사 함수를 전역 스코프로 이동
	    window.formatPhoneNumber = function(input) {
	        let value = input.value.replace(/[^0-9]/g, '');
	        if (value.length <= 3) {
	            input.value = value;
	        } else if (value.length <= 7) {
	            input.value = value.slice(0, 3) + '-' + value.slice(3);
	        } else {
	            input.value = value.slice(0, 3) + '-' + 
	                         value.slice(3, 7) + '-' + 
	                         value.slice(7, 11);
	        }
	    };
	</script>  	
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp"/>
	<%@ include file="./cartOrderWishCommon.jsp" %>
    <main>
        <h1 class="cart-title">장바구니</h1>
        <table class="cart-table">
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"></th>
                    <th>이미지</th>
                    <th>상품정보</th>
                    <th>판매가</th>
                    <th>수량</th>
                    <th>배송비</th>
                    <th>합계</th>
                    <th>선택</th>
                </tr>
            </thead>
			<tbody>
			    <c:choose>
			        <c:when test="${empty cartList}">
			            <tr>
			                <td colspan="9" class="text-center">장바구니가 비어있습니다.</td>
			            </tr>
			        </c:when>
			        <c:otherwise>
			            <c:forEach var="item" items="${cartList}" varStatus="status">
			                <tr>
			                    <td><input type="checkbox" class="product-checkbox" name="selectedItem" value="${item.pr_id}"></td>
								<td>
								    <a href="/product/pr_detail?pr_id=${item.pr_id}">
								        <c:if test="${item.imageExists}">
								            <img src="${pageContext.request.contextPath}/product/getImage/${item.pr_thumbnail}" alt="${item.pr_name}" class="product-img">
								        </c:if>
								        <c:if test="${!item.imageExists}">
								            <div class="no-image">이미지 없음</div>
								        </c:if>
								    </a>
								</td>
								<td class="product-info">
								    <a href="/product/pr_detail?pr_id=${item.pr_id}">
								        ${item.pr_name}
								        <span>[옵션: ${item.pr_opt_name}]</span>
								    </a>
								</td>
								<td class="sales-sell">₩<fmt:formatNumber value="${item.pr_opt_price}" pattern="#,###"/></td>
								<td>
								    <div class="quantity-wrap">
								        <div class="quantity-input-group">
											<input type="number" value="${item.prsc_quantity}" min="1" class="quantity-input" id="quantity_${item.prsc_no}" data-product-id="${item.pr_id}" data-option-name="${item.pr_opt_name}">
											<div class="quantity-buttons">
											    <button type="button" class="quantity-button plus" data-target="quantity_${item.prsc_no}">▲</button>  
											    <button type="button" class="quantity-button minus" data-target="quantity_${item.prsc_no}">▼</button> 
											</div>
								        </div>
								    </div>
								</td>
			                    <td class="sales-deli">3,000원</td>
			                    <td class="sales-sum"><fmt:formatNumber value="${item.pr_opt_price * item.prsc_quantity}" pattern="#,###"/>원</td>
			                    <td>
			                        <div class="btn-list">
			                            <button class="btn btn-order">주문하기</button>
			                            <button class="btn btn-normal wish">위시리스트</button>
			                            <button class="btn btn-normal" onclick="removeFromCart(${item.pr_id}, '${item.pr_opt_name}')">× 삭제</button>
			                        </div>
			                    </td>
			                </tr>
			            </c:forEach>
			        </c:otherwise>
			    </c:choose>
			</tbody>
        </table>
		<div class="mobile-cart-items">
		    <c:choose>
		        <c:when test="${empty cartList}">
		            <div class="cart-item-card">
		                <p class="text-center">장바구니가 비어있습니다.</p>
		            </div>
		        </c:when>
		        <c:otherwise>
		            <c:forEach var="item" items="${cartList}" varStatus="status">
		                <div class="cart-item-card">
		                    <div class="cart-item-header">
		                        <input type="checkbox" class="cart-item-checkbox product-checkbox" name="selectedItem" value="${item.pr_id}">
		                        <a href="/product/pr_detail?pr_id=${item.pr_id}">
		                            <c:if test="${item.imageExists}">
		                                <img src="${pageContext.request.contextPath}/product/getImage/${item.pr_thumbnail}" alt="${item.pr_name}" class="cart-item-image">
		                            </c:if>
		                            <c:if test="${!item.imageExists}">
		                                <div class="no-image cart-item-image">이미지 없음</div>
		                            </c:if>
		                        </a>
		                        <div class="cart-item-info">
		                        	<div class="cart-item-name">
								        <a href="/product/pr_detail?pr_id=${item.pr_id}">${item.pr_name}</a>
								    </div>
		                            <div class="cart-item-option">[옵션: ${item.pr_opt_name}]</div>
		                        </div>
		                    </div>
		                    <div class="cart-item-price">
		                        판매가: ₩<fmt:formatNumber value="${item.pr_opt_price}" pattern="#,###"/>
		                    </div>
		                    <div class="cart-item-quantity">
		                        <span class="quantity-label">수량:</span>
		                        <div class="mobile-quantity-input-group">
		                            <button type="button" class="mobile-quantity-button minus">-</button>
		                            <input type="number" value="${item.prsc_quantity}" min="1" class="mobile-quantity-input quantity-input" id="mobile_quantity_${item.prsc_no}" data-product-id="${item.pr_id}" data-option-name="${item.pr_opt_name}">
		                            <button type="button" class="mobile-quantity-button plus">+</button>
		                        </div>
		                    </div>
		                    <div class="cart-item-subtotal">
		                        합계: ₩<fmt:formatNumber value="${item.pr_opt_price * item.prsc_quantity}" pattern="#,###"/>
		                    </div>
		                    <div class="cart-item-buttons">
		                        <button class="cart-item-button order">주문하기</button>
		                        <button class="cart-item-button wishm">위시리스트</button>
		                        <button class="cart-item-button" onclick="removeFromCart(${item.pr_id}, '${item.pr_opt_name}')">삭제</button>
		                    </div>
		                </div>
		            </c:forEach>
		        </c:otherwise>
		    </c:choose>
		</div>
        <div class="pc-cart-footer cart-footer">
			<div class="price-summary">
			    <div class="price-item">
			        <div class="price-label">총 상품금액</div>
			        <div class="price-value">
			            <c:set var="totalPrice" value="0"/>
			            <c:forEach var="item" items="${cartList}">
			                <c:set var="itemTotal" value="${item.pr_opt_price * item.prsc_quantity}"/>
			                <c:set var="totalPrice" value="${totalPrice + itemTotal}"/>
			            </c:forEach>
			            <fmt:formatNumber value="${totalPrice}" pattern="#,###"/><span>원</span>
			        </div>
			    </div>
			    <div class="price-separator">+</div>
			    <div class="price-item">
			        <div class="price-label">총 배송비</div>
			        <div class="price-value">
			            <c:set var="shippingCost" value="${totalPrice > 0 ? 3000 : 0}"/>
			            <fmt:formatNumber value="${shippingCost}" pattern="#,###"/><span>원</span>
			        </div>
			    </div>
			    <div class="price-separator">=</div>
			    <div class="price-item">
			        <div class="price-label">결제예정금액</div>
			        <div class="price-value">
			            <fmt:formatNumber value="${totalPrice + shippingCost}" pattern="#,###"/><span>원</span>
			        </div>
			    </div>
			</div>
            <div class="footer-info">
                <div class="delete-selected">
                    <span>선택상품을</span>
                    <button class="delete-btn">× 삭제하기</button>
                </div>
                <div class="action-buttons">
                    <button>장바구니비우기</button>
                </div>
            </div>
			<div class="purchase-buttons">
			    <button class="purchase-btn btn-buy-all">전체 주문하기</button>
			    <button class="purchase-btn btn-buy-selected">선택된 항목 주문하기</button>
			</div>
        </div>
		<div class="mobile-cart-footer cart-footer">
		    <div class="mobile-price-summary">
		        <div class="mobile-price-row">
		            <span>총 상품금액</span>
		            <strong><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원</strong>
		        </div>
		        <div class="mobile-price-row">
		            <span>총 배송비</span>
		            <strong><fmt:formatNumber value="${shippingCost}" pattern="#,###"/>원</strong>
		        </div>
		        <div class="mobile-price-total">
		            <span>결제예정금액</span>
		            <strong><fmt:formatNumber value="${totalPrice + shippingCost}" pattern="#,###"/>원</strong>
		        </div>
		    </div>
		    <div class="mobile-cart-actions">
		        <div class="mobile-action-row">
		            <button class="delete-selected-btn">선택상품 삭제</button>
		            <button class="clear-cart-btn">장바구니비우기</button>
		        </div>
		        <div class="mobile-order-buttons">
		            <button class="mobile-order-btn order-selected">선택 상품 주문</button>
		            <button class="mobile-order-btn order-all">전체 상품 주문</button>
		        </div>
		    </div>
		</div>
		<div class="modal fade" id="shippingModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		    <div class="modal-dialog">
		        <form class="modal-content" id="shippingForm">
		            <div class="modal-header">
		                <h5 class="modal-title">배송 정보 입력</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <div class="mb-3">
		                    <label for="recipient" class="form-label">받는 사람</label>
		                    <input type="text" class="form-control" id="recipient" name="pror_recipient" required>
		                </div>
		                <div class="mb-3">
		                    <label for="phone" class="form-label">연락처</label>
		                    <input type="tel" class="form-control" id="phone" name="pror_phone" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" oninput="formatPhoneNumber(this)" required>
		                </div>
		                <div class="mb-3">
		                    <label for="zipcode" class="form-label">우편번호</label>
		                    <div class="input-group">
		                        <input type="text" class="form-control" id="zipcode" name="pror_zipcode" readonly required>
		                        <button type="button" class="btn btn-secondary" id="searchAddrBtn">주소 찾기</button>
		                    </div>
		                </div>
		                <div class="mb-3">
		                    <label for="addr" class="form-label">주소</label>
		                    <input type="text" class="form-control" id="addr" name="pror_addr" readonly required>
		                </div>
		                <div class="mb-3">
		                    <label for="addr_detail" class="form-label">상세주소</label>
		                    <input type="text" class="form-control" id="addr_detail" name="pror_addr_detail" required>
		                </div>
		                <input type="hidden" name="pror_pay_method" value="card">
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="submit" class="btn btn-primary">결제하기</button>
		            </div>
		        </form>
		    </div>
		</div>
    </main>
    <jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>