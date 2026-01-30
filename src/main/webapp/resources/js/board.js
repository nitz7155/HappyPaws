$(document).ready(function(){ 

	var BlockEmbed = Quill.import('blots/block/embed');

	class CustomImageBlot extends BlockEmbed {
		static create(value) {
			let node = super.create();
			node.setAttribute('src', value.src);
			if (value.style) {
				node.setAttribute('style', value.style); // 인라인 스타일 추가
			}
			return node;
		}
	
		static value(node) {
			return {
				src: node.getAttribute('src'),
				style: node.getAttribute('style') // 인라인 스타일 반환
			};
		}
	}
	
	CustomImageBlot.blotName = 'customImage';
	CustomImageBlot.tagName = 'img';
	Quill.register(CustomImageBlot);
	
	function insertImageWithStyle(quill, imageUrl, width) {
		var range = quill.getSelection();
		var style = `width: ${width}px; height: auto;`;
		quill.insertEmbed(range.index, 'customImage', { src: imageUrl, style: style });
	}


	//Quill 라이브러리
	if ($('#editor').length) {
		var quill = new Quill('#editor', {
			theme: 'snow',
			modules: {
			  toolbar: {
				container: [
				  [{ 'header': [1, 2, false] }],
				  ['bold', 'italic', 'underline'],
				  ['image'],
				  [{ 'align': [] }],
				  [{ list: 'ordered' }],
				],
				handlers: {
					image: imageHandler  // 커스텀 이미지 핸들러
				}
			  }
			}
		  });
	}
	
	 // 이미지 핸들러 함수
	 function imageHandler() {
		var input = document.createElement('input');
		input.setAttribute('type', 'file');
		input.setAttribute('accept', 'image/*');
		input.click();
  
		input.onchange = function () {
		  var file = input.files[0];
		  var formData = new FormData();
		  formData.append('file', file);
  
		  // 서버로 이미지 업로드
		  $.ajax({
			url: '/upload',  // 이미지 업로드 서버 URL
			type: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function (data) {
				// 서버로부터 이미지 URL을 받음
			  	var imageUrl = data.url;
  
			  	// Quill 에디터에 이미지 삽입
			  	var range = quill.getSelection();
			  	quill.insertEmbed(range.index, 'image', imageUrl);

				// 삽입된 이미지의 최대 width 설정
				setTimeout(function () {
					$('#editor img').each(function () {
						if ($(this).attr('src') === imageUrl) {
							$(this).css('max-width', '450px');
							$(this).css('width', '100%'); // 초기 width 설정
						}
					});
				}, 100);
			},
			error: function (error) {
			  console.error('Image upload failed:', error);
			}
		  });
		};
	  }
	  
	// Quill 에디터 내의 이미지 클릭 이벤트 바인딩
	$('#editor').on('click', 'img', function () {
		var $img = $(this);
		$('.resize-handle').remove();
		$('.align-container').remove();
	
		// 리사이즈 핸들 생성
		var $handle = $('<div class="resize-handle"></div>');
		$('body').append($handle);
		$handle.css({
			position: 'absolute',
			width: '10px',
			height: '10px',
			background: 'red',
			cursor: 'nwse-resize',
			zIndex: 1000
		});
	
		function updateHandlePosition() {
			var imgOffset = $img.offset();
			$handle.css({
				left: (imgOffset.left + $img.outerWidth() - 5) + 'px',
				top: (imgOffset.top + $img.outerHeight() - 5) + 'px'
			});
		}
	
		// 초기 핸들 위치 설정
		updateHandlePosition();
	
		$handle.on('mousedown touchstart', function (e) {
			e.preventDefault();
			var startX = e.pageX || e.originalEvent.touches[0].pageX;
	
			$(document).on('mousemove.resize touchmove.resize', function (event) {
				var currentX = event.pageX || event.originalEvent.touches[0].pageX;
				var newWidth = Math.min(450, Math.max(50, currentX - $img.offset().left)); // 최대 너비 450px 
	
				// 이미지가 오른쪽에 있을 때 음수나 비정상적인 너비를 방지
				if (newWidth > 50) {
					$img.css({
						width: newWidth + 'px',
						height: 'auto' // 비율 유지
					});
	
					// 리사이즈 중 핸들 위치 업데이트
					updateHandlePosition();
				}
			});
	
			$(document).on('mouseup.resize touchend.resize', function () {
				$(document).off('mousemove.resize touchmove.resize mouseup.resize touchend.resize');
			});
		});
	
		// 이미지 클릭 시 정렬 옵션 추가
		var $alignContainer = $('<div class="align-container"></div>');
		var alignButtons = ['left', 'center'].map(function (align) { // 'right' 정렬 제거
			var $button = $('<button></button>').text(align);
			$button.on('click', function () {
				$img.css({
					display: 'block',
					marginLeft: align === 'center' ? 'auto' : '0',
					marginRight: align === 'center' ? 'auto' : '0',
					textAlign: align
				});
				updateAlignContainerPosition(); // 정렬 후 위치 업데이트
				updateHandlePosition(); // 정렬 후 핸들 위치 업데이트
			});
			return $button;
		});
		$alignContainer.append(alignButtons);
		$('body').append($alignContainer);
	
		function updateAlignContainerPosition() {
			var imgOffset = $img.offset();
			$alignContainer.css({
				position: 'absolute',
				top: imgOffset.top - 30 + 'px',
				left: imgOffset.left + 'px',
				zIndex: 1000
			});
		}
	
		// 초기 위치 설정
		updateAlignContainerPosition();
	
		// 이미지 리사이즈 핸들러 설정
		$('.resize-handle').on('mousedown touchstart', function (e) {
			e.preventDefault();
	
			$(document).on('mousemove.resize touchmove.resize', function () {
				updateAlignContainerPosition(); // 이미지 크기 변경 후 위치 업데이트
				
			});
	
			$(document).on('mouseup.resize touchend.resize', function () {
				$(document).off('mousemove.resize touchmove.resize mouseup.resize touchend.resize');
			});
		});
		

		 // 바깥 클릭 시 요소 제거
		 $(document).on('click.removeElements', function (e) {
			if (!$(e.target).is($img) && !$(e.target).is($alignContainer) && !$(e.target).closest('.resize-handle').length) {
				$handle.remove();
				$alignContainer.remove();
				$(document).off('click.removeElements');
			}
		});

		// 마진값 변경 감지 및 스크롤 이벤트에 버튼과 핸들 제거
		var observer = new MutationObserver(function (mutationsList) {
			mutationsList.forEach(function (mutation) {
				if ($(mutation.target).hasClass('ql-tooltip') && $(mutation.target).css('margin') !== '') {
					$handle.remove();
					$alignContainer.remove();
					observer.disconnect(); // 감지 종료
				}
			});
		});
	
		// ql-tooltip 요소 감시
		var targetNode = document.querySelector('.ql-tooltip');
		if (targetNode) {
			observer.observe(targetNode, { attributes: true, attributeFilter: ['style'] });
		}
	});
  
	//공지사항 
	
	//취소버튼 
	$(".n_backButton").click(function(){
		window.history.back();
	});


	//글쓰기 페이지로
	$("#notice_write").click(function(){
		location.href = "/board/notice_write";
	});

	//공지사항 목록 페이지로
	$("#ad_notice_list").click(function(){
		document.hideFrm.action="/board/notice_list";
		document.hideFrm.method="get";
		document.hideFrm.submit();
	});

	//공지사항 목록 페이지로
	$("#notice_list").click(function(){
		document.hideFrm.action="/board/notice_list";
		document.hideFrm.method="get";
		document.hideFrm.submit();
	});

	//공지사항 글 수정페이지로
	$('.notice_modify').on('click', function() {
        var val = $(this).data('seq');
		var nowPage = $('input[name="nowPage"]').val();
		var searchKeyword = $('input[name="searchKeyword"]').val();
		var searchCondition = $('input[name="searchCondition"]').val();

        location.href = "/board/notice_modify?n_seq=" + val + // URL을 변경합니다.
				"&nowPage=" + nowPage +
				"&searchKeyword=" + encodeURIComponent(searchKeyword) +
				"&searchCondition=" + searchCondition;
    });
	
	//공지사항 글 삭제
	$('.notice_delete').on('click', function() {
		// 삭제 확인 경고문
		const confirmed = confirm("공지를 삭제하시겠습니까?");
		if (!confirmed) {
			return; // 사용자가 취소를 선택하면 함수 종료
		}
		
		var val = $(this).data('seq');
		location.href = "/board/notice_delete?n_seq=" + val
	});

	//공지사항 상세페이지
	$('.notice_view').on('click', function() {
        var val = $(this).data('seq'); // 
		var count = $(this).data('count');
		var nowpage = $(this).data('nowpage');
		var searchcondition = $(this).data('searchcondition');
		var searchkeyword = $(this).data('searchkeyword');
		
		location.href = "/board/notice_view?n_seq=" + val + 
		"&n_count=" + count + 
		"&nowPage=" + nowpage + 
		"&searchCondition=" + searchcondition + 
		"&searchKeyword=" + encodeURIComponent(searchkeyword); // 검색어 URL 인코딩
    });
	
	//공지사항-글쓰기 전송할때 quill에디터 내용 가져오기
	$('#noticeForm').on('submit', function() {
		var content = quill.root.innerHTML;
		$('#n_content').val(content); 
	});


	$( window ).resize(function() {
		var windowWidth = $( window ).width();
		if(windowWidth >= 978) {
			$("#subNavMenu").hide();
		}
	});
	
	$("#clMenu").click(function(){
		$("#subNavMenu").toggle();
	});
	
	$("#conWrite").click(function(){
		location.href = "/insertBoard.do";
	});
	
	$("#conDel").click(function(){
		let con_test = confirm("정말로 삭제하시겠습니까?");
		if(con_test == true){
			let s = document.fm.seq.value;
			let w = document.fm.writer.value;
			location.href = "/deleteBoard.do?seq="+s+"&writer="+w;
		}
		else if(con_test == false){
		  	return false;
		}
	});
	
	
	/* 241017_추가 페이징처리와 목록, 검색 유지 기능 처리*/
	$("#conList").click(function(){
		document.hideFrm.action="/getBoardList.do";
		document.hideFrm.method="post";
		document.hideFrm.submit();
	});


	/*====================QNA==================== */
	//QNA 상세페이지
	$('.qna_view').on('click', function() {
        var val = $(this).data('seq'); // 
		var count = $(this).data('count');
		var nowpage = $(this).data('nowpage');
		var searchcondition = $(this).data('searchcondition');
		var searchkeyword = $(this).data('searchkeyword');
		
		location.href = "/board/qna_view?qna_seq=" + val + 
		"&qna_count=" + count + 
		"&nowPage=" + nowpage + 
		"&searchCondition=" + searchcondition + 
		"&searchKeyword=" + encodeURIComponent(searchkeyword); // 검색어 URL 인코딩
    });

	//QNA 목록 페이지로
	$("#qna_list").click(function(){
		document.hideFrm.action="/board/qna_list";
		document.hideFrm.method="get";
		document.hideFrm.submit();
	});

	//QNA 글 수정페이지로
	$('.qna_modify').on('click', function() {
		var val = $(this).data('seq');
		var nowPage = $('input[name="nowPage"]').val();
		var searchKeyword = $('input[name="searchKeyword"]').val();
		var searchCondition = $('input[name="searchCondition"]').val();

		location.href = "/board/qna_modify?qna_seq=" + val +// URL을 변경합니다.
				"&nowPage=" + nowPage +
                "&searchKeyword=" + encodeURIComponent(searchKeyword) +
                "&searchCondition=" + searchCondition;
	});

	//QNA-글쓰기 전송할때 quill에디터 내용 가져오기
	$('#qnaForm').on('submit', function() {
		var content = quill.root.innerHTML;
		$('#qna_content').val(content); 
	});

	//QNA 페이지로
	$(".qna_write").click(function(event){
		var isLoggedIn = $(this).data('logged-in') === true;
		if (!isLoggedIn) {
			event.preventDefault(); // 기본 동작 중단
			alert("로그인이 필요합니다!");
		}else{
			location.href = "/board/qna_write";
		}
	});

	//QNA 글 삭제
	$('.qna_delete').on('click', function() {
		// 삭제 확인 경고문
		const confirmed = confirm("Q&A글을 삭제하시겠습니까?");
		if (!confirmed) {
			return; // 사용자가 취소를 선택하면 함수 종료
		}
		var val = $(this).data('seq');
		location.href = "/board/qna_delete?qna_seq=" + val
	});


    // 댓글 등록 -QNA
    $('#submitComment').click(function() {
        const commentContent = $('#commentContent').val();
		const qna_seq = $('#submitComment').val();

        if (!commentContent) {
            alert("댓글 내용을 입력해주세요.");
            return;
        }

        $.ajax({
            url: "/board/addComment",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            method: "POST",
            data: {
                "qna_seq": qna_seq,                  // 해당 qna_seq 설정
                "qna_cmt_content": commentContent
            },
            success: function() {
                $('#commentContent').val('');  // 입력 필드 초기화
                loadComments();                // 댓글 목록 새로고침
            }
        });
    });

    // 댓글 삭제 -QNA
	
	$(document).on("click", ".deleteComment", function() {
		const qna_cmt_seq = $(this).data("qna_cmt_seq"); 
		
		// 삭제 확인 경고문
		const confirmed = confirm("댓글을 삭제하시겠습니까?");
		if (!confirmed) {
			return; // 사용자가 취소를 선택하면 함수 종료
		}

        $.ajax({
            url: "/board/deleteComment?qna_cmt_seq="+qna_cmt_seq,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            method: "GET",
            success: function() {
                loadComments();  // 댓글 목록 새로고침
            }
        });
	});

	//QNA- 댓글 수정창 나오게
	$(document).on("click", ".updateComment", function() {
		const qna_cmt_seq = $(this).data("qna_cmt_seq"); 
		// 해당 댓글의 textarea 요소 선택 (예: `edit-comment` 클래스가 있는 경우)
		const $content = $(`#comment-${qna_cmt_seq}`).find(".comment-content");
		const $commentbody = $(`#comment-${qna_cmt_seq}`).find(".comment-body");

		// 댓글 내용을 가져오기
		const commentContent = $content.html().trim().replace(/<br\s*\/?>/g, "\n");

		// 기존 입력 폼이 있으면 삭제
		$(".reply-form").remove();

		const marginLeft = $(`#comment-${qna_cmt_seq}`).css("margin-left");

		// 댓글 쓰기 폼 HTML 생성
		const replyFormHtml = `
			<div class="reply-form" style="margin-left: ${marginLeft}">
				<div class="reply-form-header">
					<button class="reply-form-close" data-qna_cmt_seq="${qna_cmt_seq}" style="top:10px; right:2px;" ><i data-feather="x-circle"></i>닫기</button>
				</div>
				<div class="reply-form-body">
					<textarea rows="2" class="reply-textarea">${commentContent}</textarea>
					<button class="submit-q_udate" data-qna_cmt_seq="${qna_cmt_seq}">수정</button>
				</div>
			</div>
		`;

		// 현재 댓글 밑에 폼 추가
		$commentbody.hide();
		$(`#comment-${qna_cmt_seq}`).append(replyFormHtml);

		feather.replace();
	});

	//QNA- 댓글 수정
	$(document).on("click", ".submit-q_udate", function() {

		const qna_cmt_seq = $(this).data("qna_cmt_seq"); 
		const replyContent = $(this).siblings("textarea").val();

		$.ajax({
			url: "/board/updateComment",
			method : "GET",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data: {
				"qna_cmt_seq" : qna_cmt_seq,
				"qna_cmt_content": replyContent
			},
			success : function(data){
				loadComments();
			}

		});
	});

	//======================커뮤니티============================
	//커뮤니티 상세페이지
	$('.cmty_view').on('click', function() {
        var val = $(this).data('seq'); // 
		var count = $(this).data('count');
		var nowpage = $(this).data('nowpage');
		var searchcondition = $(this).data('searchcondition');
		var searchkeyword = $(this).data('searchkeyword');
		var cmty_category = $(this).data('cmty_category');

		location.href = "/board/cmty_view?cmty_seq=" + val + 
		"&cmty_count=" + count + 
		"&nowPage=" + nowpage + 
		"&searchCondition=" + searchcondition + 
		"&cmty_category=" + cmty_category +
		"&searchKeyword=" + encodeURIComponent(searchkeyword); // 검색어 URL 인코딩
    });

	//커뮤니티 목록 페이지로
	$("#cmty_list").click(function(){
		document.hideFrm.action="/board/cmty_list";
		document.hideFrm.method="get";
		document.hideFrm.submit();
	});

	//커뮤니티 글 수정페이지로
	$('.cmty_modify').on('click', function() {
		var val = $(this).data('seq');
		var nowPage = $('input[name="nowPage"]').val();
		var searchKeyword = $('input[name="searchKeyword"]').val();
		var searchCondition = $('input[name="searchCondition"]').val();
		var cmty_category = $('input[name="cmty_category"]').val();

		location.href = "/board/cmty_modify?cmty_seq=" + val +
                    "&nowPage=" + nowPage +
                    "&searchKeyword=" + encodeURIComponent(searchKeyword) +
                    "&searchCondition=" + searchCondition +
                    "&cmty_category=" + cmty_category;
	});

	//커뮤니티-글쓰기 전송할때 quill에디터 내용 가져오기
	$('#cmtyForm').on('submit', function() {
		var content = quill.root.innerHTML;
		$('#cmty_content').val(content); 
	});

	//커뮤니티 글쓰기페이지로
	$(".cmty_write").click(function(event){
		var isLoggedIn = $(this).data('logged-in') === true;
		if (!isLoggedIn) {
			event.preventDefault(); // 기본 동작 중단
			alert("로그인이 필요합니다!");
		}else{
			location.href = "/board/cmty_write";
		}
	});

	const urlParams = new URLSearchParams(window.location.search);
    const currentCategory = urlParams.get('cmty_category');

    if (currentCategory) {
		$('.category-link').removeClass('text-danger');
        // 현재 카테고리와 일치하는 링크에 클래스 추가
        $('.category-link').each(function () {

            if ($(this).data('cmty_category') === currentCategory) {
                $(this).addClass('blue');
            }
        });
    }

	//커뮤니티 카테고리 클릭시
	$('#c_category ul li a').on('click', function(event) {
        event.preventDefault(); // 기본 링크 동작을 막음

        const cmty_category = $(this).data('cmty_category'); // 선택한 카테고리 값

        // 현재 URL의 파라미터를 가져옴
        const urlParams = new URLSearchParams(window.location.search);

        // 새 파라미터 추가 또는 변경
        urlParams.set('cmty_category', cmty_category);
		urlParams.set('nowPage', "1");

        // 새로운 URL 생성
        const newUrl = `${window.location.pathname}?${urlParams.toString()}`;

        // 페이지 이동
        window.location.href = newUrl;
    });

	//커뮤니티 글 삭제
	$('.cmty_delete').on('click', function() {
	
		// 삭제 확인 경고문
		const confirmed = confirm("글을 삭제하시겠습니까?");
		if (!confirmed) {
			return; // 사용자가 취소를 선택하면 함수 종료
		}
		
		var val = $(this).data('seq');
		location.href = "/board/cmty_delete?cmty_seq=" + val
	});

	// 댓글 등록 -커뮤니티
    $('#cmty_comment').click(function() {
        const commentContent = $('#commentContent').val();
		const cmty_seq = $('#cmty_comment').val();

        if (!commentContent) {
            alert("댓글 내용을 입력해주세요.");
            return;
        }

        $.ajax({
            url: "/board/c_addComment",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            method: "POST",
            data: {
                "cmty_seq": cmty_seq,                  // 해당 qna_seq 설정
                "cmty_cmt_content": commentContent
            },
            success: function() {
                $('#commentContent').val('');  // 입력 필드 초기화
                c_loadComments();                // 댓글 목록 새로고침
            }
        });
    });



	//커뮤니티 답글달기
	$(document).on("click", ".c_comment", function() {
		const commentId = $(this).data("cmty_cmt_seq");

		// 기존 입력 폼이 있으면 삭제
		$(".reply-form").remove();

		const marginLeft = $(`#comment-${commentId}`).css("margin-left");

		// 댓글 쓰기 폼 HTML 생성
		const replyFormHtml = `
			<div class="reply-form" style="margin-top: 10px; margin-left: ${marginLeft}">
				<div class="reply-form-header">
					<span><i data-feather="corner-down-right"></i>댓글 쓰기</span>
					<button class="reply-form-close" style="top:34px; right:3px;" ><i data-feather="x-circle"></i>닫기</button>
				</div>
				<div class="reply-form-body">
					<textarea rows="2" class="reply-textarea" placeholder="답글을 입력하세요"></textarea>
					<button class="submit-reply" data-cmty_cmt_parent_seq="${commentId}">등록</button>
				</div>
			</div>
		`;

		// 현재 댓글 밑에 폼 추가
		$(".comment-body").show();
		$(`#comment-${commentId}`).after(replyFormHtml);
		feather.replace();
	});

	//커뮤니티 답글달기 창 닫기
	$(document).on("click", ".reply-form-close", function() {
		const cmty_cmt_seq = $(this).data("cmty_cmt_seq"); 
		const $commentbody = $(`#comment-${cmty_cmt_seq}`).find(".comment-body");
		$commentbody.show();

		const qna_cmt_seq = $(this).data("qna_cmt_seq"); 
		const $qnabody = $(`#comment-${qna_cmt_seq}`).find(".comment-body");
		$qnabody.show();

		$(".reply-form").remove();
	});

	// 대댓글 등록 AJAX
	$(document).on("click", ".submit-reply", function() {
		const commentId = $(this).data("cmty_cmt_parent_seq"); // 부모 댓글 ID
		const replyContent = $(this).siblings("textarea").val(); // 입력된 답글 내용
		const cmty_seq = $('#cmty_comment').val();

		if (!replyContent) {
			alert("답글 내용을 입력하세요.");
			return;
		}

		$.ajax({
			url: "/board/c_addReply", 
			method: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data: {
				"cmty_seq": cmty_seq,
				"cmty_cmt_parent_seq": commentId,
				"cmty_cmt_content": replyContent
			},
			success: function() {
				$(".reply-form").remove();  // 입력 폼 초기화
				c_loadComments()     // 대댓글 목록 새로고침
			},
			error: function(error) {
				console.error("대댓글 등록 실패:", error);
				alert("대댓글 등록에 실패했습니다.");
			}
		});
	});

	//커뮤니티 추천!!
	$("#cmty_up").on('click', function() {
		const cmty_seq = $('#cmty_comment').val();
		
		$.ajax({
			url: "/board/cmty_up", 
			method: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data: {
				"cmty_seq": cmty_seq
			},
			success: function(data) {
				alert(data);
				cmty_up_reload();
			}
		});
	});

	//커뮤니티 댓글 삭제
	$(document).on("click", ".c_comment-delete", function() {
		const cmty_cmt_seq = $(this).data("cmty_cmt_seq"); 

		// 삭제 확인 경고문
		const confirmed = confirm("댓글을 삭제하시겠습니까?");
		if (!confirmed) {
			return; // 사용자가 취소를 선택하면 함수 종료
		}

		$.ajax({
			url: "/board/c_delComment",
			method : "GET",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data: {
				"cmty_cmt_seq" : cmty_cmt_seq
			},
			success : function(data){
				c_loadComments();
			}

		});

	});

	//커뮤니티 댓글 수정창 나오게
	$(document).on("click", ".c_comment-udate", function() {
		const cmty_cmt_seq = $(this).data("cmty_cmt_seq"); 
		// 해당 댓글의 textarea 요소 선택 (예: `edit-comment` 클래스가 있는 경우)
		const $content = $(`#comment-${cmty_cmt_seq}`).find(".comment-content");
		const $commentbody = $(`#comment-${cmty_cmt_seq}`).find(".comment-body");

		// 댓글 내용을 가져오기
		const commentContent = $content.html().trim().replace(/<br\s*\/?>/g, "\n");

		// 기존 입력 폼이 있으면 삭제
		$(".reply-form").remove();

		const marginLeft = $(`#comment-${cmty_cmt_seq}`).css("margin-left");

		// 댓글 쓰기 폼 HTML 생성
		const replyFormHtml = `
			<div class="reply-form" style="margin-left: ${marginLeft}">
				<div class="reply-form-header">
					<button class="reply-form-close" data-cmty_cmt_seq="${cmty_cmt_seq}" style="top:10px; right:2px;" ><i data-feather="x-circle"></i>닫기</button>
				</div>
				<div class="reply-form-body" >
					<textarea rows="2" class="reply-textarea">${commentContent}</textarea>
					<button class="submit-c_udate" data-cmty_cmt_seq="${cmty_cmt_seq}">수정</button>
				</div>
			</div>
		`;

		// 현재 댓글 밑에 폼 추가
		$commentbody.hide();
		$(`#comment-${cmty_cmt_seq}`).append(replyFormHtml);

		feather.replace();
	});

	//커뮤니티 댓글 수정
	$(document).on("click", ".submit-c_udate", function() {

		const cmty_cmt_seq = $(this).data("cmty_cmt_seq"); 
		const replyContent = $(this).siblings("textarea").val();

		$.ajax({
			url: "/board/c_updateComment",
			method : "GET",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data: {
				"cmty_cmt_seq" : cmty_cmt_seq,
				"cmty_cmt_content": replyContent
			},
			success : function(data){
				c_loadComments();
			}

		});
	});

	// 첫 번째 이미지를 가져와서 추가하는 코드
	$(document).ready(function () {
		$('.cmty_view').each(function () {
			var $element = $(this);
			var content = $element.find('.cmty_content').html();
			var imgMatch = content.match(/<img[^>]+src="([^"]+)"/);

			if (imgMatch) {
				var firstImgSrc = imgMatch[1];
				var $firstImgElement = $('<img>', {
					src: firstImgSrc,
					alt: '첫 번째 이미지',
					class: 'firstimg'
				});

				var $imgWrapper = $('<div>', { class: 'img-wrapper' }).append($firstImgElement);

				// cmty_view 요소의 맨 처음에 이미지 추가
				$element.append($imgWrapper);
			}
		});

		// .cmty_content 요소 내용 변경 코드 (jQuery)
		$('.cmty_content').each(function () {
			var $contentElement = $(this);
			var originalContent = $contentElement.html();
			$contentElement.html(extractFirstParagraph(originalContent));
		});

		$('.cmty_content').css("display","block");

	});

	// img 태그를 삭제하고 첫 번째 글만 반환하는 jQuery 함수
	function extractFirstParagraph(content) {
		var $tempDiv = $('<div>').html(content);

		// img 태그 삭제
		$tempDiv.find('img').remove();

		// 첫 번째 글만 반환
		var firstParagraph = $tempDiv.find('p').first();
		return firstParagraph.length ? '<div class="title-wrapper">'+firstParagraph.prop('outerHTML')+'</div>' : '';
	}
});

