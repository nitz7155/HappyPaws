package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.happypaws.svc.FindPetSVC;
import com.happypaws.svc.FpCommentSVC;
import com.happypaws.vo.FindPetVO;
import com.happypaws.vo.FpCommentVO;
import com.happypaws.vo.PagingVO;

@Controller
@RequestMapping("/MIA")
public class FindPetController {
    int cntChk = 0;

    @Autowired
    private FindPetSVC findPetSVC;

    @Autowired
    private FpCommentSVC fpCommentSVC;

    @Autowired
    private ServletContext servletContext;

    // 글 등록
    @RequestMapping(value = "/insertFindPet", method = RequestMethod.GET)
    public String insertView(FindPetVO vo) throws IllegalStateException, IOException {
        return "/WEB-INF/MIA/findPet/insertFindPet.jsp";
    }

    @RequestMapping(value = "/insertFindPet", method = RequestMethod.POST)
    public String insertFindPet(FindPetVO vo) throws IllegalStateException, IOException {
        MultipartFile uploadFile = vo.getUploadFile();
        String originalFilename = uploadFile.getOriginalFilename();
        String realPath = servletContext.getRealPath("/resources/MIA-img/findPetImg/");
        
        // UUID를 사용하여 새로운 파일 이름 생성
        String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFilename;
        vo.setFp_img(uniqueFileName);

        // 파일을 지정한 경로에 저장
        uploadFile.transferTo(new File(realPath + uniqueFileName));

        findPetSVC.insertFindPet(vo);
        return "redirect:/MIA/getFindPetList";
    }

    //비밀번호 확인
    @PostMapping("/verifyPassword")
    @ResponseBody
    public int verifyPassword(@RequestParam("fp_seq") int fpSeq,
                                              @RequestParam("password") String enteredPassword) {
        int isValid = findPetSVC.verifyPassword(fpSeq, enteredPassword);
       
        return isValid;
    }

    
    // 글 수정
    @RequestMapping(value = "/updateFindPet", method = RequestMethod.GET)
    public String updateView(@RequestParam(value = "error", required = false) String error,
                             @RequestParam(value = "fp_seq") int seq, FindPetVO vo, Model model,
                             @RequestParam(value = "nowPage", required = false) String nowPage,
                             @RequestParam(value = "category", required = false) String category) {

        vo.setFp_seq(seq);
        FindPetVO mfindPet = findPetSVC.getFindPet(vo);

        model.addAttribute("nowPage", vo.getNowPage());
        model.addAttribute("searchKeyword", vo.getSearchKeyword());
        model.addAttribute("searchCondition", vo.getSearchCondition());
        model.addAttribute("category", vo.getCategory());
        model.addAttribute("findPet", mfindPet);
        return "/WEB-INF/MIA/findPet/modifyFindPet.jsp";
    }

    @RequestMapping(value = "/updateFindPet", method = RequestMethod.POST)
    public String updateFindPet(FindPetVO vo, HttpSession session) throws IllegalStateException, IOException {
        MultipartFile uploadFile = vo.getUploadFile();
        String originalFilename = uploadFile.getOriginalFilename();
        String realPath = servletContext.getRealPath("/resources/MIA-img/findPetImg/");
        // 현재 이미지 이름을 가져오는 서비스 메서드
        String existingImg = findPetSVC.getCurrentImage(vo.getFp_seq());
        String newFileName;

        if (existingImg != null && !existingImg.isEmpty() && originalFilename.isEmpty()) {
            // 파일을 업로드하지 않았을 때 기존 파일 이름을 그대로 사용
            newFileName = existingImg;
        } else if (existingImg != null && existingImg.equals(originalFilename)) {
            // 파일 이름이 동일하면 기존 이름 사용
            newFileName = existingImg;
        } else {
            // 파일 이름이 다르면 UUID 생성하여 새로운 파일 이름 설정
            newFileName = UUID.randomUUID().toString() + "_" + originalFilename;
        }

        vo.setFp_img(newFileName);

        // 파일이 비어 있지 않다면 지정한 경로에 저장
        if (!uploadFile.isEmpty()) {
            uploadFile.transferTo(new File(realPath + newFileName));
        }

        // 데이터베이스 업데이트
        findPetSVC.updateFindPet(vo);
        String encodedCategory = URLEncoder.encode(vo.getCategory(), StandardCharsets.UTF_8.toString());
		String encodedKeyword = URLEncoder.encode(vo.getSearchKeyword(), StandardCharsets.UTF_8.toString());
		String encodedCondition = URLEncoder.encode(vo.getSearchCondition(), StandardCharsets.UTF_8.toString());
        
        return "redirect:/MIA/getFindPet?fp_seq=" + vo.getFp_seq() + "&nowPage=" + vo.getNowPage() + "&category="
		+ encodedCategory + "&searchKeyword=" + encodedKeyword + "&searchCondition="
		+ encodedCondition;
    }

