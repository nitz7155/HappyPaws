$(document).ready(function () {
    // 이벤트 핸들러 설정 함수
    function setupEventHandlers() {
        // 글 수정 함수
        function fpMod() {
            document.fm.action = "/MIA/updateFindPet";
            document.fm.method = "get";
            document.fm.submit();
        }

        $("#fpModCheck").click(function () {
            console.log('실행');
            document.fm.action = "/MIA/updateFindPetCheck";
            document.fm.method = "get";
            document.fm.submit();
       });

        // 글 삭제 함수
        function fpDel() {
            if (confirm("정말로 삭제하시겠습니까?")) {
                let s = document.fm.fp_seq.value;
                location.href = "/MIA/deleteFindPet?fp_seq=" + s;
            }
        }

       $("#fpDelCheck").click(function () {
            console.log('실행');
            let s = document.fm.fp_seq.value;
            location.href = "/MIA/deleteFindPetCheck?fp_seq=" + s;
        });

        // 기존의 수정, 삭제 버튼은 로그인 된 상태에서 바로 동작
        $("#fpMod").click(fpMod);
        $("#fpDel").click(fpDel);

        // 글 목록 보기
        $("#fpList").click(function () {
            document.hideFrm.action = "/MIA/getFindPetList";
            document.hideFrm.method = "post";
            document.hideFrm.submit();
        });

        // 댓글 수정 시작
        $(document).on('click', '#open', function () {
            let fpCommentDiv = $(this).closest(".comment");
            fpCommentDiv.find(".fpcMod1").hide();
            fpCommentDiv.find(".fpcMod2").show();
            fpCommentDiv.find(".fpcMod3").hide();
        });

        // 댓글 수정 취소
        $(document).on('click', '#close', function () {
            let fpCommentDiv = $(this).closest(".comment");
            fpCommentDiv.find(".fpcMod1").show();
            fpCommentDiv.find(".fpcMod2").hide();
            fpCommentDiv.find(".fpcMod3").show();
            fpCommentDiv.find(".fpcMod4").show();
        });

        // 글 작성 페이지 이동
        $(".fpIns").click(function () {
            location.href = "/MIA/insertFindPet";
        });
    }

    setupEventHandlers();

    // 글 상세 보기
    window.selFp = function (val, val2, val3, val4, nowpage) {
        location.href = "/MIA/getFindPet?fp_seq=" + val + '&searchCondition=' + val2 + '&searchKeyword=' + val3 + '&category=' + val4 + '&nowPage=' + nowpage;
    };

    // 파일 업로드 시 이미지 미리보기
    const fileDOM = document.querySelector('#file2');
    const preview = document.querySelector('.find-pet-image');

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
        rollbackBtn.addEventListener('click', function () {
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
