<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>행복한 발자국 - 회원가입</title>
	<%@include file="/head.jsp"%>
	<link rel="stylesheet" href="/resources/css/auth.css">
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
	<script>
		// 주소 받아오기 - 경숙님, 감사합니다.
		function openZipcodeSearch() {
			new daum.Postcode({
				oncomplete: function(data) {
					var fullAddr = data.address;
					var extraAddr = '';

					if (data.addressType === 'R') {
						if (data.bname !== '') extraAddr += data.bname;
						if (data.buildingName !== '') extraAddr += (extraAddr !== '' ? ', ' : '') + data.buildingName;
						fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
					}

					// 입력 필드에 값 설정
					document.getElementById('postcode').value = data.zonecode;
					document.getElementById('us_address').value = fullAddr;
				}
			}).open();
		}
	</script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<main>
		<div class="auth-form">
			<h3>회원가입</h3>
			<form action="/auth/join" method="post" name="joinForm">
				<div>
					<input type="text" name="us_id" id="us_id" placeholder="아이디 입력" autofocus>
					<input type="button" value="중복 확인">
				</div>
				<p class="error-message">아이디 중복 확인을 해주세요.</p>

				<div><input type="password" name="us_password" id="us_password" placeholder="비밀번호 입력"></div>
				<p class="error-message">비밀번호가 유효하지 않습니다.<br>대·소문자, 숫자, 특수문자를 1개 이상씩 사용하여 8~20자로 작성해주세요.</p>
				<div><input type="password" name="us_check_password" id="us_check_password" placeholder="비밀번호 확인"></div>
				<p class="error-message">비밀번호가 서로 다릅니다.</p>

				<div><input type="text" name="us_name" id="us_name" placeholder="이름 입력"></div>
				<p class="error-message">이름을 입력해주세요.</p>

				<div>
					<input type="text" name="us_nick" id="us_nick" placeholder="닉네임 입력">
					<input type="button" value="중복 확인">
				</div>
				<p class="error-message">닉네임 중복 확인을 해주세요.</p>

				<div><input type="email" name="us_email" id="us_email" placeholder="이메일 입력"></div>
				<p class="error-message">이메일 형식을 지켜주세요.</p>

				<div>
					<input type="text" name="us_phone" id="us_phone" placeholder="전화번호 입력">
					<input type="button" value="전화번호 인증">
				</div>
				<p class="error-message">전화번호 인증을 해주세요.</p>
				<div id="us_phone_auth_div" style="display: none;">
					<input type="text" name="us_phone_auth_code" id="us_phone_auth_code" placeholder="인증번호 입력" maxlength="6">
					<span class="timer" id="timer">05:00</span>
					<input type="button" value="인증번호 확인">
				</div>

				<div>
					<input type="text" name="postcode" id="postcode" placeholder="우편번호" style="width: 40%; flex: none;" readonly>
					<input type="button" value="우편번호 찾기" onclick="openZipcodeSearch()">
				</div>
				<div><input type="text" name="us_address" id="us_address" placeholder="주소 입력" readonly></div>
				<div><input type="text" name="us_address_detail" id="us_address_detail" placeholder="상세 주소 입력"></div>

				<div><input type="submit" value="회원가입하기"></div>
			</form>
		</div>
	</main>
	<%@include file="/footer.jsp" %>
	<script src="/resources/js/auth.js"></script>
</body>
</html>