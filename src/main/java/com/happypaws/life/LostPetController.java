package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.happypaws.svc.LostPetSVC;
import com.happypaws.svc.LpCommentSVC;
import com.happypaws.vo.LostPetVO;
import com.happypaws.vo.LpCommentVO;
import com.happypaws.vo.PagingVO;

@Controller
@RequestMapping("/MIA")
public class LostPetController {
	int cntChk = 0;

	@Autowired
	private LostPetSVC lostPetSVC;

	@Autowired
	private LpCommentSVC lpCommentSVC;

	@Autowired
    private ServletContext servletContext;
	
	// 글 등록
	@RequestMapping(value = "/insertLostPet", method = RequestMethod.GET)
	public String insertView(LostPetVO vo) throws IllegalStateException, IOException {
		return "/WEB-INF/MIA/lostPet/insertLostPet.jsp";
	}

	@RequestMapping(value = "/insertLostPet", method = RequestMethod.POST)
	public String insertLostPet(LostPetVO vo) throws IllegalStateException, IOException {
		
		MultipartFile uploadFile = vo.getUploadFile();
		String originalFilename = uploadFile.getOriginalFilename();
		String realPath = servletContext.getRealPath("/resources/MIA-img/lostPetImg/");
		// UUID를 사용하여 새로운 파일 이름 생성
		String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFilename;
		vo.setLp_img(uniqueFileName);

		// 파일을 지정한 경로에 저장
		uploadFile.transferTo(new File(realPath + uniqueFileName));

		lostPetSVC.insertLostPet(vo);
		return "redirect:/MIA/getLostPetList";
	}

	// 글 수정
	@RequestMapping(value = "/updateLostPet", method = RequestMethod.GET)
	public String updateView(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "lp_seq") int seq, LostPetVO vo, Model model,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "category", required = false) String category) {

		vo.setLp_seq(seq);
		LostPetVO mlostpet = lostPetSVC.getLostPet(vo);

		if (!(error == null || error.equals(""))) {
			cntChk = 0;
		} else if (cntChk <= 0) {
			lostPetSVC.updateLostPetCnt(mlostpet);
		} else {
			cntChk = 0;
		}

		model.addAttribute("nowPage", vo.getNowPage());
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", vo.getCategory());
		model.addAttribute("lostPet", mlostpet);
		return "/WEB-INF/MIA/lostPet/modifyLostPet.jsp";
	}

	@RequestMapping(value = "/updateLostPet", method = RequestMethod.POST)
	public String updateLostPet(LostPetVO vo, HttpSession session) throws IllegalStateException, IOException {
		MultipartFile uploadFile = vo.getUploadFile();
		String originalFilename = uploadFile.getOriginalFilename();
		String realPath = servletContext.getRealPath("/resources/MIA-img/lostPetImg/");
		// 현재 이미지 이름을 가져오는 서비스 메서드
		String existingImg = lostPetSVC.getCurrentImage(vo.getLp_seq());
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

		vo.setLp_img(newFileName);

		// 파일이 비어 있지 않다면 지정한 경로에 저장
		if (!uploadFile.isEmpty()) {
			uploadFile.transferTo(new File(realPath + newFileName));
		}

		// 데이터베이스 업데이트
		lostPetSVC.updateLostPet(vo);
		String encodedCategory = URLEncoder.encode(vo.getCategory(), StandardCharsets.UTF_8.toString());
		String encodedKeyword = URLEncoder.encode(vo.getSearchKeyword(), StandardCharsets.UTF_8.toString());
		String encodedCondition = URLEncoder.encode(vo.getSearchCondition(), StandardCharsets.UTF_8.toString());
		
		return "redirect:/MIA/getLostPet?lp_seq=" + vo.getLp_seq() + "&nowPage=" + vo.getNowPage() + "&category="
				+ encodedCategory + "&searchKeyword=" + encodedKeyword + "&searchCondition="
				+ encodedCondition;
	}

	// 글 삭제
	@RequestMapping("/deleteLostPet")
	public String deleteLostPet(LostPetVO vo, HttpServletRequest request) {
		lostPetSVC.deleteLostPet(vo);
		return "redirect:/MIA/getLostPetList";
	}

	// 글 상세 조회 + 댓글 조회
	@RequestMapping("/getLostPet")
	public String getLostPet(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "lp_seq") int seq, LostPetVO vo, Model model, LpCommentVO cvo,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "category", required = false) String category) {

		vo.setLp_seq(seq);
		LostPetVO mlostpet = lostPetSVC.getLostPet(vo);

		cvo.setLp_seq(seq);
		List<LpCommentVO> mlpCommentlist = lpCommentSVC.getLpCommentList(cvo);

		if (!(error == null || error.equals(""))) {
			cntChk = 0;
		} else if (cntChk <= 0) {
			lostPetSVC.updateLostPetCnt(mlostpet);
		} else {
			cntChk = 0;
		}

		// 사례금 포맷 적용
		NumberFormat numberFormat = NumberFormat.getInstance(Locale.KOREA);
		mlostpet.setFormattedReward(numberFormat.format(mlostpet.getLp_reward()));

		model.addAttribute("nowPage", vo.getNowPage());
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", vo.getCategory());
		model.addAttribute("lostPet", mlostpet);
		model.addAttribute("lpComment", mlpCommentlist);
		return "/WEB-INF/MIA/lostPet/getLostPet.jsp";
	}

	// 글 목록
	@RequestMapping("/getLostPetList")
	public String getLostPetListPost(PagingVO pv, LostPetVO vo, Model model,
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
		int total = lostPetSVC.countLostPet(vo);

		// 페이징 객체 생성
		pv = new PagingVO(total, nowPage, cntPerPage);
		vo.setStart(pv.getStart());
		vo.setListcnt(cntPerPage);

		// 분실 반려동물 목록 조회
		List<LostPetVO> lostPetList = lostPetSVC.getLostPetList(vo);

		// 댓글 수 설정
		lostPetSVC.countLpComment(lostPetList);

		// 사례금 포맷 적용
		NumberFormat numberFormat = NumberFormat.getInstance(Locale.KOREA);
		for (LostPetVO lostPet : lostPetList) {
			lostPet.setFormattedReward(numberFormat.format(lostPet.getLp_reward()));
		}

		// 모델에 필요한 데이터 추가
		model.addAttribute("paging", pv);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", category);
		model.addAttribute("lostPetList", lostPetList);

		return "/WEB-INF/MIA/lostPet/getLostPetList.jsp";
	}
	
	//인덱스 글 목록
	@ResponseBody
	@RequestMapping(value = "/getLostPetListIndex", method = RequestMethod.GET)
	public List<LostPetVO> getLostPetListIndex(LostPetVO vo) {
		// 분실 반려동물 목록 조회
		List<LostPetVO> lostPetList = lostPetSVC.getLostPetList();
		return lostPetList;
	}		
}