//댓글 목록 불러오기 -QNA
function loadComments() {
	const qna_seq = $('#submitComment').val();
	var contextPath = $('body').data('context-path');

    $.ajax({
        url: "/board/commentList?qna_seq="+qna_seq,  // qna_seq에 맞는 댓글 불러오기
        method: "GET",
        success: function(response) {
			const comments = response.comments;
            const us_id = response.us_id;

            $('#commentList').empty();
            comments.forEach(comment => {
				const content = comment.qna_cmt_content.replace(/\n/g, "<br>");

                $('#commentList').append(`
                    <div class="comment" id="comment-${comment.qna_cmt_seq}">
						<div class="comment-header">
							<span class="comment-id">
								<img class="us_profile" alt="프로필"src="${contextPath}/resources/profile_images/${comment.us_profile}" onerror="this.onerror=null; this.src='${contextPath}/resources/profile_images/default.jpg';">
								 ${comment.us_nick}
								<span class="comment-date">${comment.qna_cmt_date}</span>
							</span>
							<div class="comment-actions">
								${(comment.qna_cmt_id === us_id || us_id === "admin") ? `
									<span class="action-toggle">&middot;&middot;&middot;</span>
									<div class="action-menu" style="display: none;">
										${comment.qna_cmt_id === us_id || us_id === "admin" ? `<span class="updateComment" data-qna_cmt_seq="${comment.qna_cmt_seq}">수정</span>` : ''}
										${(comment.qna_cmt_id === us_id || us_id === "admin") ? `<span class="deleteComment" data-qna_cmt_seq="${comment.qna_cmt_seq}">삭제</span>` : ''}
									</div>
									`: ''
								}
							</div>
						</div>
						<div class="comment-body">
							<span class="comment-content">${content}</span>
						</div>
                    </div>
                `);
            });
        }
    });
}
document.addEventListener('click', function (event) {
    // 클릭한 요소가 .action-toggle 클래스인지 확인
    const toggleButton = event.target.closest('.action-toggle');
    
    let menu = null;
    if (toggleButton) {
        menu = toggleButton.nextElementSibling;
    }

    // 모든 메뉴 숨기기
    document.querySelectorAll('.action-menu').forEach(function(menu) {
        menu.style.display = 'none';
    });

    // 클릭한 버튼의 메뉴 보이기
    if (menu) {
        menu.style.display = 'block';
    }
});

