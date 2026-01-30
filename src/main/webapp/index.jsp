<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@include file="./head.jsp"%>
	<link rel="stylesheet" href="./resources/css/index.css">
</head>
<body>
	<%@include file="./header.jsp"%>
	<main>
		<img src="/resources/images/HappyPawsLogo.png" alt="logo">
		<div id="hero-img">
			<span>안녕하세요, 행복한 발자국입니다.</span>
			<img src="/resources/images/index.png" alt="메인 이미지">
		</div>
		<div>
			<i class="fas fa-bullhorn"></i>
			<section id="notice-section"><!-- Contents Area --></section>
		</div>
		<div id="contents-bundle">
			<section id="left-contents" class="contents">
				<article id="community-article">
					<a href="/board/cmty_list?cmty_category=all"><p>커뮤니티</p></a>
					<section>
						<table>
							<colgroup>
								<col>
								<col>
							</colgroup>
							<tbody><!-- Contents Area --></tbody>
						</table>
					</section>
				</article>
				<article id="shop-article">
					<a href="/pr_list"><p>반려용품</p></a>
					<section>
						<table>
							<colgroup>
								<col>
								<col>
							</colgroup>
							<tbody><!-- Contents Area --></tbody>
						</table>
					</section>
				</article>
			</section>
			<section id="right-contents" class="contents">
				<article id="lostPet-article">
					<a href="MIA/getLostPetList"><p>아이를 찾아주세요</p></a>
					<section>
						<table>
							<colgroup>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<tbody><!-- Contents Area --></tbody>
						</table>
					</section>
				</article>
				<article id="newFamily-article">
					<a href="MIA/getNewFamilyList"><p>새로운 가족을 찾아요</p></a>
					<section>
						<table>
							<colgroup>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<tbody><!-- Contents Area --></tbody>
						</table>
					</section>
				</article>
			</section>
		</div>
	</main>
	<%@include file="./footer.jsp" %>
	<script src="./resources/js/index.js"></script>
</body>
</html>