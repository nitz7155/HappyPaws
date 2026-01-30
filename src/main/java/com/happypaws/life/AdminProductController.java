package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.happypaws.svc.AdminProductSVC;
import com.happypaws.util.PagingVO;
import com.happypaws.vo.ProductOptionVO;
import com.happypaws.vo.ProductsVO;

//관리자 상품 관리 
@Controller
public class AdminProductController {
	@Autowired
	private AdminProductSVC svc;
	@Autowired
	private ServletContext servletContext;

	// 글목록 검색 옵션
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("내용", "CONTENT");
		conditionMap.put("제목", "TITLE");
		return conditionMap;
	}
	
	

	// 관리자 상품 추가 - 링크로 폼에 접근!
	@RequestMapping(value = "/ad_manageProductAdd", method = RequestMethod.GET)
	public String adManageProductAdd() {

		return "/WEB-INF/admin_product/admin_product_add.jsp";
	}

	// 관리자 상품 추가 - 등록 버튼 눌렀을 때!
	@RequestMapping(value = "/ad_manageProductAdd", method = RequestMethod.POST)
	public String adManageProductAdd(@RequestParam("pr_thumbnail_file") MultipartFile file, HttpServletRequest request,
			ProductsVO vo, ProductOptionVO opt, Model model, @RequestParam("pr_opt_name") List<String> prOptNames,
			@RequestParam("pr_opt_stock") List<Integer> prOptStocks,
			@RequestParam("pr_opt_price") List<Integer> prOptPrices, 
			@RequestParam("pr_opt_status") List<String> prOptStatuses, 
			@RequestParam("option_count") int optionCount) {
		try {
			vo.setPr_thumbnail(uploadFile(file, request)); // 썸네일 설정

			// 상품 등록 로직
			if (svc.addProduct(vo) > 0) {
				opt.setPr_id(svc.getProductId(vo));

				for (int i = 0; i < optionCount; i++) {
					opt.setPr_opt_id(i + 1);
					opt.setPr_opt_name(prOptNames.get(i)); // 옵션 이름 설정
					opt.setPr_opt_stock(prOptStocks.get(i)); // 옵션 재고 설정
					opt.setPr_opt_price(prOptPrices.get(i) + vo.getPr_price()); // 옵션 가격 설정
					opt.setPr_opt_status(prOptStatuses.get(i));// 옵션 상태 설정
					
					svc.addProductOption(opt);
				}
				model.addAttribute("productsList", svc.adminProductList(vo));
				model.addAttribute("productOption", svc.adminProductList(opt));
				return "redirect:ad_manageProductList";
			} else {
				return "redirect:ad_manageProductList";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:ad_manageProductList";
		}
	}

	// 관리자 상품 리스트!
	@RequestMapping(value = "/ad_manageProductList", method = RequestMethod.GET)
	public String adManageProductListGet(ProductsVO vo, PagingVO pv, Model model, ProductOptionVO opt,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "category", required = false) String category) {
		String cntPerPage = "10";
		if (vo.getSearchCondition() == null)
			vo.setSearchCondition("pr_id");
		else
			vo.setSearchCondition(vo.getSearchCondition());
		if (vo.getSearchKeyword() == null)
			vo.setSearchKeyword("");
		else
			vo.setSearchKeyword(vo.getSearchKeyword());

		if (category != null && !category.isEmpty()) {
			vo.setPr_category(category);
		}

		int total = svc.countProducts(vo);
		if (nowPage == null) {
			nowPage = "1";
		}

		pv = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", pv);

		vo.setStart(pv.getStart());
		vo.setListcnt(Integer.parseInt(cntPerPage));

		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", category);

		model.addAttribute("productsList", svc.adminProductList(vo));
		model.addAttribute("productOption", svc.adminProductList(opt));
		// 전체 목록에서 옵션을 보이도록 설정
		model.addAttribute("allOpt", svc.allOpts(opt));
		return "/WEB-INF/admin_product/admin_product_list.jsp";
	}

