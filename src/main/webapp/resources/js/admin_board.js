//관리자 js
$(document).ready(function(){ 

    //관리자-공지사항 상세페이지
	$('.ad_notice_view').on('click', function() {
        var val = $(this).data('seq'); // 
		var count = $(this).data('count');
		var nowpage = $(this).data('nowpage');
		var searchcondition = $(this).data('searchcondition');
		var searchkeyword = $(this).data('searchkeyword');
		
		location.href = "/admin/ad_notice_view?n_seq=" + val + 
		"&n_count=" + count + 
		"&nowPage=" + nowpage + 
		"&searchCondition=" + searchcondition + 
		"&searchKeyword=" + encodeURIComponent(searchkeyword); // 검색어 URL 인코딩
    });

	//공지사항 목록 페이지로
	$("#ad_notice_list").click(function(){
		document.hideFrm.action="/admin/ad_notice_list";
		document.hideFrm.method="get";
		document.hideFrm.submit();
	});

//============================================================================
	//QNA 페이지로
	$(".ad_qna_write").click(function(event){
		var isLoggedIn = $(this).data('logged-in') === true;
		if (!isLoggedIn) {
			event.preventDefault(); // 기본 동작 중단
			alert("로그인이 필요합니다!");
		}else{
			location.href = "/admin/ad_qna_write";
		}
	});

	//QNA 상세페이지
	$('.ad_qna_view').on('click', function() {
        var val = $(this).data('seq'); // 
		var count = $(this).data('count');
		var nowpage = $(this).data('nowpage');
		var searchcondition = $(this).data('searchcondition');
		var searchkeyword = $(this).data('searchkeyword');
		
		location.href = "/admin/ad_qna_view?qna_seq=" + val + 
		"&qna_count=" + count + 
		"&nowPage=" + nowpage + 
		"&searchCondition=" + searchcondition + 
		"&searchKeyword=" + encodeURIComponent(searchkeyword); // 검색어 URL 인코딩
    });

	//QNA 목록 페이지로
	$("#ad_qna_list").click(function(){
		document.hideFrm.action="/admin/ad_qna_list";
		document.hideFrm.method="get";
		document.hideFrm.submit();
	});

	//QNA 글 삭제
	$('.ad_qna_delete').on('click', function() {
		// 삭제 확인 경고문
		const confirmed = confirm("Q&A글을 삭제하시겠습니까?");
		if (!confirmed) {
			return; // 사용자가 취소를 선택하면 함수 종료
		}
		var val = $(this).data('seq');
		location.href = "/admin/ad_qna_delete?qna_seq=" + val
	});

	//QNA 글 수정페이지로
	$('.ad_qna_modify').on('click', function() {
		var val = $(this).data('seq');
		var nowPage = $('input[name="nowPage"]').val();
		var searchKeyword = $('input[name="searchKeyword"]').val();
		var searchCondition = $('input[name="searchCondition"]').val();

		location.href = "/admin/ad_qna_modify?qna_seq=" + val +// URL을 변경합니다.
				"&nowPage=" + nowPage +
				"&searchKeyword=" + encodeURIComponent(searchKeyword) +
				"&searchCondition=" + searchCondition;
	});

//==================================================================================
	//커뮤니티 상세페이지
	$('.ad_cmty_view').on('click', function() {
        var val = $(this).data('seq'); // 
		var count = $(this).data('count');
		var nowpage = $(this).data('nowpage');
		var searchcondition = $(this).data('searchcondition');
		var searchkeyword = $(this).data('searchkeyword');
		var cmty_category = $(this).data('cmty_category');

		location.href = "/admin/ad_cmty_view?cmty_seq=" + val + 
		"&cmty_count=" + count + 
		"&nowPage=" + nowpage + 
		"&searchCondition=" + searchcondition + 
		"&cmty_category=" + cmty_category +
		"&searchKeyword=" + encodeURIComponent(searchkeyword); // 검색어 URL 인코딩
    });

	//커뮤니티 목록 페이지로
	$("#ad_cmty_list").click(function(){
		document.hideFrm.action="/admin/ad_cmty_list";
		document.hideFrm.method="get";
		document.hideFrm.submit();
	});

	//커뮤니티 글 수정페이지로
	$('.ad_cmty_modify').on('click', function() {
		var val = $(this).data('seq');
		var nowPage = $('input[name="nowPage"]').val();
		var searchKeyword = $('input[name="searchKeyword"]').val();
		var searchCondition = $('input[name="searchCondition"]').val();
		var cmty_category = $('input[name="cmty_category"]').val();

		location.href = "/admin/ad_cmty_modify?cmty_seq=" + val +
                    "&nowPage=" + nowPage +
                    "&searchKeyword=" + encodeURIComponent(searchKeyword) +
                    "&searchCondition=" + searchCondition +
                    "&cmty_category=" + cmty_category;
	});

	//커뮤니티 글쓰기페이지로
	$(".ad_cmty_write").click(function(event){
		var isLoggedIn = $(this).data('logged-in') === true;
		if (!isLoggedIn) {
			event.preventDefault(); // 기본 동작 중단
			alert("로그인이 필요합니다!");
		}else{
			location.href = "/admin/ad_cmty_write";
		}
	});

	//커뮤니티 글 삭제
	$('.ad_cmty_delete').on('click', function() {
	
		// 삭제 확인 경고문
		const confirmed = confirm("글을 삭제하시겠습니까?");
		if (!confirmed) {
			return; // 사용자가 취소를 선택하면 함수 종료
		}
		
		var val = $(this).data('seq');
		location.href = "/admin/ad_cmty_delete?cmty_seq=" + val
	});

});