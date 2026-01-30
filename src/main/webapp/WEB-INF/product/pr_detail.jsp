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
		
		a {
		    text-decoration: none;
		}
		
		ul {
		    list-style-type: none;
		}
		
		.quantity-input::-webkit-outer-spin-button,
        .quantity-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
		
		.header {
		    text-align: center;
		    padding: 10px 0;
		    margin-bottom: 20px;
		}
		
		.product-title {
		    font-size: 40px;
		    margin-bottom: 10px;
		}
		
		.product-content {
		    display: flex;
		    margin-bottom: 20px;
		}
		
		.product-thumbnail {
		    width: 50%;
		    height: 470px;
		    margin-right: 20px;
		    background-color: #f8f8f8;
		    border: 1px solid #ddd;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    color: #666;
		    position: relative;
		    overflow: hidden;
		}
		
		.thumbnail-item {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
		}
		
		.product-details {
		    width: 50%;
		}
		
		.rating-container {
		    display: flex;
		    gap: 12px;
		    margin-bottom: 20px;
		}
		
		.star-ratings {
		    unicode-bidi: bidi-override;
		    color: #ccc; /* 빈 별 색상 */
		    font-size: 30px;
		    position: relative;
		    margin: 0;
		    padding: 0;
		    display: inline-block;
		    width: auto !important; /* width 값을 auto로 변경 */
		}
		
		.fill-ratings {
		    color: #e7711b; /* 채워진 별 색상 */
		    padding: 0;
		    position: absolute;
		    z-index: 1;
		    display: block;
		    top: 0;
		    left: 0;
		    overflow: hidden;
		    height: 100%; /* 높이 추가 */
		}
		
		.fill-ratings span {
		    display: inline-block;
		    height: 100%; /* 높이 추가 */
		}
		
		.empty-ratings {
		    padding: 0;
		    display: block;
		    z-index: 0;
		    height: 100%; /* 높이 추가 */
		}
		
		.empty-ratings {
		    padding: 0;
		    display: block;
		    z-index: 0;
		}
		
		.product-ratings-count {
		    color: black;
		    font-size: 19px;
		    text-decoration: none;
		    white-space: nowrap;
		    margin-top: 10px;
		}
		
		.product-info {
		    margin: 20px 0;
		    padding: 15px;
		}
		
		.product-info p:first-child {
		    font-size: 24px;
		    font-weight: bold;
		}
		
		.product-info p:last-child {
		    font-size: 20px;
		    font-weight: bold;
		}
		
		.option-select {
		    width: 100%;
		    padding: 10px;
		    margin: 10px 0;
		    border: 1px solid #ddd;
		    border-radius: 4px;
		}
		
		.warning-message {
		    padding: 12px;
		    margin: 10px 0;
		    font-size: 13px;
		    color: #666;
		    display: flex;
		    align-items: center;
		}
		
		.warning-message::before {
		    content: "!";
		    color: red;
		    border: 1px solid red;
		    border-radius: 50%;
		    width: 16px;
		    height: 16px;
		    display: inline-flex;
		    align-items: center;
		    justify-content: center;
		    margin-right: 8px;
		    font-size: 12px;
		}
		
		.product-name {
		    font-weight: bold;
		    margin-bottom: 5px;
		}
		
		.option-name {
		    color: #666;
		    margin-bottom: 10px;
		}
		
		.quantity-control {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		}
		
		.quantity-adjust {
		    display: flex;
		    align-items: center;
		    border: 1px solid #ddd;
		}
		
		.quantity-btn {
		    width: 28px;
		    height: 28px;
		    border: none;
		    background: white;
		    cursor: pointer;
		}
		
		.quantity-input {
		    width: 40px;
            height: 28px;
            border: none;
            text-align: center;
            margin: 0;
		}
		
		.total-price {
		    margin-top: 20px;
		    padding-top: 15px;
		    border-top: 1px solid #ddd;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    font-weight: bold;
		}
		
		.button-group {
		    display: flex;
		    justify-content: space-between;
		    gap: 10px;
		    margin-top: 50px;
		}
		
		.button-cart, .button-buy {
		    flex: 1;
		    padding: 10px 20px;
		    color: white;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    font-weight: bold;
		}
		
		.button-cart {
		    background-color: #868e96;
		}
		
		.button-buy {
		    background-color: #6c757d;
		}
		
		.button-cart:hover,
		.button-buy:hover {
		    opacity: 0.5;
		}
		
		.tabs {
		    display: flex;
		    margin: 0;
		    padding: 0;
		    list-style: none;
		    border-bottom: 1px solid #caced1;
		    background-color: #fff;
		    width: 100%;
		}
		
		.tab {
		    flex: 1;  
		    text-align: center;
		    padding: 15px 0;
		    cursor: pointer;
		    border: none;
		    background: transparent;
		    color: #495057;
		    font-size: 18px;
		    font-weight: 500;
		    position: relative;
		    transition: color 0.2s;
		}
		
		.tab.active {
		    color: #000;
		    border: 2px solid #6c757d;
		}
		
		.tab-content {
		    display: none;
		    margin-top: 20px;
		}
		
		.tab-content.active {
		    display: block;
		}
		
		.review-section {
		    padding: 20px;
		}
		
		.review-header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-bottom: 20px;
		}
		
		.write-review-btn {
		    padding: 10px 20px;
		    background-color: #6c757d;
		    color: white;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    font-weight: bold;
		}
		
		.write-review-btn:hover {
		    opacity: 0.5;
		}
		
		.review-item {
		    border: 1px solid #caced1;
		    border-radius: 4px;
		    padding: 20px;
		    margin-bottom: 20px;
		}
		
		.review-image-container {
		    position: relative;
		    max-width: 25%;
		    background-color: #f8f9fa;
		    border: 1px solid #dee2e6;
		    margin: 10px 0;
		}
		
		.review-show-item {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
		}
		
		.review-user {
		    display: flex;
		    justify-content: space-between;
		    margin-bottom: 10px;
		    align-items: center;
		    padding-right: 100px;
		}
		
		.review-rating {
		    position: relative;
		    right: -80px;
		    top: 0;
		    margin: 0;
		    padding: 0;
		    display: inline-block;
		    unicode-bidi: bidi-override;
		    font-size: 24px;
		    width: auto !important;
		}
		
		.review-empty-ratings {
		    color: #ccc;
		    padding: 0;
		    display: block;
		    z-index: 0;
		    position: relative;
		}
		
		.review-fill-ratings {
		    color: #ffd43b;
		    padding: 0;
		    position: absolute;
		    z-index: 1;
		    display: block;
		    top: 0;
		    left: 0;
		    overflow: hidden;
		}
		
		.review-fill-ratings span, 
		.review-empty-ratings span {
		    display: inline-block;
		}
		
		.user-info {
		    color: #666;
		    font-size: 14px;
		    flex-grow: 1;
		}
		
		.review-content {
		    clear: both;
		    margin-top: 15px;
		    line-height: 1.5;
		}
		
		.review-modify {
		    display: flex;
		    justify-content: flex-end;
		    gap: 10px;
		}
		
		.review-edit,
		.review-delete {
		    padding: 10px 20px;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    font-weight: bold;
		}
		
		.review-edit {
		    background-color: #ffc107;
		    color: black;
		}
		
		.review-delete {
		    background-color: #dc3545;
		    color: white;
		}
		
		.review-edit:hover,
		.review-delete:hover {
		    opacity: 0.5;
		}
		
		.stars {
		    cursor: pointer;
		}
		
		.stars .star {
		    color: #ddd;
		    margin: 0 5px;
		}
		
		.stars .star.active {
		    color: #ffd43b;
		}
		
		.modal {
		    pointer-events: none;
		}
		
		.modal-dialog {
		    pointer-events: all;
		}
		
		.review-star-rating {
		    width: 45px;
		    text-align: center;
		    border: 0;
		    background-color: white !important;
		    font-size: 32px;
		    font-weight: bold;
		}
		
		.review-star-rating:focus {
		    outline: none;
		    border: 0;
		    box-shadow: none;
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
		
		.no-image-text,
		.modal-no-image-text {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    color: #6c757d;
		    background-color: #f8f9fa;
		    border: 1px solid #dee2e6;
		}
		
		.no-image-text {
		    width: 100%;
		    height: 100%;
		}
		
		.modal-no-image-text {
		    width: 100%;
		    height: 200px;
		}
		
		.inquiry-container {
		    max-width: 1000px;
		    margin: 0 auto;
		    padding: 20px;
		}
		
		.inquiry-header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-bottom: 20px;
		    padding: 10px 0;
		}
		
		.inquiry-header p {
		    font-size: 18px;
		    font-weight: bold;
		    margin: 0;
		}
		
		.inquiry-notice {
		    background-color: #f8f9fa;
		    padding: 20px;
		    margin-bottom: 20px;
		    border-radius: 4px;
		}
		
		.inquiry-notice ul {
		    margin: 0;
		    padding: 0;
		}
		
		.inquiry-notice li {
		    position: relative;
		    padding-left: 15px;
		    margin-bottom: 8px;
		    color: #666;
		    font-size: 14px;
		    line-height: 1.5;
		}
		
		.inquiry-notice li:before {
		    content: "•";
		    position: absolute;
		    left: 0;
		    color: #999;
		}
		
		.inquiry-notice li:last-child {
		    margin-bottom: 0;
		}
		
		.inquiry-list {
		    border-top: 1px solid #dee2e6;
		}
		
		.inquiry-item {
		    border-bottom: 1px solid #dee2e6;
		    padding: 20px 0;
		}
		
		.inquiry-info,
		.answer-info {
		    display: flex;
		    align-items: center;
		    gap: 10px;
		    margin-bottom: 10px;
		}
		
		.inquiry-badge,
		.answer-badge {
		    padding: 4px 8px;
		    border-radius: 4px;
		    font-size: 12px;
		    font-weight: bold;
		}
		
		.inquiry-badge {
		    background-color: #e9ecef;
		    color: #495057;
		}
		
		.answer-badge {
		    background-color: #6c757d;
		    color: white;
		}
		
		.answer-text {
		    color: #666;
		    font-size: 14px;
		}
		
		.inquiry-content,
		.answer-content {
		    padding: 0 30px;
		    margin: 10px 0;
		    font-size: 15px;
		    line-height: 1.5;
		}
		
		.answer-item {
		    background-color: #f8f9fa;
		    margin: 10px 0;
		    padding: 20px;
		    border-radius: 4px;
		}
		
		.answer-text {
		    font-weight: bold;
		    color: #495057;
		}
		
		.inquiry-write-btn,
		.inquiry-delete-btn,
		.inquiry-answer-btn {
		    padding: 10px 20px;
		    border: none;
		    border-radius: 4px;
		    font-weight: bold;
		    cursor: pointer;
		}
		
		.inquiry-write-btn {
		    background-color: #6c757d;
		    color: white;
		}
		
		.inquiry-delete-btn {
		    background-color: #dc3545;
		    color: white;
		    margin-left: auto;
		}
		
		.inquiry-answer-btn {
		    background-color: #28a745;
		    color: white;
		    margin-left: 10px;
		}
		
		.inquiry-write-btn:hover,
		.inquiry-delete-btn:hover,
		.inquiry-answer-btn:hover {
		    opacity: 0.8;
		}
		
		.required:after {
		    content: " *";
		    color: red;
		}
		
		#shippingModal .form-label {
		    font-weight: bold;
		}
		
		#shippingModal .modal-body {
		    max-height: 70vh;
		    overflow-y: auto;
		}
		
		.review-show-item {
		    transition: opacity 0.2s;
		}
		
		.review-show-item:hover {
		    opacity: 0.8;
		}
		
		/* 모달 스타일 추가 */
		#imageModal .modal-dialog {
		    max-width: 90%;
		    margin: 1.75rem auto;
		}
		
		#imageModal .modal-content {
		    background-color: transparent;
		    border: none;
		    position: relative;
		}
		
		#imageModal .modal-header {
		    border: none;
		    padding: 0;
		    position: absolute;
		    right: -15px;   
		    top: -15px;     
		    z-index: 1;
		}
		
		#imageModal .btn-close {
		    background-color: white;
		    opacity: 0.8;
		    padding: 6px;   
		    margin: 0;
		    box-shadow: 0 0 5px rgba(0,0,0,0.2);
		    border-radius: 50%;
		}
		
		#imageModal .btn-close:hover {
		    opacity: 1;
		    box-shadow: 0 0 8px rgba(0,0,0,0.3);
		}
		
		#imageModal .modal-body {
		    padding: 0;
		    background-color: transparent;
		}
		
		#modalImage {
		    max-height: 90vh;
		    object-fit: contain;
		}
		
		.selected-options-container {
		    margin: 10px 0;
		}
		
		.selected-option {
		    background-color: #f8f8f8;
		    padding: 15px;
		    margin-bottom: 10px;
		    border-radius: 4px;
		}
		
		.product-option {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-bottom: 10px;
		}
		
		.remove-option {
		    background: none;
		    border: none;
		    cursor: pointer;
		    font-size: 20px;
		    color: #999;
		}
		
		.remove-option:hover {
		    color: #666;
		}
		
		.review-thumbnail-item {
		    width: 150px; 
		    height: 150px; 
		    border-radius: 50%; 
		    object-fit: cover; 
		    display: block;
		    margin: 0 auto 10px; 
		}
		
		.modal-body .text-center.mb-3 {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    gap: 10px;
		}
		
		.modal-body .mb-1 {
		    font-size: 16px;
		    font-weight: bold;
		    margin: 5px 0;
		}
		
		.review-upload-container {
		    position: relative;
		    width: 100%;
		    padding: 10px;
		    background-color: #f8f9fa;
		    border-radius: 8px;
		}
		
		.review-upload-label {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    justify-content: center;
		    padding: 20px;
		    border: 2px dashed #dee2e6;
		    border-radius: 8px;
		    cursor: pointer;
		    transition: all 0.3s ease;
		}
		
		.review-upload-label:hover {
		    border-color: #adb5bd;
		    background-color: #f1f3f5;
		}
		
		.upload-icon {
		    color: #868e96;
		    margin-bottom: 8px;
		}
		
		.upload-text {
		    color: #868e96;
		    font-size: 14px;
		}
		
		.preview-container {
		    position: relative;
		    margin-top: 10px;
		    width: 100%;
		}
		
		.preview-image {
		    width: 100%;
		    max-height: 200px;
		    object-fit: contain;
		    border-radius: 4px;
		}
		
		.remove-preview {
		    position: absolute;
		    top: -10px;
		    right: -10px;
		    width: 24px;
		    height: 24px;
		    border-radius: 50%;
		    background-color: #dc3545;
		    color: white;
		    border: none;
		    cursor: pointer;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    font-size: 16px;
		    padding: 0;
		}
		
		.remove-preview:hover {
		    background-color: #c82333;
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
		
		.cart-success-modal {
		    text-align: center;
		    padding: 20px;
		}
		
		.cart-success-modal img {
		    width: 200px;
		    height: 200px;
		    margin-bottom: 20px;
		}
		
		.cart-success-modal h3 {
		    margin-bottom: 20px;
		    font-weight: bold;
		}
		
		.cart-buttons {
		    display: flex;
		    justify-content: center;
		    gap: 10px;
		    margin-top: 20px;
		}
		
		.cart-button {
		    padding: 10px 20px;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    font-weight: bold;
		    min-width: 120px;
		}
		
		.continue-shopping {
		    background-color: #f8f9fa;
		    color: #212529;
		}
		
		.go-to-cart {
		    background-color: #212529;
		    color: white;
		}
		
		.navigation-bar {
		    max-width: 1000px;
		    margin: 20px auto;
		    font-size: 20px;
		    color: #666;
		}
		
		.navigation-bar a {
		    color: #666;
		    text-decoration: none;
		}
		
		.navigation-bar a:hover {
		    color: #000;
		}
		
		.navigation-separator {
		    margin: 0 5px;
		}
		
		.navigation-current {
		    color: #000;
		}
		
		@media screen and (max-width: 768px) {
		    .product-title {
		        font-size: 30px;
		        padding: 0 10px;
		    }
		    
		    .navigation-bar {
		        padding: 0 10px;
		        font-size: 15px;
		    }
		
		    .product-content {
		        flex-direction: column;
		        padding: 0 10px;
		    }
		    
		    .product-thumbnail {
		        width: 100%;
		        height: 300px;
		        margin-right: 0;
		        margin-bottom: 20px;
		    }
		    
		    .product-details {
		        width: 100%;
		    }
		    
		    .rating-container {
		        justify-content: center;
		        margin-bottom: 15px;
		    }
		    
		    .star-ratings {
		        font-size: 24px;
		    }
		    
		    .product-ratings-count {
		        font-size: 18px;
		    }
		    
		    .product-info {
		        text-align: center;
		    }
		    
		    .product-info p:first-child {
		        font-size: 20px;
		    }
		    
		    .option-select {
		        font-size: 14px;
		    }
		    
		    .selected-option {
		        padding: 10px;
		    }
		    
		    .quantity-control {
		        flex-wrap: wrap;
		        gap: 10px;
		    }
		    
		    .quantity-adjust {
		        width: 100%;
		        justify-content: center;
		    }
		    
		    .product-option-price {
		        width: 100%;
		        text-align: center;
		    }
		    
		    .button-group {
		        flex-direction: column;
		        gap: 10px;
		    }
		    
		    .button-cart,
		    .button-buy {
		        width: 100%;
		        padding: 15px 0;
		    }
		    
		    .tabs {
		        width: 100%;
		        overflow-x: auto;
		        -webkit-overflow-scrolling: touch;
		    }
		    
		    .tab {
		        padding: 12px 0;
		        font-size: 16px
		    }
		    
		    .review-section {
		        padding: 10px;
		    }
		    
		    .review-header {
		        flex-direction: column;
		        gap: 10px;
		        align-items: stretch;
		    }
		    
		    .write-review-btn {
		        width: 100%;
		    }
		    
		    .form-select {
		        width: 100% !important;
		        border: 1px solid #caced1 !important;
		    }
		    
		    .review-item {
		        padding: 15px;
		    }
		    
		    .review-user {
		        display: flex;
		        flex-direction: column;
		        align-items: center;
		        padding-right: 0;
		    }
		
		    .user-info {
		        text-align: center;
		        order: 1;  /* 순서를 변경하여 별점이 위로 가도록 */
		    }
		
		    .review-rating {
		        position: relative;
		        right: 0;  /* right 값을 제거 */
		        order: 2;  /* user-info 다음에 오도록 */
		        margin: 10px 0;  /* 위아래 여백 추가 */
		    }
		
			.review-fill-ratings {
			    position: absolute;
			    top: 0;
			    left: 0;
			    color: #ffd43b;
			    overflow: hidden;
			}
		
			.review-empty-ratings {
			    color: #ccc;
			}
		
		    .review-fill-ratings span, 
		    .review-empty-ratings span {
		        display: inline-block;
		    }
		    
		    .review-image-container {
		        max-width: 100%;
		    }
		    
		    .inquiry-container {
		        padding: 10px;
		    }
		    
		    .inquiry-header {
		        margin-bottom: 10px;
		    }
		    
		    .inquiry-write-btn {
		        width: 100%;
		    }
		    
		    .inquiry-notice {
		        font-size: 12px;
		    }
		    
		    .inquiry-item {
		        padding: 15px 0;
		    }
		    
		    .detail-pagination {
		        flex-wrap: wrap;
		        justify-content: center;
		        gap: 5px;
		    }
		    
		    .detail-page-item {
		        min-width: 28px;
		        height: 28px;
		        font-size: 12px;
		    }
		    
		    .modal-dialog {
		        margin: 10px;
		    }
		    
		    .review-thumbnail-item {
		        width: 120px;
		        height: 120px;
		    }
		    
		    .stars .star {
		        font-size: 24px !important;
		    }
		    
		    .review-star-rating {
		        font-size: 24px;
		    }
		    
		    .cart-success-modal img {
		        width: 150px;
		        height: 150px;
		    }
		    
		    .cart-buttons {
		        flex-direction: column;
		    }
		    
		    .cart-button {
		        width: 100%;
		    }
		    
		    #imageModal .modal-dialog {
		        max-width: 95%;
		        margin: 10px;
		    }
		    
		    .inquiry-info {
		        flex-wrap: wrap;
		        gap: 8px;
		        font-size: 13px;
		    }
		    
		    .inquiry-delete-btn,
		    .inquiry-answer-btn {
		        padding: 6px 12px;
		        font-size: 12px;
		        height: auto;
		        line-height: normal;
		    }
		
		    .inquiry-delete-btn {
		        margin-left: auto;
		        background-color: #dc3545;
		        color: white;
		        border: none;
		        border-radius: 4px;
		    }
		
		    .inquiry-answer-btn {
		        background-color: #28a745;
		        color: white;
		        border: none;
		        border-radius: 4px;
		    }
		
		    .inquiry-content {
		        padding: 10px 15px;
		        font-size: 14px;
		    }
		
		    .inquiry-badge,
		    .answer-badge {
		        padding: 3px 6px;
		        font-size: 11px;
		    }
		}
		
		@media screen and (min-width: 769px) and (max-width: 1024px) {
		    .product-content {
		        padding: 0 20px;
		    }
		    
		    .product-thumbnail {
		        height: 400px;
		    }
		    
		    .product-info p:first-child {
		        font-size: 22px;
		    }
		    
		    .button-group {
		        gap: 15px;
		    }
		}
    </style>
    <script>
        $(document).ready(function() {  
        	// 초기 별점 세팅
            var initialRating = '5';
            $('#selected-rating').val(initialRating);
            $('#rating-display').val(initialRating);
            highlightStars(initialRating);
            
            var star_rating_width = $('.fill-ratings span').width();
            $('.star-ratings').width(star_rating_width);
            
            var review_rating_width = $('.review-fill-ratings span').width();
            $('.review-rating').width(review_rating_width);
            
            $('.review-fill-ratings').each(function() {
                var rating = $(this).data('rating');
                if (rating) {
                    $(this).css('width', rating + '%');
                }
            });
                        
            $('.tab').on('click', function() {
                showTab(this);
            });
            
            $('.product-ratings-count').click(function() {
                const tabs = document.querySelectorAll('.tab');
                const contents = document.querySelectorAll('.tab-content');
                const selectedTab = document.getElementById('reviewTab');
                
                tabs.forEach(t => t.classList.remove('active'));
                contents.forEach(c => c.classList.remove('active'));
    
                selectedTab.classList.add('active');
    
                const contentId = selectedTab.getAttribute('data-target');
                document.getElementById(contentId).classList.add('active');
            });
            
            let selectedOptions = new Set(); // 중복 방지를 위해 Set 사용
            
            $('.option-select').on('change', function() {
                const selectedOption = $(this).find('option:selected');
                
                if (!selectedOption.val()) {
                    return;
                }
                
                const optionName = selectedOption.data('option-name');
                const productName = selectedOption.val();
                const price = parseInt(selectedOption.data('option-price'));
                const stockQuantity = selectedOption.text().match(/\((\d+)개\)/);
                const stock = stockQuantity ? parseInt(stockQuantity[1]) : 0;
                
                // 재고가 0인 경우
                if (stock === 0) {
                    $('.button-cart, .button-buy').prop('disabled', true)
                        .css('opacity', '0.5')
                        .css('cursor', 'not-allowed');
                    alert('해당 옵션은 품절되었습니다.');
                    $(this).val('');  // 품절된 경우에만 초기화
                    return;
                } else {
                    $('.button-cart, .button-buy').prop('disabled', false)
                        .css('opacity', '1')
                        .css('cursor', 'pointer');
                }
                
                // 이미 선택된 동일한 옵션이 있는지 확인
                const existingOptions = $('.selected-option');
                for (let i = 0; i < existingOptions.length; i++) {
                    const existingOptionName = $(existingOptions[i]).find('.product-option-name').text();
                    if (existingOptionName === optionName) {
                        alert('이미 선택된 옵션입니다.');
                        return;  // 중복된 경우 현재 선택값 유지
                    }
                }

                const optionHtml = 
                    '<div class="selected-option">' +
                        '<div class="selected-product">' +
                            '<div class="product-option">' +
                                '<div class="product-option-name">' + optionName + '</div>' +
                                '<button type="button" class="remove-option">×</button>' +
                            '</div>' +
                            '<div class="quantity-control">' +
                                '<div class="quantity-adjust">' +
                                    '<button type="button" class="quantity-btn minus">-</button>' +
                                    '<input type="number" class="quantity-input" value="1" min="1">' +
                                    '<button type="button" class="quantity-btn plus">+</button>' +
                                '</div>' +
                                '<div class="product-option-price">₩' + price.toLocaleString() + '</div>' +
                            '</div>' +
                        '</div>' +
                    '</div>';

                $('.warning-message').hide();
                $('.selected-options-container').append(optionHtml);
                $('.total-price').show();
                
                updateTotalPrice();
            });

         	// 옵션 삭제
            $(document).on('click', '.remove-option', function() {
                $(this).closest('.selected-option').remove();
                
                // select 태그를 첫 번째 옵션으로 리셋
                $('.option-select').val('');
                
                // 선택된 옵션이 없으면
                if ($('.selected-option').length === 0) {
                    $('.warning-message').show(); // 경고 메시지 다시 표시
                    $('.total-price').hide(); // 총 금액 영역 숨기기
                }
                
                updateTotalPrice();
            });

            // 수량 조절
            $(document).on('click', '.quantity-btn', function() {
                const $input = $(this).siblings('.quantity-input');
                let value = parseInt($input.val());
                const max = parseInt($input.attr('max'));
                
                if ($(this).hasClass('plus') && value < max) {
                    $input.val(value + 1);
                } else if ($(this).hasClass('minus') && value > 1) {
                    $input.val(value - 1);
                }
                updateTotalPrice();
            });
         	
         	// 총 금액 업데이트
			function updateTotalPrice() {
			    let total = 0;
			    let totalQuantity = 0;
			    
			    // 각 선택된 옵션별로 계산
			    $('.selected-option').each(function() {
			        const quantity = parseInt($(this).find('.quantity-input').val());
			        const priceText = $(this).find('.product-option-price').text().replace(/[^0-9]/g, '');
			        const price = parseInt(priceText);
			        
			        if (!isNaN(price) && !isNaN(quantity)) {
			            total += price * quantity;
			            totalQuantity += quantity;
			        }
			    });
			    
			    $('.total-amount').text('₩' + total.toLocaleString() + '(' + totalQuantity + '개)');
			}

			// 리뷰 작성 버튼 클릭 시
			$('.write-review-btn').click(function(e) {
			    e.preventDefault();
			    
			    if ('${user}' === '') {
			        if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
			            window.location.href = '${pageContext.request.contextPath}/auth/login';
			        }
			        return;
			    }
			
			    $.ajax({
			        url: '${pageContext.request.contextPath}/product/check_review_permission',
			        type: 'POST',
			        data: { 
			            pr_id: ${productDetail[0].pr_id}  // pr_id 전달
			        },
			        success: function(response) {
			            if (response.canWrite) {
			                // 구매 정보에서 필요한 값들 추출하여 모달 폼에 설정
			                $('#pror_item_id').val(response.purchaseInfo.pror_item_id);
			                $('#pror_master_id').val(response.purchaseInfo.pror_master_id);
			                $('#pr_opt_id').val(response.purchaseInfo.pr_opt_id);
			                $('#pr_opt_name').val(response.purchaseInfo.pr_opt_name);
			                
			                new bootstrap.Modal(document.getElementById('reviewModal')).show();
			            } else {
			                alert(response.message);
			            }
			        },
			        error: function(xhr) {
			            if (xhr.status === 401) {
			                if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
			                    window.location.href = '${pageContext.request.contextPath}/auth/login';
			                }
			            } else {
			                alert('권한 확인 중 오류가 발생했습니다.');
			            }
			        }
			    });
			});

            $('.stars .star').click(function() {
                var rating = $(this).data('rating');
                $('#selected-rating').val(rating);  
                $('#rating-display').val(rating); 
                highlightStars(rating);
            });

            $('.stars .star').hover(
	       	    function() {
	       	        var hoverRating = $(this).data('rating');
	       	        highlightStars(hoverRating);
	       	        $('#rating-display').val(hoverRating);
	       	    },
	       	    function() {
	       	        var selectedRating = $('#selected-rating').val() || '5';
	       	        highlightStars(selectedRating);
	       	        $('#rating-display').val(selectedRating);
	       	    }
            );
            
            function highlightStars(rating) {
                $('.stars .star').removeClass('active');
                $('.stars .star').each(function() {
                    if ($(this).data('rating') <= rating) {
                        $(this).addClass('active');
                    }
                });
            }
            
         	// reviewForm submit 이벤트 수정
			$('#reviewForm').on('submit', function(e) {
			    e.preventDefault();
			    
			    let description = $('textarea[name="prc_desc"]').val().trim();
			    if (!description) {
			        alert('리뷰 내용을 입력해주세요.');
			        return;
			    }
			
			    let formData = new FormData(this);
			    
			    $.ajax({
			        url: '/product/review_write',
			        type: 'POST',
			        data: formData,
			        processData: false,
			        contentType: false,
			        success: function(response) {
			            // 응답 유효성 검사
			            if (!response || !response.success) {
			                alert('리뷰 등록에 실패했습니다.');
			                return;
			            }
			
			            // 리뷰 데이터 검증
			            if (!response.review) {
			                alert('리뷰 데이터가 없습니다.');
			                return;
			            }
			
			            alert('리뷰가 등록되었습니다.');
			            
			            // 모달 닫기
			            const reviewModal = bootstrap.Modal.getInstance(document.getElementById('reviewModal'));
			            if (reviewModal) {
			                reviewModal.hide();
			            }
			            
			            // 폼 초기화
			            $('#reviewForm')[0].reset();
			            removePreview();
			            
			            // 리뷰 HTML 생성 (안전한 값 참조)
						var newReviewHtml = '<div class="review-item">' +
						    '<div class="review-user">' +
						        '<div class="user-info">' + 
						            (response.review.us_id || '') + ' 작성일 - ' + 
						            (response.review.prc_start_date || '') + 
						        '</div>' +
						        '<div class="review-rating">' +
						            '<div class="review-fill-ratings" style="width: ' + 
						                ((response.review.prc_rating || 0) * 20) + '%;">' +
						                '<span>★★★★★</span>' +
						            '</div>' +
						            '<div class="review-empty-ratings">' +
						                '<span>★★★★★</span>' +
						            '</div>' +
						        '</div>' +
						    '</div>';
			
						 	// 이미지가 있는 경우에만 이미지 컨테이너 추가
						    if (response.review.imageExists) {
						        newReviewHtml += '<div class="review-image-container">' +
						            '<img class="review-show-item" ' +
						                 'src="${pageContext.request.contextPath}/product/getImage/' + 
						                 (response.review.prc_image || '') + '" ' +
						                 'alt="' + (response.review.prc_image || '') + '" ' +
						                 'style="cursor: pointer;" ' +
						                 'onclick="showImageModal(this.src)">' +
						            '</div>';
						    }
			
						    newReviewHtml += '<div class="review-content">' + 
						    (response.review.prc_desc || '') + '</div>';

						// admin 계정일 경우에만 삭제 버튼 추가
						if ('${user.us_id}' === 'admin') {
						    newReviewHtml += '<div class="review-modify">' +
						        '<button type="button" class="review-delete" data-review-no="' + 
						        (response.review.prc_no || '') + '">삭제</button>' +
						        '</div>';
						}

						newReviewHtml += '</div>';
			
			            // 리뷰가 없다는 메시지 제거
			            $('.text-center.p-5').remove();
			            
			            // 새 리뷰를 리뷰 목록 최상단에 추가
			            $('.review-header').after(newReviewHtml);
			            
			            // 리뷰 수 업데이트 (안전하게 처리)
			            var currentCountEl = $('.product-ratings-count').text().match(/\d+/);
			            var currentCount = currentCountEl ? parseInt(currentCountEl[0]) + 1 : 1;
			            $('.product-ratings-count').text('(' + currentCount + '개의 고객 상품평)');
			            
			            // 평균 평점 업데이트 (있는 경우에만)
			            if (typeof response.averageRating !== 'undefined') {
			                $('.fill-ratings').css('width', response.averageRating + '%');
			            }
			            
			            // 별점 width 재계산
			            var review_rating_width = $('.review-fill-ratings span').width();
			            if (review_rating_width) {
			                $('.review-rating').width(review_rating_width);
			            }
			        },
			        error: function(xhr) {
			            if (xhr.status === 401) {
			                if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
			                    window.location.href = '${pageContext.request.contextPath}/auth/login';
			                }
			            } else {
			                console.error('리뷰 등록 오류:', xhr.responseText);
			                alert(xhr.responseText || '리뷰 등록 중 오류가 발생했습니다.');
			            }
			        }
			    });
			});
         
			// 이미지 로딩 실패 시 대체 텍스트 표시
			$(document).on('error', '.review-show-item', function() {
			    $(this).parent().html('<div class="no-image-text">이미지 없음</div>');
			});

            // 모달이 닫힐 때 폼 초기화
            $('#reviewModal').on('hidden.bs.modal', function () {
                $('#reviewForm')[0].reset();
                removePreview();
            });
            
         	// 문의하기 버튼 클릭 시 모달 표시
            $('.inquiry-write-btn').click(function() {
                // 로그인 체크 추가
                if ('${user}' === '') {
                    if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
                        window.location.href = '${pageContext.request.contextPath}/auth/login';
                    }
                    return;
                }
                new bootstrap.Modal(document.getElementById('inquiryModal')).show();
            });

        	// 문의하기 폼 제출
            $('#inquiryForm').on('submit', function(e) {
                e.preventDefault();
                
                let description = $('textarea[name="prq_desc"]').val().trim();
                if (!description) {
                    alert('문의 내용을 입력해주세요.');
                    return;
                }

                const form = this;
                form.action = '${pageContext.request.contextPath}/product/question_write';
                form.method = 'POST';
                
                // 모달 닫기
                const inquiryModal = bootstrap.Modal.getInstance(document.getElementById('inquiryModal'));
                inquiryModal.hide();
                
                // 폼 제출 후의 동작을 직접 처리
                form.submit();
                window.scrollTo(0, document.getElementById('write-inquiry-btn').offsetTop);
            });
            
			// 문의글 삭제 버튼 클릭 이벤트
			$('.inquiry-delete-btn').click(function() {
			    if (!confirm('이 문의글을 삭제하시겠습니까?')) {
			        return;
			    }
			    
			    const inquiryNo = $(this).data('inquiry-no');
			    
			    fetch('${pageContext.request.contextPath}/product/question_remove', {
			        method: 'POST',
			        headers: {
			            'Content-Type': 'application/x-www-form-urlencoded',
			        },
			        body: 'prq_no=' + inquiryNo
			    })
			    .then(response => {
			        if (!response.ok) {
			            throw new Error('문의글 삭제에 실패했습니다.');
			        }
			        return response.text();
			    })
			    .then(data => {
			    	if (data === 'success') {
			    	    alert('문의글이 삭제되었습니다.');

			    	    // 현재 URL에 상품문의 탭 유지 및 스크롤 위치를 위한 파라미터 추가
			    	    const targetOffset = document.getElementById('write-inquiry-btn').offsetTop;
			    	    const currentURL = new URL(window.location.href);

			    	    currentURL.searchParams.set('tab', 'inquiries'); // '상품문의' 탭 활성화 유지
			    	    currentURL.searchParams.set('scroll', targetOffset); // 스크롤 위치 저장

			    	    // URL 변경 후 강제 새로고침
			    	    window.location.replace(currentURL.toString());
			    	} else {
			    	    alert(data);
			    	}
			    })
			    .catch(error => {
			        alert(error.message);
			    });
			});
            
         	// 답글달기 버튼 클릭 시 모달 표시
			$('.inquiry-answer-btn').click(function() {
			    const inquiryNo = $(this).data('inquiry-no');
			    $('#answer_prq_no').val(inquiryNo);
			    
			    // 기존 모달 인스턴스가 있다면 제거
			    const existingModal = bootstrap.Modal.getInstance(document.getElementById('answerModal'));
			    if (existingModal) {
			        existingModal.dispose();
			    }
			    
			    // 새로운 모달 인스턴스 생성 및 표시
			    new bootstrap.Modal(document.getElementById('answerModal')).show();
			});

			// 답글 폼 제출
			$('#answerForm').on('submit', function(e) {
			    e.preventDefault();
			    
			    let answer = $('textarea[name="prq_comments"]').val().trim();
			    if (!answer) {
			        alert('답변 내용을 입력해주세요.');
			        return;
			    }

			    // 모달 닫기
			    const answerModal = bootstrap.Modal.getInstance(document.getElementById('answerModal'));
			    answerModal.hide();

			    // 폼 제출
			    const form = this;
			    form.action = '${pageContext.request.contextPath}/product/question_answer_write';
			    form.method = 'POST';
			    form.submit();
			    window.scrollTo(0, document.getElementById('write-inquiry-btn').offsetTop);
			});
            
         	// 리뷰 정렬 select 엘리먼트의 change 이벤트 핸들러
			$('.form-select').on('change', function() {
			    var sortType = this.value.replace('review-sort-', '');
			    var prId = '${pr_id}';
			    var currentReviewPage = '${reviewPaging.btnCur}';
			    
			    window.location.href = '/product/pr_detail?pr_id=' + prId + 
			                          '&reviewPage=' + currentReviewPage +
			                          '&sortType=' + sortType + 
			                          '&tab=reviews#write-review-btn';
			});
         	
         	// 장바구니 버튼 클릭 이벤트
            $('.button-cart').click(async function() {
                // 로그인 체크
                if ('${user}' === '') {
                    if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
                        window.location.href = '${pageContext.request.contextPath}/auth/login';
                    }
                    return;
                }

                // 옵션이 선택되었는지 확인
                if ($('.selected-option').length === 0) {
                    alert('상품 옵션을 선택해주세요.');
                    return;
                }

                // 장바구니에 있는 상품과 옵션 검증
                let duplicateOptions = [];
                let successOptions = [];
                let hasError = false;

                for (const option of $('.selected-option').toArray()) {
                    const $option = $(option);
                    const optionName = $option.find('.product-option-name').text();
                    const quantity = parseInt($option.find('.quantity-input').val());
                    const priceText = $option.find('.product-option-price').text().replace(/[^0-9]/g, '');
                    const price = parseInt(priceText);

                    // 중복 체크를 위한 AJAX 요청
					try {
					    const checkResult = await $.ajax({
					        url: '${pageContext.request.contextPath}/product/check_cart_item',
					        type: 'POST',
					        contentType: 'application/json',
					        data: JSON.stringify({
					            pr_id: '${productDetail[0].pr_id}',
					            pr_opt_name: optionName
					        })
					    });
					
					    if (checkResult.exists) {
					        duplicateOptions.push(optionName);
					    } else {
					        successOptions.push({
					            pr_id: '${productDetail[0].pr_id}',
					            pr_name: '${productDetail[0].pr_name}',
					            pr_thumbnail: '${productDetail[0].pr_thumbnail}',
					            pr_opt_name: optionName,
					            pr_opt_price: price,
					            prsc_quantity: quantity
					        });
					    }
					} catch (error) {
					    hasError = true;
					}
                }

                if (hasError) {
                    alert('처리 중 오류가 발생했습니다.');
                    return;
                }

                if (duplicateOptions.length > 0) {
                    var optionText = duplicateOptions.map(function(opt) { return opt.trim(); }).join(', ');
                    alert('[' + optionText + '] 옵션은 이미 장바구니에 있습니다. 다른 옵션을 선택해주세요.');
                    return;
                }

			    // 장바구니에 추가
			    for (const item of successOptions) {
			        try {
			            await $.ajax({
			                url: '${pageContext.request.contextPath}/product/add_to_cart',
			                type: 'POST',
			                contentType: 'application/json',
			                data: JSON.stringify(item)
			            });
			        } catch (error) {
			            hasError = true;
			        }
			    }
			
			    if (hasError) {
			        alert('장바구니 추가 중 오류가 발생했습니다.');
			        return;
			    }
			
			    if (successOptions.length > 0) {
			        // alert 대신 모달 표시
			        new bootstrap.Modal(document.getElementById('cartSuccessModal')).show();
			    }
            });

            // 구매하기 버튼
			$('.button-buy').click(async function() {
			    // 로그인 체크
			    if ('${user}' === '') {
			        if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
			            window.location.href = '${pageContext.request.contextPath}/auth/login';
			        }
			        return;
			    }
			
			    // 옵션이 선택되었는지 확인
			    if ($('.selected-option').length === 0) {
			        alert('상품 옵션을 선택해주세요.');
			        return;
			    }
			
			    // 장바구니에 있는 상품과 옵션 검증
			    let duplicateOptions = [];
			    let successOptions = [];
			    let hasError = false;
			
			    for (const option of $('.selected-option').toArray()) {
			        const $option = $(option);
			        const optionName = $option.find('.product-option-name').text();
			        const quantity = parseInt($option.find('.quantity-input').val());
			        const priceText = $option.find('.product-option-price').text().replace(/[^0-9]/g, '');
			        const price = parseInt(priceText);
			
			        // 재고 체크
			        const optionText = $('.option-select option').filter(function() {
			            return $(this).data('option-name') === optionName;
			        }).text();
			        const stockMatch = optionText.match(/\((\d+)개\)/);
			        const stock = stockMatch ? parseInt(stockMatch[1]) : 0;
			
			        if (stock === 0 || quantity > stock) {
			            alert(`${optionName} 옵션의 재고가 부족합니다.`);
			            hasError = true;
			            break;
			        }
			
			        // 중복 체크를 위한 AJAX 요청
			        try {
			            const checkResult = await $.ajax({
			                url: '${pageContext.request.contextPath}/product/check_cart_item',
			                type: 'POST',
			                contentType: 'application/json',
			                data: JSON.stringify({
			                    pr_id: '${productDetail[0].pr_id}',
			                    pr_opt_name: optionName
			                })
			            });
			
			            if (checkResult.exists) {
			                duplicateOptions.push(optionName);
			            } else {
			                successOptions.push({
			                    pr_id: '${productDetail[0].pr_id}',
			                    pr_name: '${productDetail[0].pr_name}',
			                    pr_thumbnail: '${productDetail[0].pr_thumbnail}',
			                    pr_opt_name: optionName,
			                    pr_opt_price: price,
			                    prsc_quantity: quantity
			                });
			            }
			        } catch (error) {
			            hasError = true;
			        }
			    }
			
			    if (hasError) {
			        alert('처리 중 오류가 발생했습니다.');
			        return;
			    }
			
			    if (duplicateOptions.length > 0) {
			        var optionText = duplicateOptions.map(function(opt) { return opt.trim(); }).join(', ');
			        alert('[' + optionText + '] 옵션은 이미 장바구니에 있습니다.');
			        return;
			    }
			
			    // 장바구니에 추가 및 구매 페이지로 이동
			    const addToCartPromises = successOptions.map(item => 
			        $.ajax({
			            url: '${pageContext.request.contextPath}/product/add_to_cart',
			            type: 'POST',
			            contentType: 'application/json',
			            data: JSON.stringify(item)
			        })
			    );
			
			    try {
			        await Promise.all(addToCartPromises);
			        // 장바구니 페이지로 이동
			        window.location.href = '${pageContext.request.contextPath}/product/pr_cart';
			    } catch (error) {
			        alert('주문 처리 중 오류가 발생했습니다.');
			    }
			});
            
         	// 이미지 클릭 시 모달 표시 함수
            window.showImageModal = function(imageSrc) {
                $('#modalImage').attr('src', imageSrc);
                new bootstrap.Modal(document.getElementById('imageModal')).show();
            };

            // 모달이 닫힐 때 이미지 초기화
            $('#imageModal').on('hidden.bs.modal', function () {
                $('#modalImage').attr('src', '');
            });
            
        	 // 수량 증가 버튼 클릭 시
			$(document).on('click', '.quantity-btn.plus', function() {
			    let input = $(this).siblings('.quantity-input');
			    let currentValue = parseInt(input.val());
			    input.val(currentValue + 1);
			    updateTotalPrice();
			});

            // 수량 감소 버튼 클릭 시
			$(document).on('click', '.quantity-btn.minus', function() {
			    let input = $(this).siblings('.quantity-input');
			    let currentValue = parseInt(input.val());
			    if (currentValue > 1) {
			        input.val(currentValue - 1);
			        updateTotalPrice();
			    }
			});
            
            // 수량 수동 입력
            $(document).on('change', '.quantity-input', function() {
            	updateTotalPrice();
            });
            
         	// 파일 선택 시 미리보기 표시
            document.getElementById('review-image').addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('image-preview').src = e.target.result;
                        document.getElementById('preview-container').style.display = 'block';
                        document.querySelector('.review-upload-label').style.display = 'none';
                    }
                    reader.readAsDataURL(file);
                }
            });
         	
         	// 리뷰 삭제 버튼 클릭 이벤트
			$(document).on('click', '.review-delete', function() {
			    if (!confirm('정말 이 리뷰를 삭제하시겠습니까?')) {
			        return;
			    }
			
			    // 클릭된 삭제 버튼이 속한 리뷰 요소를 선택
			    var $reviewItem = $(this).closest('.review-item'); // 삭제 대상 리뷰 아이템
			    var reviewNo = $(this).data('review-no'); // 리뷰 번호 (data 속성에서 가져옴)
			
			    // AJAX 요청으로 서버에 삭제 요청
			    $.ajax({
			        url: '${pageContext.request.contextPath}/product/review_remove', // 서버 URL
			        type: 'POST',
			        data: { prc_no: reviewNo }, // 삭제할 리뷰 번호 전달
			        success: function(data) {
			            // 성공적으로 삭제된 경우
			            if (data === 'success') {
			                alert('리뷰가 삭제되었습니다.');
			                // DOM에서 해당 리뷰 요소 제거
			                $reviewItem.fadeOut(300, function() {
			                    $(this).remove(); // DOM에서 요소 완전히 제거
			                    updateReviewCount(); // 리뷰 개수 갱신
			                });
			            } else {
			                alert('리뷰 삭제에 실패했습니다.');
			            }
			        },
			        error: function(xhr) {
			            // 서버 응답 실패 처리
			            alert('삭제 요청 중 오류가 발생했습니다.');
			        }
			    });
			});

			// 리뷰 개수를 갱신하는 함수
			function updateReviewCount() {
			    var remainingReviews = $('.review-item').length; // 남아 있는 리뷰 개수
			    if (remainingReviews === 0) {
			        // 리뷰가 없으면 메시지 표시
			        $('.review-section').find('.review-header').after(
			            '<div class="text-center p-5">' +
			                '<p class="text-muted mb-0">작성된 리뷰가 없습니다.</p>' +
			            '</div>'
			        );
			    }
			    // 리뷰 개수 텍스트 업데이트
			    $('.product-ratings-count').text('(' + remainingReviews + '개의 고객 상품평)');
			}
        });
        
        function validateFile(input) {
            const file = input.files[0];
           
            // 확장자 검사
            const extension = file.name.split('.').pop().toLowerCase();
            const allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'svg'];
           
            if (!allowedExtensions.includes(extension)) {
                alert('jpg, jpeg, png, gif, svg 파일만 업로드 가능합니다.');
                input.value = '';  // 선택된 파일 초기화
                return false;
            }
            return true;
        }
        
		// 페이지 로드 시 스크롤 처리를 위한 이벤트 리스너
		window.addEventListener('load', function() {
		    const urlParams = new URLSearchParams(window.location.search);
		    const tabParam = urlParams.get('tab');
		
		    if (tabParam === 'reviews') {
		        // 리뷰 탭 활성화
		        const reviewTab = document.getElementById('reviewTab');
		        if (reviewTab) {
		            showTab(reviewTab);
		        }
		        
		        // 해시가 있는 경우 스크롤
		        if (window.location.hash) {
		            const element = document.querySelector(window.location.hash);
		            if (element) {
		                element.scrollIntoView({ behavior: 'instant' });
		                window.scrollBy(0, -100);  // 헤더 높이만큼 조정
		            }
		        }
		    } else if (tabParam === 'inquiries') {
		        // 기존 문의하기 탭 코드 유지
		        const inquiriesTab = document.getElementById('inquiriesTab');
		        if (inquiriesTab) {
		            showTab(inquiriesTab);
		            
		            if (window.location.hash) {
		                const element = document.querySelector(window.location.hash);
		                if (element) {
		                    element.scrollIntoView({ behavior: 'instant' });
		                    window.scrollBy(0, -100);
		                }
		            }
		        }
		    }
		});
        
     	// 전역으로 showTab 함수 정의
        function showTab(tab) {
            const tabs = document.querySelectorAll('.tab');
            const contents = document.querySelectorAll('.tab-content');

            tabs.forEach(t => t.classList.remove('active'));
            contents.forEach(c => c.classList.remove('active'));

            tab.classList.add('active');

            const contentId = tab.getAttribute('data-target');
            document.getElementById(contentId).classList.add('active');
        }    
     	
        // 미리보기 제거 함수
        function removePreview() {
            document.getElementById('review-image').value = '';
            document.getElementById('image-preview').src = '';
            document.getElementById('preview-container').style.display = 'none';
            document.querySelector('.review-upload-label').style.display = 'flex';
        }
        
        window.addEventListener('load', function () {
            const urlParams = new URLSearchParams(window.location.search);
            const scrollPosition = urlParams.get('scroll');
            const tabParam = urlParams.get('tab');

            if (tabParam === 'inquiries') {
                const inquiriesTab = document.getElementById('inquiriesTab');
                if (inquiriesTab) {
                    showTab(inquiriesTab);
                }
            }

            if (scrollPosition) {
                window.scrollTo(0, parseInt(scrollPosition, 10)); // 스크롤 위치 이동
            }
        });
    </script>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp"/>
	<%@ include file="./cartOrderWishCommon.jsp" %>
    <main>
        <div class="header">
            <h1 class="product-title">${productDetail[0].pr_name}</h1>
        </div>
       	<div class="navigation-bar">
		    <a href="/product/pr_list">전체보기</a>
		    <span class="navigation-separator">/</span>
		    <a href="/product/pr_list?category=${productDetail[0].pr_category}">${productDetail[0].pr_category}</a>
		    <span class="navigation-separator">/</span>
		    <span class="navigation-current">${productDetail[0].pr_name}</span>
		</div>
        <div class="product-content">
			<div class="product-thumbnail">
			    <c:if test="${productDetail[0].imageExists}">
			        <img class="thumbnail-item" src="${pageContext.request.contextPath}/product/getImage/${productDetail[0].pr_thumbnail}" alt="${productDetail[0].pr_thumbnail}">
			    </c:if>
			    <c:if test="${!productDetail[0].imageExists}">
			        <div class="no-image-text">이미지 없음</div>
			    </c:if>
			</div>
            <div class="product-details">
            	<div class="rating-container">
	                <div class="star-ratings">
	                    <div class="fill-ratings" style="width: ${averageRating}%;">
	                        <span>★★★★★</span>
	                    </div>
	                    <div class="empty-ratings">
	                        <span>★★★★★</span>
	                    </div>
	                </div>
	                <a href="#reviews" class="product-ratings-count">(${countRating}개의 고객 상품평)</a>
                </div>
                <div class="product-info">
                    <p>제품 요약 설명</p>
                    <p>${productDetail[0].pr_desc}</p>
                    <p>₩<fmt:formatNumber value="${productDetail[0].pr_price}" pattern="#,###"/></p>
                </div>
				<select class="option-select">
				    <option value="" disabled selected>- [필수] 옵션을 선택해 주세요 -</option>
				    <c:forEach var="options" items="${productDetail}">
				        <option value="${options.pr_name}" data-option-price="${options.pr_opt_price}" data-option-name="${options.pr_opt_name}">
				            ${options.pr_opt_name} (${options.pr_opt_stock}개) 
				            <c:if test="${options.pr_opt_price - options.pr_price != 0}">
				                (+<fmt:formatNumber value="${options.pr_opt_price - options.pr_price}" pattern="#,###"/>원)
				            </c:if>
				            <c:if test="${options.pr_opt_price - options.pr_price < 0 }">
				            	(-<fmt:formatNumber value="${options.pr_opt_price - options.pr_price}" pattern="#,###"/>원)
				            </c:if>
				            <c:if test="${options.pr_opt_stock == 0}">
				            	(품절)
				            </c:if>
				        </option>
				    </c:forEach>
				</select>
				<div class="warning-message">위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</div>
				<div class="selected-options-container"></div>
				<div class="total-price" style="display: none;">
				    <span>총 상품금액(수량)</span>
				    <span class="total-amount">₩0</span>
				</div>
                <div class="button-group">
                    <button class="button-cart">장바구니 담기</button>
                    <button class="button-buy">구매하기</button>
                </div>
            </div>
        </div>
        <div class="tabs">
            <div class="tab active" data-target="detail">상품상세</div>
            <div class="tab" id="reviewTab" data-target="reviews">상품평</div>
            <div class="tab" id="inquiriesTab" data-target="inquiries">상품문의</div>
        </div>
        <div class="tab-content active" id="detail">
            <div class="product-detail-image">${productDetail[0].pr_detail_desc}</div>
        </div>
        <div class="tab-content" id="reviews">
            <div class="review-section">
				<div class="review-header">
				    <button id="write-review-btn" class="write-review-btn">리뷰 작성하기</button>
				    <select class="form-select" style="width: auto;">
				        <option value="review-sort-latest" ${sortType == 'latest' ? 'selected' : ''}>최신순</option>
				        <option value="review-sort-rating" ${sortType == 'rating' ? 'selected' : ''}>평점순</option>
				        <option value="review-sort-my" ${sortType == 'my' ? 'selected' : ''}>나의 리뷰</option>
				    </select>
				</div>
                <c:choose>
			        <c:when test="${empty productReview}">
			            <div class="text-center p-5">
			                <p class="text-muted mb-0">
			                    <c:choose>
			                        <c:when test="${sortType == 'my' && empty user}">
			                            로그인 후 작성한 리뷰를 확인할 수 있습니다.
			                        </c:when>
			                        <c:otherwise>
			                            작성된 리뷰가 없습니다.
			                        </c:otherwise>
			                    </c:choose>
			                </p>
			            </div>
			        </c:when>    
			        <c:otherwise>          
		                <c:forEach var="rev" items="${productReview}">
			                <div class="review-item">
			                    <div class="review-user">
			                        <div class="user-info">${rev.us_id} 작성일 - ${rev.prc_start_date}</div>
				                    <div class="review-rating">
				                        <div class="review-fill-ratings" style="width: ${rev.prc_rating * 20}%;">
				                            <span>★★★★★</span>
				                        </div>
				                        <div class="review-empty-ratings">
				                            <span>★★★★★</span>
				                        </div>
				                    </div>
			                    </div>
								<c:if test="${rev.imageExists}">
								    <div class="review-image-container">
								        <img class="review-show-item" src="${pageContext.request.contextPath}/product/getImage/${rev.prc_image}" alt="${rev.prc_image}" style="cursor: pointer;" onclick="showImageModal(this.src)">
								    </div>
								</c:if>
			                    <div class="review-content">${rev.prc_desc}</div>
			                    <c:if test="${sessionScope.user.us_id eq 'admin'}">
			                   		<div class="review-modify">
					                    <button type="button" id="review-delete" class="review-delete" data-review-no="${rev.prc_no}">삭제</button>
				                    </div>
			                    </c:if>
			                </div>
		                </c:forEach>
	                </c:otherwise>  
                </c:choose>
				<div class="detail-pagination">
				    <c:if test="${reviewPaging.btnCur > 1}">
				        <div class="detail-page-item">
				            <a class="detail-page-link" href="/product/pr_detail?pr_id=${pr_id}&reviewPage=1&sortType=${sortType}&tab=reviews">＜＜</a>
				        </div>
				        <div class="detail-page-item">
				            <a class="detail-page-link" 
				               href="/product/pr_detail?pr_id=${pr_id}&reviewPage=${reviewPaging.btnCur-1}&sortType=${sortType}&tab=reviews">＜</a>
				        </div>
				    </c:if>
				    <c:forEach var="i" begin="${reviewPaging.btnFirst}" end="${reviewPaging.btnLast}" step="1">
				        <c:choose>
				            <c:when test="${reviewPaging.btnCur == i}">
				                <div class="detail-page-item active">
				                    <a class="detail-page-link">${i}</a>
				                </div>
				            </c:when>
				            <c:when test="${i == 0}">
				                <div class="detail-page-item active">
				                    <a class="detail-page-link">1</a>
				                </div>
				            </c:when>				            
				            <c:otherwise>
				                <div class="detail-page-item">
				                    <a class="detail-page-link" 
				                       href="/product/pr_detail?pr_id=${pr_id}&reviewPage=${i}&sortType=${sortType}&tab=reviews">${i}</a>
				                </div>
				            </c:otherwise>
				        </c:choose>
				    </c:forEach>
				    <c:if test="${reviewPaging.btnCur < reviewPaging.btnTotalCount}">
				        <div class="detail-page-item">
				            <a class="detail-page-link" 
				               href="/product/pr_detail?pr_id=${pr_id}&reviewPage=${reviewPaging.btnCur+1}&sortType=${sortType}&tab=reviews">＞</a>
				        </div>
				        <div class="detail-page-item">
				            <a class="detail-page-link" 
				               href="/product/pr_detail?pr_id=${pr_id}&reviewPage=${reviewPaging.btnTotalCount}&sortType=${sortType}&tab=reviews">＞＞</a>
				        </div>
				    </c:if>
				</div>               
            </div>
        </div>
		<div class="tab-content" id="inquiries">
		    <div class="inquiry-container">
		        <div class="inquiry-header">
   					<button id="write-inquiry-btn" class="inquiry-write-btn">문의하기</button>
		        </div>
		        <div class="inquiry-notice">
		            <ul>
		                <li>구매한 상품의 취소/반품은 주문내역에서 신청 가능합니다.</li>
		                <li>상품문의 및 후기게시판을 통해 취소나 환불 반품 등은 처리되지 않습니다.</li>
		                <li>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 고객센터 내 1:1 문의하기를 이용해주세요.</li>
		                <li>해당 상품 자체와 관련없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
		                <li>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
		            </ul>
		        </div>
				<c:set var="currentQNo" value="0"/>
				<c:forEach var="proQ" items="${productQuestion}">
				    <c:if test="${currentQNo ne proQ.prq_no}">
				        <div class="inquiry-list">
				            <div class="inquiry-item">
				                <div class="inquiry-info">
				                    <span class="badge inquiry-badge">질문</span>
				                    <span>작성일 - ${proQ.prq_date}</span>
				                    <c:if test="${sessionScope.user.us_id eq 'admin'}">
				                        <button type="button" class="inquiry-delete-btn" data-inquiry-no="${proQ.prq_no}">삭제</button>
				                        <button type="button" class="inquiry-answer-btn" data-inquiry-no="${proQ.prq_no}">답글달기</button>
				                    </c:if>
				                </div>
				                <div class="inquiry-content">${proQ.prq_desc}</div>
				            </div>
	            		</div>
				    </c:if>
				    <c:if test="${not empty proQ.prq_comments}">
				        <div class="answer-item">
				            <div class="answer-info">
				                <span class="badge answer-badge">답변</span>
				                <span class="answer-text">[관리자]</span>
				            </div>
				            <div class="answer-content">${proQ.prq_comments}</div>
				        </div>
				    </c:if>
				    <c:if test="${currentQNo ne proQ.prq_no}">
				        <c:set var="currentQNo" value="${proQ.prq_no}" />
				    </c:if>
				</c:forEach>
				<div class="detail-pagination">
				    <c:if test="${inquiryPaging.btnCur > 1}">
				        <div class="detail-page-item">
				            <a class="detail-page-link" href="/product/pr_detail?pr_id=${pr_id}&inquiryPage=1&reviewPage=${reviewPaging.btnCur}&sortType=${sortType}&tab=inquiries">＜＜</a>
				        </div>
				        <div class="detail-page-item">
				            <a class="detail-page-link" href="/product/pr_detail?pr_id=${pr_id}&inquiryPage=${inquiryPaging.btnCur-1}&reviewPage=${reviewPaging.btnCur}&sortType=${sortType}&tab=inquiries">＜</a>
				        </div>
				    </c:if>
				    <c:forEach var="i" begin="${inquiryPaging.btnFirst}" end="${inquiryPaging.btnLast}" step="1">
				        <c:choose>
				            <c:when test="${inquiryPaging.btnCur == i}">
				                <div class="detail-page-item active">
				                    <a class="detail-page-link">${i}</a>
				                </div>
				            </c:when>
				            <c:otherwise>
				                <div class="detail-page-item">
				                    <a class="detail-page-link" href="/product/pr_detail?pr_id=${pr_id}&inquiryPage=${i}&reviewPage=${reviewPaging.btnCur}&sortType=${sortType}&tab=inquiries">${i}</a>
				                </div>
				            </c:otherwise>
				        </c:choose>
				    </c:forEach>
				    <c:if test="${inquiryPaging.btnCur < inquiryPaging.btnTotalCount}">
				        <div class="detail-page-item">
				            <a class="detail-page-link" href="/product/pr_detail?pr_id=${pr_id}&inquiryPage=${inquiryPaging.btnCur+1}&reviewPage=${reviewPaging.btnCur}&sortType=${sortType}&tab=inquiries">＞</a>
				        </div>
				        <div class="detail-page-item">
				            <a class="detail-page-link" href="/product/pr_detail?pr_id=${pr_id}&inquiryPage=${inquiryPaging.btnTotalCount}&reviewPage=${reviewPaging.btnCur}&sortType=${sortType}&tab=inquiries">＞＞</a>
				        </div>
				    </c:if>
				</div>				
		    </div>
		</div>
		<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  			<form class="modal-dialog" id="reviewForm" method="post" action="/product/review_write" enctype="multipart/form-data">
	        <input type="hidden" name="pr_id" value="${productDetail[0].pr_id}">
	        <input type="hidden" name="pror_item_id" id="pror_item_id">
	        <input type="hidden" name="pror_master_id" id="pror_master_id">
	        <input type="hidden" name="pr_opt_id" id="pr_opt_id">
	        <input type="hidden" name="pr_opt_name" id="pr_opt_name">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="reviewModalLabel">리뷰 작성</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
						<div class="text-center mb-3">
						    <c:if test="${productDetail[0].imageExists}">
						        <img class="review-thumbnail-item" src="${pageContext.request.contextPath}/product/getImage/${productDetail[0].pr_thumbnail}" alt="${productDetail[0].pr_thumbnail}">
						    </c:if>
						    <c:if test="${!productDetail[0].imageExists}">
						        <div class="modal-no-image-text">이미지 없음</div>
						    </c:if>
						    <div>
						        <h6 class="mb-1">${productDetail[0].pr_name}</h6>
						        <input type="hidden" name="pr_id" value="${productDetail[0].pr_id}"> 
						    </div>
						</div>
						<div class="text-center mb-3">
						    <div class="d-flex flex-column align-items-center">
						        <div class="stars mb-2">
						            <span class="star fs-1" data-rating="1">★</span>
						            <span class="star fs-1" data-rating="2">★</span>
						            <span class="star fs-1" data-rating="3">★</span>
						            <span class="star fs-1" data-rating="4">★</span>
						            <span class="star fs-1" data-rating="5">★</span>
						        </div>
						        <input type="text" class="form-control review-star-rating" id="rating-display" value="5" readonly>
						        <input name="prc_rating" type="hidden" id="selected-rating" value="5">
						    </div>
						</div>
		                <div class="mb-3">
		                    <textarea name="prc_desc" class="form-control" rows="5" placeholder="리뷰를 작성해주세요."></textarea>
		                </div>
						<div class="mb-3">
						    <div class="review-upload-container">
						        <label for="review-image" class="review-upload-label">
						            <div class="upload-icon">
						                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
						                    <path d="M4 16L8.586 11.414C8.96106 11.0391 9.46967 10.8284 10 10.8284C10.5303 10.8284 11.0389 11.0391 11.414 11.414L16 16M14 14L15.586 12.414C15.9611 12.0391 16.4697 11.8284 17 11.8284C17.5303 11.8284 18.0389 12.0391 18.414 12.414L20 14M14 8H14.01M6 20H18C18.5304 20 19.0391 19.7893 19.4142 19.4142C19.7893 19.0391 20 18.5304 20 18V6C20 5.46957 19.7893 4.96086 19.4142 4.58579C19.0391 4.21071 18.5304 4 18 4H6C5.46957 4 4.96086 4.21071 4.58579 4.58579C4.21071 4.96086 4 5.46957 4 6V18C4 18.5304 4.21071 19.0391 4.58579 19.4142C4.96086 19.7893 5.46957 20 6 20Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
						                </svg>
						            </div>
						            <div class="upload-text">사진</div>
						        </label>
						        <input type="file" name="prc_image" id="review-image" accept="image/*" onchange="return validateFile(this)" hidden>
						        <div id="preview-container" class="preview-container" style="display: none;">
						            <img id="image-preview" src="" alt="Preview" class="preview-image">
						            <button type="button" class="remove-preview" onclick="removePreview()">×</button>
						        </div>
						    </div>
						</div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="submit" class="btn btn-dark">등록하기</button>
		            </div>	
		        </div>
		    </form>
	    </div>
		<div class="modal no-move" id="inquiryModal" tabindex="-1" aria-labelledby="inquiryModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		    <form class="modal-dialog" id="inquiryForm" method="post" action="${pageContext.request.contextPath}/product/question_write">
		        <input type="hidden" name="pr_id" value="${productDetail[0].pr_id}">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="inquiryModalLabel">상품 문의하기</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <div class="mb-3">
		                    <textarea name="prq_desc" class="form-control" rows="5" placeholder="문의하실 내용을 입력해주세요." required></textarea>
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="submit" class="btn btn-dark">등록하기</button>
		            </div>  
		        </div>
		    </form>
		</div>
		<div class="modal no-move" id="answerModal" tabindex="-1" aria-labelledby="answerModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		    <form class="modal-dialog" id="answerForm" method="post" action="/product/answer_write">
		    	<input type="hidden" name="pr_id" value="${productDetail[0].pr_id}">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="answerModalLabel">답변 작성</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <input type="hidden" name="prq_no" id="answer_prq_no">
		                <div class="mb-3">
		                    <textarea name="prq_comments" class="form-control" rows="5" placeholder="답변을 입력해주세요."></textarea>
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="submit" class="btn btn-dark">등록하기</button>
		            </div>  
		        </div>
		    </form>
		</div>
		<div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
		    <div class="modal-dialog modal-dialog-centered modal-lg">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body text-center">
		                <img id="modalImage" src="" alt="리뷰 이미지" style="max-width: 100%; height: auto;">
		            </div>
		        </div>
		    </div>
		</div>	
		<div class="modal fade no-move" id="cartSuccessModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static no-move" data-bs-keyboard="false">
		    <div class="modal-dialog modal-dialog-centered">
		        <div class="modal-content">
		            <div class="modal-header border-0">
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body cart-success-modal">
		                <img src="${pageContext.request.contextPath}/resources/upload/cart.jpg" alt="장바구니 추가 성공">
		                <h3>장바구니에 추가!</h3>
		                <div class="cart-buttons">
		                    <button type="button" class="cart-button continue-shopping" data-bs-dismiss="modal">계속 쇼핑하기</button>
		                    <button type="button" class="cart-button go-to-cart" onclick="location.href='${pageContext.request.contextPath}/product/pr_cart'">장바구니로 이동하기</button>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>			
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>