//	관리자 상품 리스트!
	@RequestMapping(value = "/ad_manageProductList", method = RequestMethod.POST)
	public String adManageProductListPost(ProductsVO vo, PagingVO pv, Model model, ProductOptionVO opt,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "category", required = false) String category) {
		String cntPerPage = "10";
		if (vo.getSearchCondition() == null)
			vo.setSearchCondition("pr_id");
		else
			vo.setSearchCondition(vo.getSearchCondition());
		if (vo.getSearchKeyword() == null)
			vo.setSearchKeyword("");
		else
			vo.setSearchKeyword(vo.getSearchKeyword());

		if (category != null && !category.isEmpty()) {
			vo.setPr_category(category);
		}

		int total = svc.countProducts(vo);
		if (nowPage == null) {
			nowPage = "1";
		}

		pv = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", pv);

		vo.setStart(pv.getStart());
		vo.setListcnt(Integer.parseInt(cntPerPage));
		vo.setPr_category(category);

		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", category);

		model.addAttribute("productsList", svc.adminProductList(vo));
		model.addAttribute("productOption", svc.adminProductList(opt));
		// 전체 목록에서 옵션을 보이도록 설정
		model.addAttribute("allOpt", svc.allOpts(opt));
		return "/WEB-INF/admin_product/admin_product_list.jsp";
	}

	// 관리자 상품 수정
	@RequestMapping(value = "/ad_manageProductModify", method = RequestMethod.GET)
	public String adManageProductModifyGet(ProductsVO vo, PagingVO pv, Model model, ProductOptionVO opt,
			@RequestParam(value = "nowPage", required = false) String nowPage) {
		// 상품가져옴
		model.addAttribute("product", svc.productModifyView(vo));
		// 옵션리스트 가져옴
		model.addAttribute("productOption", svc.adminProductList(opt));
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("nowPage", nowPage);
		return "/WEB-INF/admin_product/admin_product_modify.jsp";
	}

	// 상품 수정 폼 전송 - 1은 상품 수정, 2는 옵션 수정으로 진행
	@RequestMapping(value = "/ad_manageProductModify", method = RequestMethod.POST)
	public String adManageProductModifyPost(@RequestParam("pr_thumbnail_file") MultipartFile file,
			@RequestParam("existingThumbnail") String existingThumbnail, HttpServletRequest request, ProductsVO vo,
			ProductOptionVO opt, Model model, @RequestParam("pr_opt_name") List<String> prOptNames,
			@RequestParam("pr_opt_stock") List<Integer> prOptStocks,
			@RequestParam("pr_opt_price") List<Integer> prOptPrices,
			@RequestParam("pr_opt_status") List<String> prOptStatuses,
			@RequestParam("option_count") int optionCount,
			@RequestParam(value = "nowPage", required = false) String nowPage
		) {
		try {
			// 파일이 선택되지 않은 경우 기존 썸네일 경로 사용
			if (file != null && !file.isEmpty()) {
				vo.setPr_thumbnail(uploadFile(file, request)); // New! 파일 경로 설정
			} else {
				vo.setPr_thumbnail(existingThumbnail); // 기존 파일 경로 설정
			}

			// 1. 상품 수정
			svc.modifyProduct(vo);

			// 2-1. 옵션 삭제
			svc.deleteProductOpt(opt);

			// 2-2. 옵션 등록
			for (int i = 0; i < optionCount; i++) {
				opt.setPr_opt_id(i + 1);
				opt.setPr_opt_name(prOptNames.get(i)); // 옵션 이름 설정
				opt.setPr_opt_stock(prOptStocks.get(i)); // 옵션 재고 설정
				opt.setPr_opt_price(prOptPrices.get(i) + vo.getPr_price()); // 옵션 가격 설정
				opt.setPr_opt_status(prOptStatuses.get(i));// 옵션 상태 설정
				svc.addProductOption(opt);
			}
			model.addAttribute("productsList", svc.adminProductList(vo));
			model.addAttribute("productOption", svc.adminProductList(opt));
//			model.addAttribute("searchCondition", vo.getSearchCondition());
//			model.addAttribute("searchKeyword", vo.getSearchKeyword());
			
//			return "redirect:ad_manageProductList?nowPage=" + nowPage;
			
			String encodedCondition = URLEncoder.encode(vo.getSearchCondition(), StandardCharsets.UTF_8.toString());
	        String encodedKeyword = URLEncoder.encode(vo.getSearchKeyword(), StandardCharsets.UTF_8.toString());
	        
			return "redirect:ad_manageProductList?nowPage=" + nowPage
			           + "&searchCondition=" + encodedCondition
			           + "&searchKeyword=" + encodedKeyword;

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:ad_manageProductList?nowPage=" + nowPage;
		}
	}

	// 관리자 상품 삭제- 1: 상품 삭제, 2: 옵션 삭제
	@RequestMapping(value = "/deleteProduct", method = RequestMethod.GET)
	public String deleteProduct(ProductsVO vo, HttpServletRequest request,
//			public String deleteProduct(@RequestParam("pr_id") int pr_id, ProductsVO vo, HttpServletRequest request,
			ProductOptionVO opt, Model model, @RequestParam(value = "nowPage", required = false) String nowPage) {
		
		try {
		// 상대 경로 추가 시 realPath 추가
		String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/");
		if (vo.getPr_thumbnail() != null) {
//		
			File f = new File(realPath + vo.getPr_thumbnail());
			f.delete();
		}
		
//				
		String encodedCondition = URLEncoder.encode(vo.getSearchCondition(), StandardCharsets.UTF_8.toString());
		String encodedKeyword = URLEncoder.encode(vo.getSearchKeyword(), StandardCharsets.UTF_8.toString());
		String encodedCategory = URLEncoder.encode(vo.getPr_category(), StandardCharsets.UTF_8.toString());

		model.addAttribute("product",vo);
		// 1. 상품 삭제
		svc.deleteProduct(vo);
		// 2. 옵션 삭제
		svc.deleteProductOpt(opt);
		

        return "redirect:ad_manageProductList?nowPage=" + nowPage
		           + "&searchCondition=" + encodedCondition
		           + "&searchKeyword=" + encodedKeyword
		           + "&category=" + encodedCategory;
        
		}catch (Exception e) {
			e.printStackTrace();
			return "redirect:ad_manageProductList?nowPage=" + nowPage;
		}
		
	}

	// 사진 업로드 경로
	private String uploadFile(MultipartFile file, HttpServletRequest request) throws IOException {
		if (!file.isEmpty()) {
			// 파일 저장 경로 설정
			String realPath = servletContext.getRealPath("/resources/upload/");
			File uploadDir = new File(realPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			// 파일 이름 생성 (UUID로 중복 방지)
			String filename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
			File destinationFile = new File(realPath + filename);

			// 파일을 서버에 저장
			file.transferTo(destinationFile);

			return filename;
		}
		return "HappyPawsLogo.png"; // 기본 이미지 경로
	}
	
	@PostMapping("/productUpload")
	@ResponseBody
	public Map<String, String> uploadImage(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
		String uploadDir = servletContext.getRealPath("/resources/upload/");
		
	    String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	    File targetFile = new File(uploadDir, fileName);
	    
	    try {
	        file.transferTo(targetFile);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    // 클라이언트로 반환할 이미지 URL
	    String fileUrl = fileName;
	    
	    Map<String, String> response = new HashMap<>();
	    response.put("url", fileUrl);  // 이미지 URL을 클라이언트로 반환
	    return response;
	}
}