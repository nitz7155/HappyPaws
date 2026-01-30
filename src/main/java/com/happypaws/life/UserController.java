package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.happypaws.svc.UserSVC;
import com.happypaws.util.JwtCookieUtil;
import com.happypaws.vo.MyPostVO;
import com.happypaws.vo.UsersVO;

@Controller

public class UserController {
    @Autowired
    private UserSVC svc;
    
    @Autowired
	private ServletContext servletContext;
    
    @GetMapping("/userList.do")
    public void userSelectAll(
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<UsersVO> userList;
        if (searchType != null && !searchType.isEmpty() && searchKeyword != null && !searchKeyword.isEmpty()) {
            userList = svc.searchUsers(searchType, searchKeyword);
        } else {
            userList = svc.userSelectAll();
        }

        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/WEB-INF/mypage/us_list.jsp").forward(request, response);
    }

    
    @GetMapping("/userDetail.do")
    public String selectUserDetail(@RequestParam("us_id") String us_id, Model model) {
        UsersVO user = svc.user_detail(us_id);

        // us_is_del 값이 'Y'이면 탈퇴한 회원 알림 메시지 추가
        if (user != null && "Y".equals(user.getUs_is_del())) {
            model.addAttribute("alertMessage", "탈퇴한 회원입니다.");
        }

        model.addAttribute("detailUser", user);
        return "/WEB-INF/mypage/us_detail.jsp";  
    }


        
    @GetMapping("/userUpdate.do")
    public String updateForm(@RequestParam("us_id") String usId, HttpServletRequest request, Model m) {
        // 로그인한 관리자의 정보를 추출
        UsersVO loggedInUser = JwtCookieUtil.extractJwtFromCookie(request);
        
        // 관리자 로그인 여부 확인
        if (loggedInUser == null || loggedInUser.getUs_id() == null) {
            m.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }

        // 요청된 회원 ID로 사용자 정보를 조회 (관리자 권한으로 조회)
        UsersVO user = svc.getUserById(usId);
        
        // 조회된 사용자 정보가 없을 경우 오류 메시지 표시
        if (user == null) {
            m.addAttribute("message", "해당 회원 정보를 찾을 수 없습니다.");
            return "redirect:/user/list"; // 사용자 목록 페이지로 리다이렉트
        }

        // 조회된 사용자 정보를 모델에 추가
        m.addAttribute("detailUser", user);
        return "/WEB-INF/mypage/us_update.jsp";  
    }


    @RequestMapping(value = "/userUpdate.do", method = RequestMethod.POST)
    public String updateUser(@RequestParam("us_id") String usId, HttpServletRequest request, UsersVO vo, RedirectAttributes redirectAttributes) {

        // 로그인한 관리자의 정보를 추출
        UsersVO loggedInUser = JwtCookieUtil.extractJwtFromCookie(request);

        // 관리자 로그인 여부 확인
        if (loggedInUser == null || loggedInUser.getUs_id() == null) {
            redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }

        // 수정하려는 회원의 기존 정보 가져오기
        UsersVO existingUser = svc.user_detail(usId);

        // 요청된 회원 ID가 존재하지 않으면 오류 메시지 반환
        if (existingUser == null) {
            redirectAttributes.addFlashAttribute("message", "해당 회원 정보를 찾을 수 없습니다.");
            return "redirect:/user/list"; // 사용자 목록 페이지로 리다이렉트
        }

        // us_id 설정: 수정할 회원의 ID로 설정
        vo.setUs_id(usId);

        // 사용자 정보 업데이트 (비밀번호 제외)
        svc.user_update(vo);
        redirectAttributes.addFlashAttribute("message", "수정이 완료되었습니다.");

        return "redirect:/userList.do"; // 수정된 목록 화면으로 이동
    }

//    @GetMapping("/userDelete.do")
//    public String showDeleteUserPage(HttpServletRequest request, Model m) {
//        // 쿠키에서 사용자 정보를 추출
//        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
//        
//        // 사용자 정보가 없을 경우 로그인 페이지로 리다이렉트
//        if (user == null || user.getUs_id() == null) {
//            m.addAttribute("message", "로그인이 필요합니다.");
//            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
//        }
//        
//        // 사용자 ID와 탈퇴 확인 메시지를 모델에 추가
//        m.addAttribute("us_id", user.getUs_id());
//        m.addAttribute("message", "탈퇴를 원하시면 확인 버튼을 눌러주세요.");
//
//        // 탈퇴 확인 페이지로 이동
//        return "/WEB-INF/mypage/us_list.jsp";
//    }

