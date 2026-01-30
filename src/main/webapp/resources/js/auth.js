// 아이디 중복 검사
let auth_id = false;
function id_duplicate_check() {
	if (!/^[a-zA-Z0-9]{6,20}$/.test(document.querySelector("#us_id").value)) {
		alert("아이디가 유효하지 않습니다. 6~20글자로 입력해주세요.");
		return false;
	}

	fetch('/auth/id_check', {
		method: "POST",
		headers: { 'Content-Type': 'text/plain; charset=UTF-8' },
		body: document.querySelector("#us_id").value
	}).then(response => {
		if (!response.ok) {
			throw new Error('네트워크 응답에 문제가 있습니다.');
		}
		return response.text();
	}).then(data => {
		if (data === "true") {
			alert("사용할 수 있는 아이디입니다.");
			auth_id = true;
			return true;
		} else {
			alert("이 아이디는 이미 사용중입니다.");
			return false;
		}
	}).catch(error => {
		console.error('닉네임 중복확인 검사 도중 에러가 발생하였습니다.', error);
		return false;
	});
}
document.querySelector('#us_id+input[type=button]')?.addEventListener('click', id_duplicate_check);
document.querySelector("#us_id")?.addEventListener('change', () => auth_id = false);

// 닉네임 중복 검사
let auth_nick = false;
function nick_duplicate_check() {
	if (document.querySelector("#us_nick").value == "") {
		alert("닉네임을 입력해주세요.");
		return false;
	}

	if (document.querySelector("#us_nick").value.length > 8) {
		alert("8글자 이내로 입력해주세요.");
		return false;
	}
	
	fetch('/auth/nick_check', {
		method: "POST",
		headers: { 'Content-Type': 'text/plain; charset=UTF-8' },
		body: document.querySelector("#us_nick").value
	}).then(response => {
		if (!response.ok) {
			throw new Error('네트워크 응답에 문제가 있습니다.');
		}
		return response.text();
	}).then(data => {
		if (data === "true") {
			alert("사용할 수 있는 닉네임입니다.");
			auth_nick = true;
			return true;
		} else {
			alert("이 닉네임은 이미 사용중입니다.");
			return false;
		}
	}).catch(error => {
		console.error('닉네임 중복확인 검사 도중 에러가 발생하였습니다.', error);
		return false;
	});
}
document.querySelector('#us_nick+input[type=button]')?.addEventListener('click', nick_duplicate_check);
document.querySelector("#us_nick")?.addEventListener('change', () => auth_nick = false);

// 전화번호 인증
let auth_phone = false;
document.querySelector('#us_phone+input[type=button]')?.addEventListener('click', () => {
	if (!switchPhoneFormat()) {
		alert("전화번호 형식을 지켜주세요.");
		return;
	}

	$.ajax({
		url: "/auth/authPhone",
		type: "GET",
		data: { 'us_phone': $('#us_phone').val() },
		success: response => {
			if (response) {
				$('#us_phone_auth_div').css('display', 'flex');
				startTimer(duration, document.getElementById('timer'));
			}
		},
		error: () => alert('인증번호 전송에 실패하였습니다.')
	});
});

// 인증번호 입력 시간
const duration = 60 * 5;
function startTimer(duration, display) {
    let timer = duration, minutes, seconds;
    const interval = setInterval(function () {
        minutes = Math.floor(timer / 60);
        seconds = timer % 60;

        minutes = minutes < 10 ? '0' + minutes : minutes;
        seconds = seconds < 10 ? '0' + seconds : seconds;

        display.textContent = minutes + ":" + seconds;

        if (--timer < 0) {
            clearInterval(interval);
			display.textContent = "00:00";
			$('#us_phone_auth_div').css('display', 'none');
        }
    }, 1000);
}

// 인증번호 확인
document.querySelector('#us_phone_auth_code~input[type=button]')?.addEventListener('click', () => {
	let us_phone_auth_code = $('#us_phone_auth_code').val();
	if (us_phone_auth_code.length != 6) {
		alert("6자리를 입력해주세요.");
		return;
	}

	$.ajax({
		url: "/auth/authPhone",
		type: "POST",
		data: {
			'us_phone': $('#us_phone').val(),
			'us_phone_auth_code': us_phone_auth_code
		},
		success: response => {
			if (response) {
				auth_phone = true;
				$('#us_phone_auth_div').css('display', 'none');
				document.querySelector("#us_phone").readOnly = true;
			}
		},
		error: () => alert('인증번호 확인에 실패하였습니다.')
	});
});
document.querySelector("#us_phone")?.addEventListener("blur", switchPhoneFormat);

