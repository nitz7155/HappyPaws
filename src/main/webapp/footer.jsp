<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer>
	<p class="footer-text"><a href="/auth/adminLogin">&copy; HappyPaws</a> 팀장/부팀장: 임창욱, 이현승 &nbsp;&nbsp;&nbsp;팀원: 강동준, 김민지, 오경숙, 임성현</p>
    <p>본 사이트는 교육용으로 실제로 사용하실 수 없습니다. 이용에 참고 바랍니다.</p>
    
    <script type="text/javascript">
	    function updateFooterText() {
	        var footerText = document.querySelector('.footer-text');
	        if (window.innerWidth <= 768) {
	            footerText.innerHTML = '<a href="/auth/adminLogin">&copy; HappyPaws</a> 팀장/부팀장: 임창욱, 이현승 <br> 팀원: 강동준, 김민지, 오경숙, 임성현';
	        } else {
	            footerText.innerHTML = '<a href="/auth/adminLogin">&copy; HappyPaws</a> 팀장/부팀장: 임창욱, 이현승 &nbsp;&nbsp;&nbsp;팀원: 강동준, 김민지, 오경숙, 임성현';
	        }
	    }
	
	    // 초기 실행
	    updateFooterText();
	
	    // 화면 크기 변경 감지
	    window.addEventListener('resize', updateFooterText);
    </script>
</footer>