    // 글 삭제
    @RequestMapping("/deleteFindPet")
    public String deleteFindPet(FindPetVO vo, HttpServletRequest request) {
        findPetSVC.deleteFindPet(vo);
        return "redirect:/MIA/getFindPetList";
    }

    // 글 상세 조회 + 댓글 조회
    @RequestMapping("/getFindPet")
    public String getFindPet(@RequestParam(value = "error", required = false) String error,
                             @RequestParam(value = "fp_seq") int seq, FindPetVO vo, Model model, FpCommentVO cvo,
                             @RequestParam(value = "nowPage", required = false) String nowPage,
                             @RequestParam(value = "category", required = false) String category) {

        vo.setFp_seq(seq);
        FindPetVO mfindPet = findPetSVC.getFindPet(vo);
        
        cvo.setFp_seq(seq);

        List<FpCommentVO> mfpCommentList = fpCommentSVC.getFpCommentList(cvo);

        if (!(error == null || error.equals(""))) {
            cntChk = 0;
        } else if (cntChk <= 0) {
            findPetSVC.updateFindPetCnt(mfindPet);
        } else {
            cntChk = 0;
        }

        model.addAttribute("nowPage", vo.getNowPage());
        model.addAttribute("searchKeyword", vo.getSearchKeyword());
        model.addAttribute("searchCondition", vo.getSearchCondition());
        model.addAttribute("category", vo.getCategory());
        model.addAttribute("findPet", mfindPet);
        model.addAttribute("fpComment", mfpCommentList);

        return "/WEB-INF/MIA/findPet/getFindPet.jsp";
    }

    // 글 목록
    @RequestMapping("/getFindPetList")
    public String getFindPetListPost(PagingVO pv, FindPetVO vo, Model model,
                                     @RequestParam(value = "nowPage", required = false, defaultValue = "1") Integer nowPage,
                                     @RequestParam(value = "category", required = false, defaultValue = "") String category) {
        // 페이지당 항목 수 설정
        int cntPerPage = 8;

        // 검색 조건과 키워드가 없을 때 기본값 설정
        if (vo.getSearchCondition() == null) {
            vo.setSearchCondition("TITLE");
        }
        if (vo.getSearchKeyword() == null) {
            vo.setSearchKeyword("");
        }

        // 전체 항목 개수 조회
        int total = findPetSVC.countFindPet(vo);

        // 페이징 객체 생성
        pv = new PagingVO(total, nowPage, cntPerPage);
        vo.setStart(pv.getStart());
        vo.setListcnt(cntPerPage);

        // 분실 반려동물 목록 조회
        List<FindPetVO> findPetList = findPetSVC.getFindPetList(vo);

        // 댓글 수 설정
        findPetSVC.countFpComment(findPetList);

        // 모델에 필요한 데이터 추가
        model.addAttribute("paging", pv);
        model.addAttribute("nowPage", nowPage);
        model.addAttribute("searchKeyword", vo.getSearchKeyword());
        model.addAttribute("searchCondition", vo.getSearchCondition());
        model.addAttribute("category", category);
        model.addAttribute("findPetList", findPetList);

        return "/WEB-INF/MIA/findPet/getFindPetList.jsp";
    }
    
    // 비회원 글 삭제
    @RequestMapping(value = "/deleteFindPetCheck", method = RequestMethod.GET)
    public String deleteCheck(@RequestParam(value = "error", required = false) String error,
                             @RequestParam(value = "fp_seq") int seq, FindPetVO vo, Model model) {

        vo.setFp_seq(seq);
        FindPetVO mfindPet = findPetSVC.getFindPet(vo);

        model.addAttribute("findPet", mfindPet);
        return "/WEB-INF/MIA/findPet/deleteFindPetCheck.jsp";
    }
    
    
    
    // 비회원 글 수정 
    @RequestMapping(value = "/updateFindPetCheck", method = RequestMethod.GET)
    public String updateCheck(@RequestParam(value = "error", required = false) String error,
                             @RequestParam(value = "fp_seq") int seq, FindPetVO vo, Model model,
                             @RequestParam(value = "nowPage", required = false) String nowPage,
                             @RequestParam(value = "category", required = false) String category) {

        vo.setFp_seq(seq);
        FindPetVO mfindPet = findPetSVC.getFindPet(vo);

        model.addAttribute("nowPage", vo.getNowPage());
        model.addAttribute("searchKeyword", vo.getSearchKeyword());
        model.addAttribute("searchCondition", vo.getSearchCondition());
        model.addAttribute("category", vo.getCategory());
        model.addAttribute("findPet", mfindPet);
        return "/WEB-INF/MIA/findPet/modifyFindPetCheck.jsp";
    }
}