// 전화번호 형식 변경 및 유효성 검사
function switchPhoneFormat() {
	let phoneNum = document.querySelector("#us_phone").value.split("-").join("");
	
	if (phoneNum.length == 11) {
		phoneNum = phoneNum.substr(0, 3) + "-" + phoneNum.substr(3, 4) + "-" + phoneNum.substr(7, 4);
		if (/^010-\d{4}-\d{4}$/.test(phoneNum)) {
			document.querySelector("#us_phone").value = phoneNum;
			return true;
		}
	}

	return false;
}

// onsubmit
document.loginForm?.addEventListener('submit', event => {
	let isValidity = true;

	if (document.loginForm.us_id.value.trim() === '') {
		showInputError(document.loginForm.us_id);
		isValidity = false;
	}

	if (document.loginForm.us_password.value.trim() === '') {
		showInputError(document.loginForm.us_password);
		isValidity = false;
	}

	if (!isValidity) {
		event.preventDefault();
	}
});

document.joinForm?.addEventListener('submit', event => {
	let isValidity = true;

	if (!auth_id) {
		showInputError(document.joinForm.us_id);
		isValidity = false;
	}

	if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,64}$/.test(document.joinForm.us_password.value)) {
		showInputError(document.joinForm.us_password);
		isValidity = false;
	}

	if (document.joinForm.us_password.value != document.joinForm.us_check_password.value) {
		showInputError(document.joinForm.us_check_password);
		isValidity = false;
	}

	if (document.joinForm.us_name.value.trim() === "") {
		showInputError(document.joinForm.us_name);
		isValidity = false;
	}

	if (!auth_nick) {
		showInputError(document.joinForm.us_nick);
		isValidity = false;
	}

	if (!auth_phone) {
		showInputError(document.joinForm.us_phone);
		isValidity = false;
	}

	if (!isValidity) {
		event.preventDefault();
	}
});

document.findIdForm?.addEventListener('submit', event => {
	let isValidity = true;

	if (document.findIdForm.us_name.value.trim() === "") {
		showInputError(document.findIdForm.us_name);
		isValidity = false;
	}

	if (!auth_phone) {
		showInputError(document.findIdForm.us_phone);
		isValidity = false;
	}

	if (!isValidity) {
		event.preventDefault();
	}
});

document.querySelector('input[value="비밀번호 찾기"]')?.addEventListener('click', async () => {
	let isValidity = true;

	if (document.findPwForm.us_id.value.trim() === "") {
		showInputError(document.findPwForm.us_id);
		isValidity = false;
	}

	if (document.findPwForm.us_name.value.trim() === "") {
		showInputError(document.findPwForm.us_name);
		isValidity = false;
	}

	if (!auth_phone) {
		showInputError(document.findPwForm.us_phone);
		isValidity = false;
	}
	
	if (!isValidity) {
		return;
	}

	try {
		const response = await fetch('/auth/check_user', {
			method: 'POST',
			body: new FormData(document.findPwForm)
		});

		if (!response.ok) {
			throw new Error('Error: ${response.status}');
		}

		const isUserData = await response.text();

		if (isUserData == 'true') {
			document.querySelector("#user_authentication").style.display = 'none';
			document.querySelector("#password_change").style.display = 'block';
			document.findPwForm.us_password.focus();
		}
	} catch (error) {
		alert('사용자 정보를 확인하지 못했습니다.');
	}
});

document.findPwForm?.addEventListener('submit', event => {
	let isValidity = true;

	if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/.test(document.findPwForm.us_password.value)) {
		showInputError(document.findPwForm.us_password);
		isValidity = false;
	}

	if (document.findPwForm.us_password.value != document.findPwForm.us_check_password.value) {
		showInputError(document.findPwForm.us_check_password);
		isValidity = false;
	}

	if (!isValidity) {
		event.preventDefault();
	}
});

document.change_nick_form?.addEventListener('submit', event => {
	if (!auth_nick) {
		showInputError(document.change_nick_form.us_nick);
		event.preventDefault();
	}
});


function showInputError(element) {
	element.classList.add('shake', 'error-highlight');

	setTimeout(function() {
		element.classList.remove('shake');
	}, 300);

	function removeShakeHandler() {
		element.classList.remove('error-highlight');
		element.removeEventListener('input', removeShakeHandler);
	}
	element.addEventListener('input', removeShakeHandler);
}