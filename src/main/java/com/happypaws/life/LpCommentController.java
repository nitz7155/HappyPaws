package com.happypaws.life;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.happypaws.svc.LpCommentSVC;
import com.happypaws.vo.LpCommentVO;

@Controller
@RequestMapping("/MIA")
public class LpCommentController {

	@Autowired
	private LpCommentSVC lpCommentSVC;

	// 댓글 등록
	@RequestMapping(value = "/insertLpComment")
	public String insertLpComment(LpCommentVO vo, HttpServletRequest request)
			throws IllegalStateException, IOException {
		String searchCondition = request.getParameter("searchCondition");
		String searchKeyword = request.getParameter("searchKeyword");
		String category = request.getParameter("category");
		String nowPage = request.getParameter("nowPage");

		// 댓글 등록 로직 수행
		lpCommentSVC.insertLpComment(vo);

		// 리다이렉트할 때 필요한 파라미터 추가
		return "redirect:/MIA/getLostPet?lp_seq=" + vo.getLp_seq() + "&searchCondition=" + searchCondition
				+ "&searchKeyword=" + searchKeyword + "&category=" + category + "&nowPage=" + nowPage;
	}

	// 댓글 수정
	@RequestMapping("/updateLpComment")
	public String updateLpComment(LpCommentVO vo, HttpServletRequest request) {
	    String lp_seq = request.getParameter("lp_seq");
	    String lpc_seq = request.getParameter("lpc_seq");
	    String searchCondition = request.getParameter("searchCondition");
	    String searchKeyword = request.getParameter("searchKeyword");
	    String category = request.getParameter("category");
	    String nowPage = request.getParameter("nowPage");

	    try {
	        if (lp_seq != null && lpc_seq != null) {
	            vo.setLp_seq(Integer.parseInt(lp_seq));
	            vo.setLpc_seq(Integer.parseInt(lpc_seq));
	            
	            // 댓글 내용 설정
	            String lpc_content = request.getParameter("lpc_content");
	            if (lpc_content != null && !lpc_content.trim().isEmpty()) { // 비어있지 않은지 확인
	                vo.setLpc_content(lpc_content);
	            } else {
	                throw new IllegalArgumentException("댓글 내용이 누락되었습니다.");
	            }
	            
	            lpCommentSVC.updateLpComment(vo);
	        } else {
	            throw new IllegalArgumentException("lp_seq 또는 lpc_seq가 누락되었습니다.");
	        }
	    } catch (NumberFormatException e) {
	        System.err.println("숫자 형식 오류: " + e.getMessage());
	    } catch (Exception e) {
	        System.err.println("예외 발생: " + e.getMessage());
	    }

	    return "redirect:/MIA/getLostPet?lp_seq=" + vo.getLp_seq() + 
	           "&searchCondition=" + searchCondition +
	           "&searchKeyword=" + searchKeyword + 
	           "&category=" + category + 
	           "&nowPage=" + nowPage;
	}


	// 댓글 삭제
	@RequestMapping("/deleteLpComment")
	public String deleteLpComment(HttpServletRequest request) {
		String lp_seq = request.getParameter("lp_seq");
		String lpc_seq = request.getParameter("lpc_seq");
		String searchCondition = request.getParameter("searchCondition");
		String searchKeyword = request.getParameter("searchKeyword");
		String category = request.getParameter("category");
		String nowPage = request.getParameter("nowPage");
				
		LpCommentVO vo = new LpCommentVO();
		vo.setLp_seq(Integer.parseInt(lp_seq));
		vo.setLpc_seq(Integer.parseInt(lpc_seq));

		lpCommentSVC.deleteLpComment(vo);
		return "redirect:/MIA/getLostPet?lp_seq=" + vo.getLp_seq() + "&searchCondition=" + searchCondition
				+ "&searchKeyword=" + searchKeyword + "&category=" + category + "&nowPage=" + nowPage;
	}
}
