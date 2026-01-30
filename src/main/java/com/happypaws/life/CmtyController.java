package com.happypaws.life;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happypaws.svc.CmtySVC;
import com.happypaws.util.PagingVO;
import com.happypaws.vo.CmtyCommentVO;
import com.happypaws.vo.CmtyupVO;
import com.happypaws.vo.CommunityVO;
import com.happypaws.vo.NoticeVO;
import com.happypaws.vo.UsersVO;

@Controller
public class CmtyController {
	
	@Autowired
	private CmtySVC cmty_SVC;
	
	// 시작페이지
	@RequestMapping("/cmty_index")
	@ResponseBody
	public List<CmtyupVO> cmyt_index() {
		return cmty_SVC.cmyt_index();
	}
	
	//커뮤니티-리스트 페이지이동
	@RequestMapping(value={"/board/cmty_list","/admin/ad_cmty_list"},method = RequestMethod.GET)
	public String cmty_list(CommunityVO vo ,PagingVO pv ,Model model , 
			@RequestParam(value = "nowPage", required = false) String nowPage,
			HttpServletRequest request
	) {
		
		String cntPerPage = "10";
			
		if (vo.getSearchCondition() == null) vo.setSearchCondition("TITLE");
		if (vo.getSearchKeyword() == null) vo.setSearchKeyword("");
		if (nowPage == null) nowPage = "1"; 
		
		int total = cmty_SVC.countCmty(vo);
			
		pv = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));			
		model.addAttribute("paging", pv);
	
		vo.setStart(pv.getStart());
		vo.setListcnt(Integer.parseInt(cntPerPage));
			
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("cmtyList", cmty_SVC.cmty_list(vo));
		
		String requestUri = request.getRequestURI();
		
		if(requestUri.equals("/admin/ad_cmty_list")) {
			return "/WEB-INF/admin/ad_board/ad_cmty_list.jsp";
		}else {
			return "/WEB-INF/board/cmty_list.jsp";
		}
	}

	// 커뮤니티-상세보기
	@RequestMapping(value = {"/board/cmty_view","/admin/ad_cmty_view"}, method = RequestMethod.GET)
	public String cmty_view(CommunityVO vo , Model model , HttpServletRequest request) {
	
		model.addAttribute("cmtyview", cmty_SVC.cmty_view(vo));
		
		cmty_SVC.cmty_count(vo);
		
		String requestUri = request.getRequestURI();
		
		if(requestUri.equals("/admin/ad_cmty_view")) {
			return "/WEB-INF/admin/ad_board/ad_cmty_view.jsp";
		}else {
			return "/WEB-INF/board/cmty_view.jsp";
		}
		
	}
	
	//커뮤니티-글수정페이지로
	@RequestMapping(value = {"/board/cmty_modify","/admin/ad_cmty_modify"}, method = RequestMethod.GET)
	public String cmty_modify(CommunityVO vo, Model model , HttpServletRequest request) {
		
		model.addAttribute("cmtyview", cmty_SVC.cmty_view(vo));
		
		String requestUri = request.getRequestURI();
		
		if(requestUri.equals("/admin/ad_cmty_modify")) {
			return "/WEB-INF/admin/ad_board/ad_cmty_modify.jsp";
		}else {
			return "/WEB-INF/board/cmty_modify.jsp";
		}
		
	}
	
	//커뮤니티 - 글수정
	@RequestMapping(value = {"/board/cmty_modify","/admin/ad_cmty_modify"}, method = RequestMethod.POST)
	public String cmty_update(CommunityVO vo, Model model , HttpServletRequest request) throws UnsupportedEncodingException {
		
		cmty_SVC.cmty_update(vo);
		
		String nowPage = request.getParameter("nowPage");
		String view_cmty_category = request.getParameter("view_cmty_category");
		String requestUri = request.getRequestURI();
		
		if (vo.getSearchCondition() == null) vo.setSearchCondition("TITLE");
		if (vo.getSearchKeyword() == null) vo.setSearchKeyword("");
		
		String encodedKeyword = URLEncoder.encode(vo.getSearchKeyword(), StandardCharsets.UTF_8.toString());
		String encodedCondition = URLEncoder.encode(vo.getSearchCondition(), StandardCharsets.UTF_8.toString());
		
		if(requestUri.equals("/admin/ad_cmty_modify")) {
	        return "redirect:/admin/ad_cmty_view?cmty_seq="+vo.getCmty_seq() +
	        	   "&cmty_category=" + view_cmty_category +
	               "&nowPage=" + (nowPage != null ? nowPage : "1") +
	               "&searchKeyword=" + encodedKeyword +
	               "&searchCondition=" + encodedCondition;
	    } else {
	        return "redirect:/board/cmty_view?cmty_seq="+vo.getCmty_seq() +
	        	   "&cmty_category=" + view_cmty_category +
	               "&nowPage=" + (nowPage != null ? nowPage : "1") +
	               "&searchKeyword=" + encodedKeyword +
	               "&searchCondition=" + encodedCondition;
	    }
		
	}
	
	//커뮤니티-글쓰기 페이지이동
	@RequestMapping(value={"/board/cmty_write","/admin/ad_cmty_write"},method = RequestMethod.GET)
	public String cmty_write(HttpServletRequest request) {
		String requestUri = request.getRequestURI();
		
		if(requestUri.equals("/admin/ad_cmty_write")) {
			return "/WEB-INF/admin/ad_board/ad_cmty_write.jsp";
		}else {
			return "/WEB-INF/board/cmty_write.jsp";
		}
	}
	
	
	//커뮤니티 - 글쓰기
	@RequestMapping(value={"/board/cmty_insert","/admin/ad_cmty_insert"}, method = RequestMethod.POST)
	public String cmty_insert(CommunityVO vo , HttpServletRequest request) {
		
		cmty_SVC.cmty_insert(vo);
		
		String requestUri = request.getRequestURI();
		
		if(requestUri.equals("/admin/ad_cmty_insert")) {
			return "redirect:/admin/ad_cmty_list?cmty_category=all";
		}else {
			return "redirect:/board/cmty_list?cmty_category=all";
		}
		
	}
	
	//커뮤니티 삭제하기
	@RequestMapping(value = {"/board/cmty_delete","/admin/ad_cmty_delete"}, method = RequestMethod.GET)
	public String cmty_delete(CommunityVO vo, Model model ,  HttpServletRequest request) {
		
		cmty_SVC.cmty_delete(vo);
		String requestUri = request.getRequestURI();
		
		if(requestUri.equals("/admin/ad_cmty_delete")) {
			return "redirect:/admin/ad_cmty_list?cmty_category=all";
		}else {
			return "redirect:/board/cmty_list?cmty_category=all";
		}
		
	}
	
    //커뮤니티 댓글추가
	@RequestMapping(value = "/board/c_addComment", method = RequestMethod.POST)
	@ResponseBody
    public String c_addComment(CmtyCommentVO comment , HttpSession session) {
		UsersVO user = (UsersVO) session.getAttribute("user");
		
		comment.setCmty_cmt_id(user.getUs_id());
		
		cmty_SVC.c_addComment(comment);
        return "OK";
    }
	
	//커뮤니티 댓글삭제
	@RequestMapping(value = "/board/c_delComment", method = RequestMethod.GET)
	@ResponseBody
	public String c_delComment(CmtyCommentVO comment, HttpSession session) {

		cmty_SVC.c_delComment(comment);
		return "OK";
		
	}
	
	//커뮤니티 댓글수정
	@RequestMapping(value = "/board/c_updateComment", method = RequestMethod.GET)
	@ResponseBody
	public String c_updateComment(CmtyCommentVO comment, HttpSession session) {

		cmty_SVC.c_updateComment(comment);
		return "OK";
		
	}
	
	// 특정 커뮤니티 글에 대한 댓글 목록
	@RequestMapping(value = "/board/c_commentList", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> commentList(CmtyCommentVO comment , HttpSession session) {
		UsersVO user = (UsersVO) session.getAttribute("user");
		
		String us_id = (user != null) ? user.getUs_id() : null;
		List<CmtyCommentVO> comments = cmty_SVC.c_commentList(comment);
		 
	    Map<String, Object> response = new HashMap<>();
	    response.put("comments", comments);
	    response.put("us_id", us_id);
		
	    return response; // 해당 qna_seq에 대한 댓글 목록을 반환
	}
	
	// 특정 커뮤니티 글에 대한 대댓글 추가
	@RequestMapping(value="/board/c_addReply",method=RequestMethod.POST)
	@ResponseBody
	public String c_addReply(CmtyCommentVO comment , HttpSession session) {
		UsersVO user = (UsersVO) session.getAttribute("user");
		
		comment.setCmty_cmt_id(user.getUs_id());
		cmty_SVC.c_addReply(comment);
		
		return "OK";  // 해당 qna_seq에 대한 댓글 목록을 반환
	}
	
	// 커뮤니티 추천
	@RequestMapping(value = "/board/cmty_up" , method =RequestMethod.POST , produces = "text/plain; charset=UTF-8") 
	@ResponseBody
	public String cmty_up(CmtyupVO vo, HttpSession session) {
		UsersVO user = (UsersVO) session.getAttribute("user");
		String msg = "";
		if(user == null) {
			msg ="로그인이 필요합니다.";
		}else {
			vo.setUs_id(user.getUs_id());
			msg = cmty_SVC.cmty_up(vo);
		}
		
		return msg;
	}
	
	
	// 추천수 가져오기
	@RequestMapping(value = "/board/cmty_up_reload", method = RequestMethod.GET)
	@ResponseBody
	public int cmty_up_reload(Model model , CmtyupVO vo) {
	   
		return cmty_SVC.cmty_up_cut(vo); 
	}
}