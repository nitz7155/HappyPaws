$(document).ready(function() {
    function setupEventHandlers() {
        // 글 수정
        $("#nfMod").click(function() {
            document.fm.action = "/MIA/updateNewFamily";
            document.fm.method = "get";
            document.fm.submit();
        });

        // 글 삭제
        $("#nfDel").click(function() {
            if (confirm("정말로 삭제하시겠습니까?")) {
                let s = document.fm.nf_seq.value;
                location.href = "/MIA/deleteNewFamily?nf_seq=" + s;
            }
        });

        // 글 목록 보기
        $("#nfList").click(function() {
            document.hideFrm.action = "/MIA/getNewFamilyList";
            document.hideFrm.method = "post";
            document.hideFrm.submit();
        });

        // 댓글 수정 시작
        $(document).on('click', '#open', function() {
            let nfCommentDiv = $(this).closest(".comment");
            nfCommentDiv.find(".nfcMod1").hide();
            nfCommentDiv.find(".nfcMod2").show();
            nfCommentDiv.find(".nfcMod3").hide();
        });
        

        // 댓글 수정 취소
        $(document).on('click', '#close', function() {
            let nfCommentDiv = $(this).closest(".comment");
            nfCommentDiv.find(".nfcMod1").show();
            nfCommentDiv.find(".nfcMod2").hide();
            nfCommentDiv.find(".nfcMod3").show();
        });

        // 무료분양 등록 버튼
        $(".nfIns").click(function() {
            location.href = "/MIA/insertNewFamily";
        });

    }

    setupEventHandlers();

    // 무료분양 글 보기
    window.selNf = function(val, val2, val3, val4, nowpage) {
        location.href = "/MIA/getNewFamily?nf_seq=" + val + '&searchCondition=' + val2 + '&searchKeyword=' + val3 + '&category=' + val4 + '&nowPage=' + nowpage;
    };

    // 성별 표시 설정
    if ($("#pet_gender").text() == 'M') {
        $("#pet_gender").text("남");
    } else {
        $("#pet_gender").text("여");
    }

    // 파일 업로드 시 이미지 미리보기
    const fileDOM = document.querySelector('#file2');
    const preview = document.querySelector('.new-family-image');

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
