<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@include file="./head.jsp"%>
	<link rel="stylesheet" href="./resources/css/index.css">
	<style>
		tbody img {
			background-color: lightgray;
		}
	</style>
</head>
<body>
	<%@include file="./header.jsp"%>
	<main>
		<img src="/resources/images/HappyPawsLogo.png" alt="logo">
		<div id="hero-img" style="background-color: transparent; aspect-ratio: auto;">
			<img src="/resources/images/error-page.png" alt="메인 이미지" style="width: 100%;">
		</div>
		<div>
			<i class="fas fa-bullhorn"></i>
			<section id="notice-section">
				<a href=""><p>긴급 공지: 시스템 유지보수 안내</p></a>
			</section>
		</div>
		<div id="contents-bundle">
			<section id="left-contents" class="contents">
				<article id="community-article">
					<a href="/board/cmty_list"><p>커뮤니티</p></a>
					<section>
						<table>
							<colgroup>
								<col>
								<col>
							</colgroup>
							<tbody>
								<tr>
									<td>후기</td>
									<td>술이 식기 전에</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>Lorem</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>뿌리 깊은 나무는</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>나랏말싸미 듕귁에 달아</td>
								</tr>
								<tr>
									<td>후기</td>
									<td>이 몸이 죽고 죽어 일백번 고쳐죽어</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>무궁화 삼천리 화려강산</td>
								</tr>
								<tr>
									<td>후기</td>
									<td>괴로우나</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>가을 하늘</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>남산 위의 소나무</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>동해물과 백두산</td>
								</tr>
							</tbody>
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
							<tbody>
								<tr>
									<td><img></td>
									<td>개밥</td>
								</tr>
								<tr>
									<td><img></td>
									<td>개껌</td>
								</tr>
								<tr>
									<td><img></td>
									<td>고양이 츄르</td>
								</tr>
								<tr>
									<td><img></td>
									<td>해바라기씨</td>
								</tr>
								<tr>
									<td><img></td>
									<td>케이스</td>
								</tr>
							</tbody>
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
							<tbody>
								<tr>
									<td>강아지</td>
									<td><img></td>
									<td>강아지를 찾아주세요</td>
									<td>가을 하늘</td>
								</tr>
								<tr>
									<td>고양이</td>
									<td><img></td>
									<td>고양이를 찾아주세요.</td>
									<td>남산 위의 소나무</td>
								</tr>
								<tr>
									<td>기타</td>
									<td><img></td>
									<td>호랑이를 찾아주세요</td>
									<td>동해물과 백두산</td>
								</tr>
							</tbody>
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
							<tbody>
								<tr>
									<td>강아지</td>
									<td><img></td>
									<td>귀여운 강아지</td>
									<td>가을 하늘</td>
								</tr>
								<tr>
									<td>고양이</td>
									<td><img></td>
									<td>새끼 고양이</td>
									<td>남산 위의 소나무</td>
								</tr>
								<tr>
									<td>기타</td>
									<td><img></td>
									<td>새끼 호랑이</td>
									<td>동해물과 백두산</td>
								</tr>
							</tbody>
						</table>
					</section>
				</article>
			</section>
		</div>
	</main>
	<%@include file="./footer.jsp" %>
</body>
</html>