// 클릭이 메뉴 외부라면 메뉴 닫기
document.addEventListener('click', function (event) {
	const isMenuClick = event.target.closest('.comment-actions');
	if (!isMenuClick) {
		document.querySelectorAll('.action-menu').forEach(menu => {
			menu.style.display = 'none';
		});
	}
});


function c_loadComments() {
	const cmty_seq = $('#cmty_comment').val();
    $.ajax({
        url: "/board/c_commentList?cmty_seq=" + cmty_seq,  // cmty_seq에 맞는 댓글 불러오기
        method: "GET",
        success: function(response) {
			const comments = response.comments;
            const us_id = response.us_id;

            $('#commentList').empty();
   
            // 댓글을 계층 구조로 표시
            const commentMap = {};
            
            // 댓글을 parent_seq에 따라 그룹화
            comments.forEach(comment => {
                if (!commentMap[comment.cmty_cmt_parent_seq]) {
                    commentMap[comment.cmty_cmt_parent_seq] = [];
                }
                commentMap[comment.cmty_cmt_parent_seq].push(comment);
            });

            // 최상위 댓글부터 재귀적으로 렌더링
            renderComments(commentMap, null, 0 , us_id);
			feather.replace();
        }
    });
}

// 재귀 함수: 부모 댓글 아래에 자식 댓글을 렌더링
function findParentNickname(commentMap, parentSeq) {
    for (let key in commentMap) {
        const commentList = commentMap[key];
        const parentComment = commentList.find(comment => comment.cmty_cmt_seq === parentSeq);
        if (parentComment) {
            return parentComment.us_nick;
        }
    }
    return '';
}

