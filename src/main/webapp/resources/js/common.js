$(document).ready(function() {
    // URL에 "cmty"가 포함된 경우 "active" 클래스 추가
    if (window.location.href.includes("cmty_")) {
        $(".cmty-link").addClass("active");
    }
    
    if (window.location.href.includes("qna_")) {
        $(".qna-link").addClass("active");
    }
    
    if (window.location.href.includes("notice_")) {
        $(".notice-link").addClass("active");
    }
    
    if (window.location.href.includes("pr_")) {
        $(".pr_-link").addClass("active");
    }
    
    if (window.location.href.includes("MIA")) {
        $(".MIA-link").addClass("active");
    }
    
   //==========================================================================================
	  // Set initial display text based on the selected option in the original select
	  var initialText = $('select[name="searchCondition"] option:selected').text();
	  $('.custom-select-display span').text(initialText);

	  // When custom option is clicked
	  $('.custom-select-display').on('click', function() {
		  $(this).siblings('.custom-options').toggle();
	  });
	  $('.custom-options div').on('click', function() {
		  var selectedText = $(this).text();
		  var selectedValue = $(this).attr('data-value');

		  // Update the display text
		  $(this).closest('.custom-select-wrapper').find('.custom-select-display span').text(selectedText);

		  // Update the visible select element
		  $('select[name="searchCondition"]').val(selectedValue).change();

		  // Hide the options
		  $('.custom-options').hide();
	  });
	  $(document).on('click', function(e) {
		  if (!$(e.target).closest('.custom-select-wrapper').length) {
			  $('.custom-options').hide();
		  }
	  });

	  // When the original select is changed
	  $('select[name="searchCondition"]').on('change', function() {
		  var selectedValue = $(this).val();
		  var selectedText = $(this).find('option:selected').text();

		  // Update the custom display text
		  $('.custom-select-display span').text(selectedText);

		  // Update the active custom option
		  $('.custom-options div').each(function() {
			  if ($(this).attr('data-value') === selectedValue) {
				  $(this).addClass('active').siblings().removeClass('active');
			  }
		  });
	  });

	// 검색 input 및 옵션에 그림자 효과 추가
    $('input[type=search] , .custom-select-display , .custom-options').on('focus mouseenter input', function () {
        $('input[type=search] , .custom-select-display').css('box-shadow', '0 0 5px rgba(0, 0, 0, 0.2)');
		$('input[type=search]').css('box-shadow', '0 0 5px rgba(0, 0, 0, 0.2), -1px 0 0 transparent'); // 왼쪽 보더 그림자 제거
    }).on('blur mouseleave', function () {
        $('input[type=search] , .custom-select-display').css('box-shadow', 'none');
    });

//=======================================================================================  
    
});