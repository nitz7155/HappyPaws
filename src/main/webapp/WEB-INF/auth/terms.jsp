<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>행복한 발자국 - HappyPaws - 이용약관</title>
	<%@include file="/head.jsp" %>
	<link rel="stylesheet" href="/resources/css/auth.css">
	<style>
		main {
			width: 800px;
			font-family: Arial, sans-serif;
			line-height: 1.6;
			margin: 0 auto;
			padding: 20px;
		}

		main h1 {
			text-align: center;
			font-size: 24px;
			margin-bottom: 20px;
		}

		main h2 {
			font-size: 20px;
			margin-top: 20px;
		}

		main p {
			margin: 10px 0;
		}

		main .btn-container {
			text-align: center;
			margin-top: 30px;
		}

		main .btn {
			padding: 10px 20px;
			background-color: #fe8;
			border: none;
			border-radius: 5px;
			cursor: pointer;
		}

		main .btn:hover {
			background-color: #FCD11E;
		}
	</style>
</head>
<body>
	<%@include file="/header.jsp" %>
	<main>
		<h1>이용 약관</h1>

		<h2>제1조 (목적)</h2>
		<p>본 약관은 팀 프로젝트의 일환으로 개발된 교육용 애플리케이션(이하 '서비스')의 이용과 관련하여, 서비스와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.</p>

		<h2>제2조 (서비스의 성격 및 목적)</h2>
		<p>본 서비스는 교육 목적으로 개발되었으며, 상업적 이익을 추구하지 않습니다. 서비스의 주요 목적은 사용자에게 학습 자료와 교육 콘텐츠를 제공하는 것입니다.</p>

		<h2>제3조 (카카오 로그인 연동)</h2>
		<p>1. 본 서비스는 사용자의 편의를 위해 카카오 로그인을 연동하여 제공합니다. 이를 통해 사용자는 별도의 회원가입 절차 없이 카카오 계정을 통해 로그인할 수 있습니다.</p>
		<p>2. 카카오 로그인을 통해 수집되는 정보는 다음과 같습니다:</p>
		<ul>
			<li>필수 정보: 카카오 계정의 고유 ID, 프로필 정보(닉네임, 프로필 사진 등)</li>
			<li>선택 정보: 이메일 주소, 생년월일 등 (사용자가 제공을 동의한 경우에 한함)</li>
		</ul>
		<p>3. 수집된 정보는 서비스 제공 및 사용자 식별을 위해서만 사용되며, 다른 목적으로는 활용되지 않습니다.</p>

		<h2>제4조 (개인정보의 보호 및 관리)</h2>
		<p>1. 서비스는 사용자의 개인정보를 관련 법령에 따라 안전하게 관리하며, 무단으로 제3자에게 제공하지 않습니다.</p>
		<p>2. 사용자는 언제든지 개인정보의 열람, 수정, 삭제를 요청할 수 있으며, 이에 대한 절차는 서비스 내 안내에 따릅니다.</p>

		<h2>제5조 (이용자의 의무)</h2>
		<p>1. 사용자는 본 약관 및 관련 법령을 준수하여야 하며, 서비스의 정상적인 운영을 방해하는 행위를 해서는 안 됩니다.</p>
		<p>2. 타인의 개인정보를 도용하거나 부정한 방법으로 서비스를 이용해서는 안 됩니다.</p>

		<h2>제6조 (서비스의 변경 및 중단)</h2>
		<p>1. 서비스는 교육 목적에 따라 콘텐츠 및 기능을 변경하거나 추가할 수 있습니다.</p>
		<p>2. 부득이한 사유로 서비스의 일부 또는 전부를 중단할 경우, 사전에 공지하며, 긴급한 상황에서는 사후에 공지할 수 있습니다.</p>

		<h2>제7조 (면책 조항)</h2>
		<p>1. 서비스는 교육 목적으로 제공되며, 제공되는 정보의 정확성, 완전성, 유용성 등에 대해 보장하지 않습니다.</p>
		<p>2. 사용자가 본 서비스를 이용함에 있어 발생하는 손해에 대해 서비스는 책임을 지지 않습니다.</p>

		<h2>제8조 (약관의 개정)</h2>
		<p>1. 본 약관은 필요에 따라 개정될 수 있으며, 개정 시 서비스 내 공지사항을 통해 사전에 안내합니다.</p>
		<p>2. 사용자는 개정된 약관에 동의하지 않을 권리가 있으며, 동의하지 않을 경우 서비스 이용을 중단할 수 있습니다.</p>

		<h2>부칙</h2>
		<p>본 약관은 2024년 11월 7일부터 적용됩니다.</p>

		<div class="btn-container">
			<button class="btn" onclick="window.history.back();">돌아가기</button>
		</div>
	</main>
	<%@include file="/footer.jsp" %>
</body>
</html>