function renderComments(commentMap, parentSeq, depth, us_id) {
    if (!commentMap[parentSeq]) return;  // 더 이상 자식 댓글이 없을 경우 종료

    commentMap[parentSeq].forEach(comment => {
        const indent = depth * 10;  // depth에 따라 들여쓰기 설정 (예: 15px씩 들여쓰기)
        // 부모 댓글의 닉네임을 찾기 위해 findParentNickname 함수 호출
        const parentNickname = comment.cmty_cmt_parent_seq ? findParentNickname(commentMap, comment.cmty_cmt_parent_seq) : '';
		var contextPath = $('body').data('context-path');

        $('#commentList').append(`
            <div class="comment" id="comment-${comment.cmty_cmt_seq}" style="margin-left: ${indent}px;">
                <div class="comment-header">
                    <span class="comment-id">
                        ${comment.cmty_cmt_parent_seq ? '<i data-feather="corner-down-right"></i>' : ''}
						<img class="us_profile" src="${contextPath}/resources/profile_images/${comment.us_profile}" onerror="this.onerror=null; this.src='${contextPath}/resources/profile_images/default.jpg';" alt="프로필" >
                        ${comment.us_nick}
                        <span class="comment-date">${comment.cmty_cmt_date}</span>
                    </span>
                    <div class="cmt_abs">
						${(comment.cmty_cmt_id === us_id && comment.cmty_cmt_del === 'N') || us_id === "admin" ? `
						<div class="comment-actions">
							<span class="action-toggle">&middot;&middot;&middot;</span>
							<div class="action-menu" style="display: none;">
								${(comment.cmty_cmt_id === us_id && comment.cmty_cmt_del === 'N') || us_id === "admin" ? `<span class="c_comment-udate" data-cmty_cmt_seq="${comment.cmty_cmt_seq}">수정</span>` : ''}
								${(comment.cmty_cmt_id === us_id && comment.cmty_cmt_del === 'N') || us_id === "admin" ? `<span class="c_comment-delete" data-cmty_cmt_seq="${comment.cmty_cmt_seq}">삭제</span>` : ''}
							</div>
						</div>
						` : ''}
                        ${us_id && comment.cmty_cmt_del === 'N' ? `<span class="c_comment" data-cmty_cmt_seq="${comment.cmty_cmt_seq}">답글</span>` : ''}
                    </div>
                </div>
                <div class="comment-body">
                    ${parentNickname ? `<span class="parent-nickname">@${parentNickname}&nbsp;&nbsp;</span>` : ''}
                    <span class="comment-content">
                        ${
                            comment.cmty_cmt_del === 'Y' && comment.has_active_child === "1" 
                            ? '[삭제된 댓글입니다.]' 
                            : comment.cmty_cmt_content.replace(/\n/g, "<br>")
                        }
                    </span>
                </div>
            </div>
        `);

        // 자식 댓글이 있는 경우 재귀 호출하여 렌더링
        renderComments(commentMap, comment.cmty_cmt_seq, depth + 1, us_id);
    });
}

//추천수 불러오기
function cmty_up_reload(){
	const cmty_seq = $('#cmty_comment').val();

	$.ajax({
		url: "/board/cmty_up_reload",
        method: "GET",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		data: {
			"cmty_seq": cmty_seq
		},
        success: function(newCount) {
		
			$("#cmty_up").html(`<i data-feather="thumbs-up"></i>추천수: ${newCount}`);
            
            if (typeof feather !== 'undefined') {
                feather.replace();
            }
        },
        error: function() {
            alert("추천을 처리하는 데 문제가 발생했습니다.");
        }
	});
}