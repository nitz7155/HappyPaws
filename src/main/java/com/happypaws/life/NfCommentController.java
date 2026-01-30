package com.happypaws.life;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.happypaws.svc.NfCommentSVC;
import com.happypaws.vo.NfCommentVO;

@Controller
@RequestMapping("/MIA")
public class NfCommentController {

	@Autowired
	private NfCommentSVC nfCommentSVC;

	// 댓글 등록
	@RequestMapping(value = "/insertNfComment")
	public String insertNfComment(NfCommentVO vo, HttpServletRequest request)
			throws IllegalStateException, IOException {
		String searchCondition = request.getParameter("searchCondition");
		String searchKeyword = request.getParameter("searchKeyword");
		String category = request.getParameter("category");
		String nowPage = request.getParameter("nowPage");

		// 댓글 등록 로직 수행
		nfCommentSVC.insertNfComment(vo);

		// 리다이렉트할 때 필요한 파라미터 추가
		return "redirect:/MIA/getNewFamily?nf_seq=" + vo.getNf_seq() + "&searchCondition=" + searchCondition
				+ "&searchKeyword=" + searchKeyword + "&category=" + category + "&nowPage=" + nowPage;
	}

	// 댓글 수정
	@RequestMapping("/updateNfComment")
	public String updateNfComment(NfCommentVO vo, HttpServletRequest request) {
	    String nf_seq = request.getParameter("nf_seq");
	    String nfc_seq = request.getParameter("nfc_seq");
	    String searchCondition = request.getParameter("searchCondition");
	    String searchKeyword = request.getParameter("searchKeyword");
	    String category = request.getParameter("category");
	    String nowPage = request.getParameter("nowPage");

	    try {
	        if (nf_seq != null && nfc_seq != null) {
	            vo.setNf_seq(Integer.parseInt(nf_seq));
	            vo.setNfc_seq(Integer.parseInt(nfc_seq));
	            
	            // 댓글 내용 설정
	            String nfc_content = request.getParameter("nfc_content");
	            if (nfc_content != null && !nfc_content.trim().isEmpty()) { // 비어있지 않은지 확인
	                vo.setNfc_content(nfc_content);
	            } else {
	                throw new IllegalArgumentException("댓글 내용이 누락되었습니다.");
	            }
	            
	            nfCommentSVC.updateNfComment(vo);
	        } else {
	            throw new IllegalArgumentException("nf_seq 또는 nfc_seq가 누락되었습니다.");
	        }
	    } catch (NumberFormatException e) {
	        System.err.println("숫자 형식 오류: " + e.getMessage());
	    } catch (Exception e) {
	        System.err.println("예외 발생: " + e.getMessage());
	    }

	    return "redirect:/MIA/getNewFamily?nf_seq=" + vo.getNf_seq() + 
	           "&searchCondition=" + searchCondition +
	           "&searchKeyword=" + searchKeyword + 
	           "&category=" + category + 
	           "&nowPage=" + nowPage;
	}

	// 댓글 삭제
	@RequestMapping("/deleteNfComment")
	public String deleteNfComment(HttpServletRequest request) {
		String nf_seq = request.getParameter("nf_seq");
		String nfc_seq = request.getParameter("nfc_seq");
		String searchCondition = request.getParameter("searchCondition");
		String searchKeyword = request.getParameter("searchKeyword");
		String category = request.getParameter("category");
		String nowPage = request.getParameter("nowPage");
		
		
		NfCommentVO vo = new NfCommentVO();
		vo.setNf_seq(Integer.parseInt(nf_seq));
		vo.setNfc_seq(Integer.parseInt(nfc_seq));

		nfCommentSVC.deleteNfComment(vo);
		return "redirect:/MIA/getNewFamily?nf_seq=" + vo.getNf_seq() + "&searchCondition=" + searchCondition
				+ "&searchKeyword=" + searchKeyword + "&category=" + category + "&nowPage=" + nowPage;
	}
}