    @PostMapping("/userDelete.do")
    public String updateUserToDeleted(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        // 쿠키에서 사용자 정보를 추출
        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
        
        // 사용자 정보가 없을 경우 로그인 페이지로 리다이렉트
        if (user == null || user.getUs_id() == null) {
            redirectAttributes.addFlashAttribute("alertMessage", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }

        // form에서 전달된 us_id 확인
        String us_id = request.getParameter("us_id");

        // 사용자 아이디가 "admin"인 경우 탈퇴를 수행하지 않도록 체크
        if ("admin".equals(us_id)) {
            redirectAttributes.addFlashAttribute("alertMessage", "관리자는 탈퇴할 수 없습니다.");
            return "redirect:/userList.do";
        }
        
                
        boolean isDeleted = svc.updateUserToDeleted(us_id);
        if (isDeleted) {
            redirectAttributes.addFlashAttribute("alertMessage", "회원 탈퇴가 완료되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("alertMessage", "회원 탈퇴 처리 중 오류가 발생했습니다.");
        }

        // 탈퇴 완료 페이지로 이동
        return "redirect:/userList.do";
    }

    @GetMapping("/us_mainmyPage.do")
    public String us_mainMyPage(HttpServletRequest request, Model m) {
        // 쿠키에서 사용자 정보 추출
        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);

        // 로그인 확인
        if (user == null || user.getUs_id() == null) {
            m.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }

        // 최신 사용자 정보 조회 및 모델에 추가
        UsersVO updatedUser = svc.user_detail(user.getUs_id());
        m.addAttribute("user", updatedUser);

        // 마이페이지로 이동
        return "/WEB-INF/mypage/us_mainmypage.jsp";
    }
    	
    @GetMapping("/us_myPage.do")
    public String us_myPage(HttpServletRequest request, Model m) {
        // 쿠키에서 사용자 정보를 추출합니다.
        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
        
        // 쿠키에서 사용자 정보를 가져오지 못했을 경우 로그인 페이지로 리다이렉트
        if (user == null || user.getUs_id() == null) {
            m.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }
       String us_id= user.getUs_id();
       user=svc.user_detail(us_id);
        // 사용자 정보를 모델에 추가하여 JSP에서 사용할 수 있도록 합니다.
        m.addAttribute("user", user);
       
        // 마이페이지로 이동
        return "/WEB-INF/mypage/us_mypage.jsp";  
    }
    
    @PostMapping("/us_myPage.do")
    public String updateMyPage(
        HttpServletRequest request,
        HttpServletResponse response,
        UsersVO user,
        @RequestParam(value = "postcode", required = false) String postcode,
        Model m) {

        UsersVO userFromCookie = JwtCookieUtil.extractJwtFromCookie(request);

        if (userFromCookie == null || userFromCookie.getUs_id() == null) {
            m.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }

        user.setUs_id(userFromCookie.getUs_id());
        if (user.getUs_profile_file().getSize() == 0) {
			user.setUs_profile(userFromCookie.getUs_profile());
		}
       
        if (user.getUs_profile_file() != null && !user.getUs_profile_file().isEmpty()) {
            try {
            	
            	String originalFilename = user.getUs_profile_file().getOriginalFilename();
            	      	      
                String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));

                String uniqueFileName = userFromCookie.getUs_id() + fileExtension;

//                String uploadDir = "C:/swork/HappyPaws/src/main/webapp/resources/profile_images/";
                String uploadDir = servletContext.getRealPath("/resources/profile_images/");
                
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs();
                }

                File outputFile = new File(uploadDir + uniqueFileName);
                user.getUs_profile_file().transferTo(outputFile);

                user.setUs_profile(uniqueFileName);

            } catch (IOException e) {
                e.printStackTrace();
                m.addAttribute("message", "프로필 이미지 업로드 중 오류가 발생했습니다.");
                return "/WEB-INF/mypage/us_mypage.jsp";
            }
        }

        // 우편번호 설정
        user.setPostcode(postcode); 

        // 사용자 정보 업데이트
        svc.user_update(user);

        // 세션 및 쿠키에 최신 사용자 정보 설정
        UsersVO updatedUser = svc.user_detail(user.getUs_id());
        JwtCookieUtil.createJwtCookie(response, updatedUser);
        request.getSession().setAttribute("user", updatedUser);

        // 메인 마이페이지로 리다이렉트
        return "redirect:/us_mainmyPage.do";
    }


    @RequestMapping("/logout")
   	public String logout(HttpServletResponse response, HttpSession session) {
   		session.removeAttribute("user");
   		JwtCookieUtil.deleteJwtCookie(response);
   		return "redirect:/userList.do";
   	}
    
    @GetMapping("/myPosts")
    public String showMyPosts(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String searchField,
            @RequestParam(required = false) String searchQuery,
            HttpServletRequest request,
            Model model) {

        // 쿠키에서 JWT를 통해 사용자 정보를 추출합니다.
        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);

        // 사용자 정보가 없거나 ID가 없는 경우 로그인 페이지로 리다이렉트
        if (user == null || user.getUs_id() == null) {
            model.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }

        // 사용자 ID에 해당하는 게시물 조회
        List<MyPostVO> userPosts = new ArrayList<>();
        try {
            if (searchField != null && searchQuery != null && !searchQuery.trim().isEmpty()) {
                // 검색 조건에 따라 게시물 필터링
                userPosts = svc.searchPostsByUserId(user.getUs_id(), searchField, searchQuery);
               
            } else {
                // 검색 조건이 없으면 전체 게시물 조회
                userPosts = svc.getPostsByUserId(user.getUs_id());
            }

            if (userPosts == null || userPosts.isEmpty()) {
                model.addAttribute("message", "등록된 게시물이 없습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("error", "게시물을 불러오는 중 오류가 발생했습니다.");
            return "redirect:/auth/login"; // 에러 페이지로 리다이렉트
        }

        // 페이지네이션 처리
        int pageSize = 10;
        int totalPosts = userPosts.size();
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

        // 현재 페이지의 게시물 리스트 추출
        int fromIndex = Math.max(0, (page - 1) * pageSize);
        int toIndex = Math.min(page * pageSize, totalPosts);

        List<MyPostVO> currentPagePosts = new ArrayList<>();
        if (fromIndex < toIndex) {
            currentPagePosts = userPosts.subList(fromIndex, toIndex);
        }

        // 모델에 데이터 추가
        model.addAttribute("currentPagePosts", currentPagePosts); // 현재 페이지 게시물
        model.addAttribute("currentPage", page); // 현재 페이지
        model.addAttribute("totalPages", totalPages); // 총 페이지 수
        model.addAttribute("searchField", searchField); // 검색 필드
        model.addAttribute("searchQuery", searchQuery); // 검색어
        model.addAttribute("user", user); // 사용자 정보를 모델에 추가

        // 내 게시물 페이지로 이동
        return "/WEB-INF/mypage/mypost.jsp";
    }

//    @GetMapping("/postDetail")
//    public String postDetail(@RequestParam("post_id") int postId, HttpServletRequest request, Model model) {
//        // 쿠키에서 JWT를 통해 사용자 정보를 추출
//        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
//
//        // 사용자 정보가 없거나 ID가 없는 경우 로그인 페이지로 리다이렉트
//        if (user == null || user.getUs_id() == null) {
//            model.addAttribute("message", "로그인이 필요합니다.");
//            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
//        }
//
//        // 현재 로그인한 사용자 ID를 저장
//        String currentUserId = user.getUs_id();
//
//        // `post_id`를 기반으로 게시물 정보를 조회
//        MyPostVO post = svc.getPostById(postId);
//
//        // 게시물이 존재하고, 현재 사용자가 게시물의 작성자인지 확인
//        if (post != null && post.getUs_id().equals(currentUserId)) {
//            model.addAttribute("post", post); // 모델에 게시물 정보 추가
//            return "/WEB-INF/mypage/postDetail.jsp"; // 게시물 상세 페이지로 이동
//        } else {
//            // 게시물이 없거나 접근 권한이 없는 경우 오류 메시지 추가
//            model.addAttribute("errorMessage", "해당 게시물을 찾을 수 없거나 접근 권한이 없습니다.");
//            return "/WEB-INF/mypage/error.jsp"; // 에러 페이지로 이동
//        }
//    }

}
