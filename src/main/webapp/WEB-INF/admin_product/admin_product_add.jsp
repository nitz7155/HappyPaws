<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>상품 등록</title>
<jsp:include page="${pageContext.request.contextPath}/head.jsp" />

<style>
.container {
	width: 600px;
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.title {
	text-align: center;
	font-size: 24px;
	margin-bottom: 20px;
}

.image-upload {
	width: 100%;
	height: 300px;
	background-color: #ddd;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-bottom: 20px;
	margin-top: 50px;
}

#image-preview {
	max-width: 100%;
	max-height: 100%;
	display: none;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
}

.form-group input[type="text"], .form-group input[type="number"],
	.form-group textarea, .form-group select {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.pr_name {
	width: 500px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.form-group textarea {
	resize: none;
	height: 150px;
}

.options {
	display: flex;
	flex-direction: column;
	margin-bottom: 15px;
}

.option-group input {
	width: 65%;
}

.option-group button {
	flex-shrink: 0; /* 버튼이 작게 유지되도록 */
	padding: 10px;
}

.options input[type="text"], .options input[type="number"] {
	padding: 10px;
	width: 500px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.buttons {
	display: flex;
	justify-content: center;
}

.buttons button {
	padding: 10px 20px;
	margin: 5px;
	border: none;
	background-color: #333;
	color: white;
	cursor: pointer;
	border-radius: 5px;
}

.buttons button.cancel {
	background-color: #bbb;
}

.buttons button.register {
	background-color: #4CAF50;
}

.buttons button.delete {
	background-color: #ff5858;
}

.option-name_status, .option-stock_price, .pr_name_status {
	display: flex; /* 요소를 가로로 정렬 */
	align-items: center; /* 세로 정렬 */
}

.pr_name_status input[type="text"] {
	flex: 3;
}

.pr_name_status select {
	flex: 1;
	margin-left: 7px;
	margin-top: 23px;
}

.option-stock_price button {
	padding: 10px;
	width: 40px; /* 버튼 너비 설정 */
	height: 40px; /* 버튼 높이 설정 */
	text-align: center;
	line-height: 20px; /* 버튼 내 텍스트 위치 조정 */
	font-size: 16px;
	border: 1px solid #ccc;
}

.option-name_status select {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
	margin-left: 10px;
}

.add-option, .remove-option {
	border-radius: 10px;
	background-color: #535353;
	font-weight: bold;
	color: white;
}

.options input[type="text"], .options input[type="number"] {
	padding: 10px;
	width: 222px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-right: 10px;
}

options input[type="number"] {
	margin-left: 10px;
}

#pr_opt_status {
	margin: 0;
}

#pr_opt_name, #pr_name {
	width: 450px;
}

[type=button]:not(:disabled), [type=reset]:not(:disabled), [type=submit]:not(:disabled),
	button:not(:disabled) {
	cursor: pointer;
	margin-left: 7px;
}

.ql-editor{
		min-height:200px;
		overflow-y : auto;
		}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/admin/admin_header.jsp" />
	<main>
		<div class="container">
			<form action="ad_manageProductAdd" method="POST" enctype="multipart/form-data" id="productAddForm">

<!-- 				이미지 업로드 영역 -->
<!-- 				<div class="image-upload"> -->
<!-- 					<img id="image-preview" -->
<!-- 						src="../../resources/images/HappyPawsLogo.png" alt="이미지 미리보기"> -->
<!-- 				</div> -->
<!-- 				파일 업로드 필드 -->
<!-- 				<div class="form-group" style="text-align: center"> -->
<!-- 					<label for="pr_thumbnail_file"> <input type="file" -->
<!-- 						id="pr_thumbnail_file" name="pr_thumbnail_file" accept="image/*"> -->
<!-- 					</label> -->
<!-- 				</div> -->

				<!-- 이미지 업로드 영역 -->
				<div class="form-group" style="text-align: center">
			    <label for="pr_thumbnail_file" style="display: block; cursor: pointer;">
			        <div class="image-upload">
			            <span id="upload-text">클릭해서 이미지 업로드</span>
			            <img id="image-preview" src="../../resources/images/HappyPawsLogo.png" alt="이미지 미리보기" style="display: none;">
			        </div>
			        <input type="file" id="pr_thumbnail_file" name="pr_thumbnail_file" accept="image/*" style="display: none;">
			    </label>
			</div>
			
			<script>
			    const fileInput = document.getElementById('pr_thumbnail_file');
			    const imagePreview = document.getElementById('image-preview');
			    const uploadText = document.getElementById('upload-text');
			
			    fileInput.addEventListener('change', function(event) {
			        const file = event.target.files[0];
			        if (file) {
			            const reader = new FileReader();
			            reader.onload = function(e) {
			                imagePreview.src = e.target.result;
			                imagePreview.style.display = 'block'; // 이미지 표시
			                uploadText.style.display = 'none'; // 텍스트 숨김
			            }
			            reader.readAsDataURL(file);
			        } else {
			            imagePreview.style.display = 'none';
			            uploadText.style.display = 'block';
			        }
			    });
			</script><br>
			
			
				<div class="form-group">
					<div class="pr_name_status">
						<label for="pr_name"> 상품명 <br> <input type="text"
							id="pr_name" name="pr_name" value="">
						</label> <label for="pr_status"> <select id="pr_status"
							name="pr_status">
								<option value="available">판매중</option>
								<option value="out_of_stock">일시품절</option>
								<option value="discontinued">품절</option>
						</select>
						</label>
					</div>
				</div>

				<div class="form-group">
					<label for="pr_price">대표 가격(원) <input type="number"
						id="pr_price" name="pr_price" value="" placeholder="숫자만 입력 가능합니다.">
					</label>
				</div>

				<div class="form-group">
					<label for="pr_category">카테고리 선택 <select id="pr_category"
						name="pr_category">
							<option value="식품">식품</option>
							<option value="위생">위생</option>
							<option value="미용">미용</option>
							<option value="의류">의류</option>
							<option value="놀이">놀이</option>
					</select>
					</label>
				</div>

				옵션 입력
				<div id="options-container" class="options">
					<div class="option-group">
						<div class="option-name_status">
							<label for="pr_opt_name"></label> <input type="text"
								name="pr_opt_name" id="pr_opt_name" value=""
								placeholder="옵션명 필수 입력" required> <label
								for="pr_opt_status"> <select id="pr_opt_status"
								name="pr_opt_status">
									<option value="available">판매중</option>
									<option value="out_of_stock">일시품절</option>
									<option value="discontinued">품절</option>
							</select>
							</label>
						</div>
						<br>
						<div class="option-stock_price">
							<label for="pr_opt_price"> <input type="number"
								name="pr_opt_price" value="" placeholder="옵션 추가금 입력" required>
							</label> <label for="pr_opt_stock"> <input type="number"
								name="pr_opt_stock" value="" placeholder="재고 수량 입력" required>
							</label>
							<button type="button" class="add-option">+</button>
							<button type="button" class="remove-option">-</button>
						</div>
						<br>
					</div>
				</div>



				<div class="form-group">
					<label for="pr_desc">제품 정보</label>
					<textarea id="pr_desc" name="pr_desc" style="font-size: 19px;"></textarea>
				</div>

				<div class="form-group">
					<label for="pr_detail_desc">상품 상세 설명</label>
					<div id="editor"></div>
					<input type="hidden" id="pr_detail_desc" name="pr_detail_desc">
				</div>

				<input type="hidden" id="option_count" name="option_count" value="1">

				<div class="buttons">
					<button type="button" class="cancel" onclick="cancel()">취소</button>
					<button type="submit">등록</button>
				</div>
			</form>
		</div>

		<script>
		

		$(document).ready(function() {
			    // URL에 "cmty"가 포함된 경우 "active" 클래스 추가
			    if (window.location.href.includes("cmty")) {
			        $(".cmty-link").addClass("active");
			    }
			    
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
			              ['image','code-block'],
			              [{ 'align': [] }],
			              [{ list: 'ordered' }, { list: 'bullet' }],
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
		    
		    
		    
		    

		  // 폼 제출 시 Quill 데이터 전송
	    $('#productAddForm').on('submit', function(e) {
	        var content = quill.root.innerHTML;  // Quill 데이터 가져오기
	        $('#pr_detail_desc').val(content);   // 숨겨진 input에 설정
	    });
		});

		</script>
		<script>
		
	function cancel() {
	    location.href = "/ad_manageProductList";
	}

	//옵션 개수 구하는 함수
	function getOptionCount() {
	    const optionGroups = document.querySelectorAll('.option-group');
	    return optionGroups.length;
	}

	//옵션 업데이트 함수
	function updateOptionCount() {
	    const optionCount = getOptionCount();  // 현재 옵션 개수 구하기
	   	document.getElementById('option_count').value = optionCount;  // 숨겨진 필드에 옵션 개수 설정
	}

    document.addEventListener('DOMContentLoaded', function () {
        const optionsContainer = document.getElementById('options-container');
		const imagePreview = document.getElementById('image-preview');
		const fileInput = document.getElementById('pr_thumbnail_file');
		 let currentlyOpenOption = null; // 현재 열려 있는 옵션 추적 변수
		 
        // 옵션 추가
        document.addEventListener('click', function (e) {
            if (e.target.classList.contains('add-option')) {
                const optionGroup = document.querySelector('.option-group');
                const newOption = optionGroup.cloneNode(true); // 기존 옵션 복사
                newOption.querySelectorAll('input').forEach(input => input.value = ''); // 새 옵션은 빈 값
                optionsContainer.appendChild(newOption);
                updateOptionCount();  // 옵션 개수 업데이트
            }
        });

        // 옵션 삭제
        document.addEventListener('click', function (e) {
            if (e.target.classList.contains('remove-option')) {
                const optionGroups = document.querySelectorAll('.option-group');
                if (optionGroups.length > 1) {
                    e.target.closest('.option-group').remove();
                    updateOptionCount();  // 옵션 개수 업데이트
                } else {
                    alert("최소 옵션 수량은 1개입니다.(옵션 필수 작성)");
                }
            }
        });
        
        //파일 선택 시 이미지 미리보기
        fileInput.addEventListener('change',function(event) {
        	const file = event.target.files[0];
        	if(file){
        		const reader = new FileReader();
        		
        		reader.onload = function(e){
        			imagePreview.src = e.target.result;
        			imagePreview.style.display = 'block'; //이미지 미리보기 표시
        		}
        		reader.readAsDataURL(file);
        	}
        });
        
        
        //옵션 클릭 시 기존 옵션 닫고 새 옵션 열기
        document.addEventListener('click', function(e){
        		if(e.target.closest('.option-group')){
        		const clickedOptionGroup = e.target.closest('.option-group');
        		
        		// 현재 열려 있는 옵션과 다르면 닫기
                if (currentlyOpenOption && currentlyOpenOption !== clickedOptionGroup) {
                    currentlyOpenOption.classList.remove('open'); // 기존 열린 옵션 닫기
                }
            	 // 클릭한 옵션 열거나 닫기
                if (clickedOptionGroup.classList.contains('open')) {
                    clickedOptionGroup.classList.remove('open'); // 열려 있으면 닫기
                    currentlyOpenOption = null;
                } else {
                    clickedOptionGroup.classList.add('open'); // 닫혀 있으면 열기
                    currentlyOpenOption = clickedOptionGroup;
                }
        	}
        });
    });
</script>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />

</body>
</html>
