package com.happypaws.life;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happypaws.svc.FpCommentSVC;
import com.happypaws.vo.FpCommentVO;

@Controller
@RequestMapping("/MIA")
public class FpCommentController {

    @Autowired
    private FpCommentSVC fpCommentSVC;

    // 댓글 등록
    @RequestMapping(value = "/insertFpComment")
    public String insertFpComment(FpCommentVO vo, HttpServletRequest request)
            throws IllegalStateException, IOException {
        String searchCondition = request.getParameter("searchCondition");
        String searchKeyword = request.getParameter("searchKeyword");
        String category = request.getParameter("category");
        String nowPage = request.getParameter("nowPage");

        // 댓글 등록 로직 수행
        fpCommentSVC.insertFpComment(vo);

        // 리다이렉트할 때 필요한 파라미터 추가
        return "redirect:/MIA/getFindPet?fp_seq=" + vo.getFp_seq() + "&searchCondition=" + searchCondition
                + "&searchKeyword=" + searchKeyword + "&category=" + category + "&nowPage=" + nowPage;
    }

    // 댓글 수정
    @RequestMapping("/updateFpComment")
    public String updateFpComment(FpCommentVO vo, HttpServletRequest request) {
        String fp_seq = request.getParameter("fp_seq");
        String fpc_seq = request.getParameter("fpc_seq");
        String searchCondition = request.getParameter("searchCondition");
        String searchKeyword = request.getParameter("searchKeyword");
        String category = request.getParameter("category");
        String nowPage = request.getParameter("nowPage");

        try {
            if (fp_seq != null && fpc_seq != null) {
                vo.setFp_seq(Integer.parseInt(fp_seq));
                vo.setFpc_seq(Integer.parseInt(fpc_seq));
                
                // 댓글 내용 설정
                String fpc_content = request.getParameter("fpc_content");
                if (fpc_content != null && !fpc_content.trim().isEmpty()) { // 비어있지 않은지 확인
                    vo.setFpc_content(fpc_content);
                } else {
                    throw new IllegalArgumentException("댓글 내용이 누락되었습니다.");
                }
                
                fpCommentSVC.updateFpComment(vo);
            } else {
                throw new IllegalArgumentException("fp_seq 또는 fpc_seq가 누락되었습니다.");
            }
        } catch (NumberFormatException e) {
            System.err.println("숫자 형식 오류: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("예외 발생: " + e.getMessage());
        }

        return "redirect:/MIA/getFindPet?fp_seq=" + vo.getFp_seq() + 
               "&searchCondition=" + searchCondition +
               "&searchKeyword=" + searchKeyword + 
               "&category=" + category + 
               "&nowPage=" + nowPage;
    }

    // 댓글 삭제
    @RequestMapping("/deleteFpComment")
    public String deleteFpComment(HttpServletRequest request) {
        String fp_seq = request.getParameter("fp_seq");
        String fpc_seq = request.getParameter("fpc_seq");
        String searchCondition = request.getParameter("searchCondition");
        String searchKeyword = request.getParameter("searchKeyword");
        String category = request.getParameter("category");
        String nowPage = request.getParameter("nowPage");
        
       
        FpCommentVO vo = new FpCommentVO();
        vo.setFp_seq(Integer.parseInt(fp_seq));
        vo.setFpc_seq(Integer.parseInt(fpc_seq));

        fpCommentSVC.deleteFpComment(vo);
        return "redirect:/MIA/getFindPet?fp_seq=" + vo.getFp_seq() + "&searchCondition=" + searchCondition
                + "&searchKeyword=" + searchKeyword + "&category=" + category + "&nowPage=" + nowPage;
    }
    
    //비밀번호 확인
    @PostMapping("/verifyFpcPassword")
    @ResponseBody
    public int verifyFpcPassword(@RequestParam("fpc_seq") int fpcSeq,
                                 @RequestParam("password") String enteredPassword) {
        int isValid = fpCommentSVC.verifyFpcPassword(fpcSeq, enteredPassword);
       
        return isValid;
    }
}
