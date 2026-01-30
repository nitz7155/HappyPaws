package com.happypaws.life;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.happypaws.svc.AdSVC;
import com.happypaws.util.Argon2Util; // Argon2Util 임포트
import com.happypaws.util.JwtCookieUtil;
import com.happypaws.vo.UsersVO;

@Controller
public class AdminController {

    @Autowired
    private AdSVC svc;

    // 관리자 마이페이지 이동
    @GetMapping({"/ad_myPage.do",  "/us_myPage2.do"})
    public String ad_myPage(HttpServletRequest request, Model model) {
    	
    	String requestUri = request.getRequestURI();
    	
    	if(requestUri.equals("/us_myPage2.do")) {
    		 return "/WEB-INF/mypage/us_mypage2.jsp";
    	}else {
    		 return "/WEB-INF/mypage/ad_mypage.jsp";
    	}
       
    }

    // 비밀번호 변경 처리
    @PostMapping("/updateAdminInfo.do")
    public String updateAdminInfo(@RequestParam("currentPassword") String currentPassword,
                                  @RequestParam("newPassword") String newPassword,
                                  HttpServletRequest request,
                                  Model model) {
        // 쿠키에서 관리자 ID 가져오기
        String ad_id = null;
        UsersVO admin = JwtCookieUtil.extractJwtFromCookie(request);
        
        if (admin != null) {
            ad_id = admin.getUs_id();            
        }

        if (ad_id == null) {
            model.addAttribute("error", "관리자 ID를 찾을 수 없습니다.");
            return "/WEB-INF/mypage/ad_mypage.jsp";
        }

        // 현재 비밀번호 검증
        String storedHash = svc.getStoredPasswordHash(ad_id); // 저장된 해시 값 가져오기
        boolean isValid = Argon2Util.verifyPassword(storedHash, currentPassword);
        if (!isValid) {
            model.addAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
            return "/WEB-INF/mypage/ad_mypage.jsp";
        }

        // 새 비밀번호와 현재 비밀번호가 동일한지 확인
        if (currentPassword.equals(newPassword)) {
            model.addAttribute("error", "현재 비밀번호와 동일한 비밀번호로 변경할 수 없습니다.");
            return "/WEB-INF/mypage/ad_mypage.jsp";
        }

        // 새 비밀번호를 Argon2로 해싱
        String hashedPassword = Argon2Util.hashPassword(newPassword);
        svc.updatePassword(ad_id, hashedPassword); // 암호화된 비밀번호 저장
        model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        return "/WEB-INF/mypage/ad_mypage.jsp";
    }
}
