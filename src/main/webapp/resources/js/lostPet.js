$(document).ready(function() {
    // 이벤트 핸들러 설정 함수
    function setupEventHandlers() {
        // 글 수정
        $("#lpMod").click(function() {
            document.fm.action = "/MIA/updateLostPet";
            document.fm.method = "get";
            document.fm.submit();
        });

        // 글 삭제
        $("#lpDel").click(function() {
            if (confirm("정말로 삭제하시겠습니까?")) {
                let s = document.fm.lp_seq.value;
                location.href = "/MIA/deleteLostPet?lp_seq=" + s;
            }
        });

        // 글 목록 보기
        $("#lpList").click(function() {
            document.hideFrm.action = "/MIA/getLostPetList";
            document.hideFrm.method = "post";
            document.hideFrm.submit();
        });

        // 댓글 수정 시작
        $(document).on('click', '#open', function() {
            let lpCommentDiv = $(this).closest(".comment");
            lpCommentDiv.find(".lpcMod1").hide();
            lpCommentDiv.find(".lpcMod2").show();
            lpCommentDiv.find(".lpcMod3").hide();
        });

        // 댓글 수정 취소
        $(document).on('click', '#close', function() {
            let lpCommentDiv = $(this).closest(".comment");
            lpCommentDiv.find(".lpcMod1").show();
            lpCommentDiv.find(".lpcMod2").hide();
            lpCommentDiv.find(".lpcMod3").show();
        });

        // 글 작성 페이지 이동
        $(".lpIns").click(function() {
            location.href = "/MIA/insertLostPet";
        });
    }

    // 이벤트 핸들러 초기화 호출
    setupEventHandlers();

    // 글 상세 보기
    window.selLp = function(val, val2, val3, val4, nowpage) {
        location.href = "/MIA/getLostPet?lp_seq=" + val + '&searchCondition=' + val2 + '&searchKeyword=' + val3 + '&category=' + val4 + '&nowPage=' + nowpage;
    };

    // 파일 업로드 시 이미지 미리보기
    const fileDOM = document.querySelector('#file2');
    const preview = document.querySelector('.lost-pet-image');

    if (fileDOM) {
        fileDOM.addEventListener('change', () => {
            const reader = new FileReader();
            reader.onload = ({ target }) => {
                preview.src = target.result;
            };
            if (fileDOM.files[0]) {
                reader.readAsDataURL(fileDOM.files[0]);
            }
        });
    }

    // 롤백 버튼 이벤트
    const rollbackBtn = document.getElementById('rollback');
    if (rollbackBtn) {
        rollbackBtn.addEventListener('click', function() {
            history.back();
        });
    }
});

// 전화번호 형식 설정
function formatPhoneNumber(input) {
    let value = input.value.replace(/\D/g, '');

    if (value.length > 3 && value.length <= 6) {
        value = value.replace(/(\d{3})(\d{0,4})/, '$1-$2');
    } else if (value.length > 6) {
        value = value.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3');
    }

    input.value = value;
}
