package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.Arrays;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.happypaws.svc.ProductSVC;
import com.happypaws.vo.ProductPagingVO;
import com.happypaws.vo.ProductVO;
import com.happypaws.vo.UsersVO;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Autowired
	private ProductSVC svc;
	
	@Autowired
	private ServletContext servletContext;
	
    // 인덱스 페이지에 보여주기
	@RequestMapping("/pr_index")
	@ResponseBody
	public List<ProductVO> productIndex() {
		return svc.productIndex();
	}
	
	@RequestMapping("/pr_list")
	public String productList(
	        @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
	        @RequestParam(value = "category", required = false) String category,
	        @RequestParam(value = "sortType", required = false, defaultValue = "latest") String sortType,
	        ProductVO vo, ProductPagingVO pv, Model model) {
	    
	    // 카테고리와 정렬 타입 설정
	    vo.setPr_category(category);
	    vo.setSortType(sortType);
	    
	    pv.setRowTotalCount(svc.getProductListCount(vo));
	    pv = new ProductPagingVO(pv);
	    
	    vo.setRowFirst(pv.getRowFirst());
	    vo.setRowSizePerPage(pv.getRowSizePerPage());
	    
	    // 상품 목록 가져오기
	    List<ProductVO> products = svc.getProductList(vo);
	    
	    // 각 상품에 대해 평균 평점과 리뷰 수를 계산
	    for (ProductVO product : products) {
	        List<ProductVO> reviews = svc.getProductReviewRating(product.getPr_id());
	        
	        double totalRating = 0.0;
	        for (ProductVO review : reviews) {
	            totalRating += review.getPrc_rating();
	        }
	        
	        // 평균 평점 계산 (소수점 한자리까지)
	        double avgRating = reviews.isEmpty() ? 0.0 : totalRating / reviews.size();
	        product.setAvgRating(Math.round(avgRating * 10.0) / 10.0);
	        
	        // 리뷰 개수 저장
	        product.setReviewCount(reviews.size());
	        
	        // 썸네일 이미지 존재 여부 체크
	        if (product.getPr_thumbnail() != null && !product.getPr_thumbnail().isEmpty()) {
	            String imagePath = servletContext.getRealPath("/resources/upload/") + product.getPr_thumbnail();
	            product.setImageExists(new File(imagePath).exists());
	        } else {
	            product.setImageExists(false);
	        }
	    }
	    
	    model.addAttribute("productList", products);
	    model.addAttribute("paging", pv);
	    model.addAttribute("searchKeyword", searchKeyword);
	    model.addAttribute("category", category);
	    model.addAttribute("sortType", sortType);
	    
	    return "/WEB-INF/product/pr_list.jsp";
	}
	
	@RequestMapping("/pr_detail")
	public String productDetail(@RequestParam(value = "pr_id", required = false) int pr_id, 
	        @RequestParam(value = "sortType", required = false, defaultValue = "latest") String sortType,
	        @RequestParam(value = "reviewPage", required = false, defaultValue = "1") int reviewPage,
	        @RequestParam(value = "inquiryPage", required = false, defaultValue = "1") int inquiryPage,
	        ProductVO vo, ProductPagingVO pv, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
	    
	    // 상품 상세 정보 먼저 조회
	    List<ProductVO> productDetail = svc.getProductDetail(pr_id);
	    
	    // 상품이 존재하지 않는 경우 처리
	    if (productDetail == null || productDetail.isEmpty()) {
	        // 에러 페이지로 리다이렉트하거나 적절한 메시지를 표시
	        return "redirect:/error";  // 또는 다른 처리 방법
	    }
	    
	    // 상품 썸네일 이미지 존재 여부 체크
	    if (productDetail.get(0).getPr_thumbnail() != null && !productDetail.get(0).getPr_thumbnail().isEmpty()) {
	        String imagePath = servletContext.getRealPath("/resources/upload/") + productDetail.get(0).getPr_thumbnail();
	        productDetail.get(0).setImageExists(new File(imagePath).exists());
	    } else {
	        productDetail.get(0).setImageExists(false);
	    }
	    
	    // 평균 평점 계산
	    int averageRating = 0;
	    List<ProductVO> reviewVO = svc.getProductReviewRating(pr_id); 
	    List<Integer> ratingList = new ArrayList<>();
	    
	    for (ProductVO rating : reviewVO) {
	        ratingList.add(rating.getPrc_rating());
	        averageRating += rating.getPrc_rating();
	    }
	    
	    int countRating = ratingList.size();
	    double averageRatingDouble = countRating > 0 ? (double) averageRating / countRating : 0;
	    averageRating = (int) (averageRatingDouble * 20);
	    
	    // 리뷰 페이징 처리
	    ProductPagingVO reviewPaging = new ProductPagingVO();
	    reviewPaging.setBtnCur(reviewPage);  // 현재 페이지 설정
	    reviewPaging.setRowSizePerPage(5); 
	    
	    // 'my' 정렬 시 로그인 체크 및 카운트 설정
	    if ("my".equals(sortType)) {
	        UsersVO user = (UsersVO) session.getAttribute("user");
	        if (user != null && !user.getUs_id().trim().isEmpty()) {
	            vo.setUs_id(user.getUs_id());
	            reviewPaging.setRowTotalCount(svc.getMyReviewCount(vo));
	        } else {
	            // 로그인하지 않은 경우 빈 결과만 처리하고 다른 정보는 유지
	            vo.setUs_id("");
	            reviewPaging.setRowTotalCount(0);
	            model.addAttribute("productReview", new ArrayList<>());
	            model.addAttribute("sortType", sortType);
	            model.addAttribute("pr_id", pr_id);
	            model.addAttribute("countRating", countRating);
	            model.addAttribute("averageRating", averageRating);
	            model.addAttribute("productDetail", productDetail);
	            model.addAttribute("reviewPaging", reviewPaging);
	            
	            // 문의 페이징 처리
	            ProductVO inquiryVO = new ProductVO();
	            inquiryVO.setPr_id(pr_id);
	            
	            ProductPagingVO inquiryPaging = new ProductPagingVO();
	            inquiryPaging.setBtnCur(inquiryPage);
	            inquiryPaging.setRowTotalCount(svc.getProductQuestionCount(pr_id));
	            inquiryPaging.setRowSizePerPage(5);
	            inquiryPaging = new ProductPagingVO(inquiryPaging);
	            
	            inquiryVO.setRowFirst(inquiryPaging.getRowFirst());
	            inquiryVO.setRowSizePerPage(inquiryPaging.getRowSizePerPage());
	            
	            model.addAttribute("productQuestion", svc.getProductQuestion(inquiryVO));
	            model.addAttribute("inquiryPaging", inquiryPaging);
	            
	            return "/WEB-INF/product/pr_detail.jsp";
	        }
	    } else {
	        reviewPaging.setRowTotalCount(svc.getProductReviewCount(vo.getPr_id()));
	    }
	    
	    reviewPaging = new ProductPagingVO(reviewPaging);
	    
	    // 리뷰 목록 조회를 위한 파라미터 설정
	    vo.setPr_id(pr_id);
	    vo.setSortType(sortType);
	    vo.setRowFirst(Math.max(0, reviewPaging.getRowFirst()));
	    vo.setRowSizePerPage(reviewPaging.getRowSizePerPage());
	    
	    // 리뷰 목록 조회
	    List<ProductVO> reviews = svc.getProductReview(vo);
	    
	    // 리뷰 이미지 존재 여부 체크
	    for (ProductVO review : reviews) {
	        if (review.getPrc_image() != null && !review.getPrc_image().isEmpty()) {
	            String imagePath = servletContext.getRealPath("/resources/upload/") + review.getPrc_image();
	            review.setImageExists(new File(imagePath).exists());
	        } else {
	            review.setImageExists(false);
	        }
	    }
	    
	    // 문의 페이징 처리
	    ProductVO inquiryVO = new ProductVO();
	    inquiryVO.setPr_id(pr_id);
	    
	    ProductPagingVO inquiryPaging = new ProductPagingVO();
	    inquiryPaging.setBtnCur(inquiryPage);
	    inquiryPaging.setRowTotalCount(svc.getProductQuestionCount(pr_id));
	    inquiryPaging.setRowSizePerPage(5);
	    inquiryPaging = new ProductPagingVO(inquiryPaging);
	    
	    inquiryVO.setRowFirst(inquiryPaging.getRowFirst());
	    inquiryVO.setRowSizePerPage(inquiryPaging.getRowSizePerPage());
	    
	    // Model에 데이터 추가
	    model.addAttribute("sortType", sortType);
	    model.addAttribute("pr_id", pr_id);
	    model.addAttribute("countRating", countRating);
	    model.addAttribute("averageRating", averageRating);
	    model.addAttribute("productDetail", productDetail);
	    model.addAttribute("productReview", reviews);
	    model.addAttribute("productQuestion", svc.getProductQuestion(inquiryVO));
	    model.addAttribute("reviewPaging", reviewPaging);
	    model.addAttribute("inquiryPaging", inquiryPaging);
	    
	    return "/WEB-INF/product/pr_detail.jsp";
	}
        
    @GetMapping("/getImage/{fileName}")
    @ResponseBody
    public ResponseEntity<byte[]> getImage(@PathVariable String fileName) {
        try {
            File file = new File(servletContext.getRealPath("/resources/upload/") + fileName);
            byte[] imageContent = Files.readAllBytes(file.toPath());
            
            HttpHeaders headers = new HttpHeaders();
            // 파일 확장자에 따라 적절한 MediaType 설정
            String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
            switch (fileExtension) {
                case "jpg":
                case "jpeg":
                    headers.setContentType(MediaType.IMAGE_JPEG);
                    break;
                case "png":
                    headers.setContentType(MediaType.IMAGE_PNG);
                    break;
                case "gif":
                    headers.setContentType(MediaType.IMAGE_GIF);
                    break;
                case "svg":
                    headers.setContentType(MediaType.valueOf("image/svg+xml"));
                    break;
                default:
                    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            }
            return new ResponseEntity<>(imageContent, headers, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    
    @PostMapping("/review_write")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> reviewWrite(
            @RequestParam(value = "prc_image", required = false) MultipartFile image,
            @RequestParam("pr_id") int pr_id,
            @RequestParam("pror_item_id") int pror_item_id,
            @RequestParam("pr_opt_id") int pr_opt_id,
            @RequestParam("pr_opt_name") String pr_opt_name,
            @RequestParam("prc_desc") String prc_desc,
            @RequestParam("prc_rating") int prc_rating,
            @RequestParam("pror_master_id") int pror_master_id,
            HttpSession session) {
        
        try {
            // 세션 체크
            UsersVO us = (UsersVO) session.getAttribute("user");
            if (us == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                                   .body(Map.of("error", "로그인이 필요합니다."));
            }

            ProductVO vo = new ProductVO();
            vo.setUs_id(us.getUs_id());
            vo.setPr_id(pr_id);
            vo.setPror_item_id(pror_item_id);
            vo.setPr_opt_id(pr_opt_id);
            vo.setPr_opt_name(pr_opt_name);
            vo.setPrc_desc(prc_desc);
            vo.setPrc_rating(prc_rating);
            vo.setPror_master_id(pror_master_id);

            // 날짜 관련 처리
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            Date currentDate = new Date();
            String currentDateStr = sdf.format(currentDate);
            
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(currentDate);
            calendar.add(Calendar.DAY_OF_MONTH, 31);
            String deadline = sdf.format(calendar.getTime());

            // 날짜 정보 설정
            vo.setPrc_start_date(currentDateStr);
            vo.setPrc_review_deadline(deadline);

            // 이미지 처리
            if (image != null && !image.isEmpty()) {
                String originalFileName = image.getOriginalFilename();
                String fileExtension = originalFileName.substring(
                    originalFileName.lastIndexOf(".")).toLowerCase();
                    
                if (!Arrays.asList(".jpg", ".jpeg", ".png", ".gif").contains(fileExtension)) {
                    return ResponseEntity.badRequest()
                            .body(Map.of("error", "허용되지 않는 파일 형식입니다. (jpg, jpeg, png, gif만 가능)"));
                }
                
                String newFileName = UUID.randomUUID().toString() + fileExtension;
                File uploadDir = new File(servletContext.getRealPath("/resources/upload/"));
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                File destFile = new File(servletContext.getRealPath("/resources/upload/") + newFileName);
                image.transferTo(destFile);
                vo.setPrc_image(newFileName);
            } else {
                vo.setPrc_image("");
            }

            // 리뷰 저장
            int checkSet = svc.setProductReview(vo);
            Map<String, Object> response = new HashMap<>();

            if (checkSet > 0) {
                response.put("success", true);
                response.put("message", "리뷰가 등록되었습니다.");
                
                // 평균 평점 계산
                List<ProductVO> reviewVO = svc.getProductReviewRating(pr_id);
                double averageRating = 0;
                int countRating = reviewVO.size();
                
                for (ProductVO rating : reviewVO) {
                    averageRating += rating.getPrc_rating();
                }
                averageRating = countRating > 0 ? (averageRating / countRating) * 20 : 0;
                
                // 이미지 존재 여부 체크
                vo.setImageExists(vo.getPrc_image() != null && !vo.getPrc_image().isEmpty());
                response.put("review", vo);
                response.put("averageRating", averageRating);
                response.put("countRating", countRating);
                
                return ResponseEntity.ok(response);               
            } else {
                // 실패 시 업로드된 이미지 삭제
                if (vo.getPrc_image() != null && !vo.getPrc_image().isEmpty()) {
                    File uploadedFile = new File(servletContext.getRealPath("/resources/upload/") + vo.getPrc_image());
                    if (uploadedFile.exists()) {
                        uploadedFile.delete();
                    }
                }
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(Map.of("error", "리뷰 등록에 실패했습니다."));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "서버 오류가 발생했습니다: " + e.getMessage()));
        }
    }
    
    @PostMapping("/review_remove")
    @ResponseBody
    public ResponseEntity<?> reviewRemove(@RequestParam("prc_no") int prc_no, HttpSession session) {
        try {
            // 세션 체크
            UsersVO us = (UsersVO) session.getAttribute("user");
            if (us == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            // 리뷰 삭제
            int checkDelete = svc.deleteProductReview(prc_no);
            if (checkDelete > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("리뷰 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }
    
    @PostMapping("/get_reviews")
    @ResponseBody
    public Map<String, Object> getReviews(@RequestParam("pr_id") int pr_id,
                                         @RequestParam("sortType") String sortType,
                                         @RequestParam("currentPage") int currentPage,
                                         HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            ProductVO vo = new ProductVO();
            vo.setPr_id(pr_id);
            vo.setSortType(sortType);
            
            // 페이징 처리
            ProductPagingVO reviewPaging = new ProductPagingVO();
            reviewPaging.setBtnCur(currentPage);
            reviewPaging.setRowSizePerPage(5);
            
            // 'my' 정렬 시 로그인 체크 및 카운트 설정
            if ("my".equals(sortType)) {
                UsersVO user = (UsersVO) session.getAttribute("user");
                if (user != null && !user.getUs_id().trim().isEmpty()) {
                    vo.setUs_id(user.getUs_id());
                    reviewPaging.setRowTotalCount(svc.getMyReviewCount(vo));
                } else {
                    response.put("error", "로그인이 필요합니다.");
                    return response;
                }
            } else {
                reviewPaging.setRowTotalCount(svc.getProductReviewCount(vo.getPr_id()));
            }
            
            reviewPaging = new ProductPagingVO(reviewPaging);
            
            vo.setRowFirst(reviewPaging.getRowFirst());
            vo.setRowSizePerPage(reviewPaging.getRowSizePerPage());
            
            List<ProductVO> reviews = svc.getProductReview(vo);
            
            // 리뷰 이미지 존재 여부 체크
            for (ProductVO review : reviews) {
                if (review.getPrc_image() != null && !review.getPrc_image().isEmpty()) {
                    String imagePath = servletContext.getRealPath("/resources/upload/") + review.getPrc_image();
                    review.setImageExists(new File(imagePath).exists());
                } else {
                    review.setImageExists(false);
                }
            }
            
            response.put("reviews", reviews);
            response.put("paging", reviewPaging);
            
        } catch (Exception e) {
            response.put("error", "리뷰를 불러오는 중 오류가 발생했습니다.");
        }
        
        return response;
    }
    
    @PostMapping("/question_write")
    public String inquiryWrite(ProductVO vo, HttpSession session) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        String currentDate = sdf.format(new Date());
        
        try {
            // 세션 체크
            UsersVO us = (UsersVO) session.getAttribute("user");
            if (us == null) {
                return "redirect:/auth/login";
            }

            // VO 설정
            vo.setUs_id(us.getUs_id());
            vo.setPrq_date(currentDate);
            
            // DB 저장
            int checkSet = svc.setProductQuestion(vo);
            if (checkSet > 0) {
                // 성공 시 문의하기 버튼으로 스크롤되도록 해시 추가
                return "redirect:/product/pr_detail?pr_id=" + vo.getPr_id() + "&tab=inquiries#write-inquiry-btn";
            } else {
                return "redirect:/product/pr_detail?pr_id=" + vo.getPr_id() + "&tab=inquiries";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/product/pr_detail?pr_id=" + vo.getPr_id() + "&tab=inquiries";
        }
    }
    
    @PostMapping("/question_remove")
    @ResponseBody
    public ResponseEntity<?> inquiryRemove(@RequestParam("prq_no") int prq_no, HttpSession session) {
        try {
            // 세션에서 사용자 정보 가져오기
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            // 문의 삭제
            int checkDelete = svc.deleteProductQuestion(prq_no);
            if (checkDelete > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("문의 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생했습니다.");
        }
    }
    
    @PostMapping("/question_answer_write")
    public String answerWrite(ProductVO vo, HttpSession session) {
        try {
            // 현재 날짜 설정
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            String currentDate = sdf.format(new Date());
            vo.setPrq_date(currentDate);
            
            // DB 저장
            int checkSet = svc.setProductQuestionComments(vo);
            if (checkSet > 0) {
                // 성공 시 문의하기 버튼으로 스크롤되도록 해시 추가
                return "redirect:/product/pr_detail?pr_id=" + vo.getPr_id() + "&tab=inquiries#write-inquiry-btn";
            } else {
                return "redirect:/product/pr_detail?pr_id=" + vo.getPr_id() + "&tab=inquiries";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/product/pr_detail?pr_id=" + vo.getPr_id() + "&tab=inquiries";
        }
    }

    @PostMapping("/add_to_cart")
    @ResponseBody
    public ResponseEntity<String> addToCart(@RequestBody ProductVO productData, HttpSession session) {
        try {
            // 세션에서 사용자 정보 가져오기
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            // ProductVO 객체 설정
            ProductVO cartItem = new ProductVO();
            cartItem.setUs_id(user.getUs_id());
            cartItem.setPr_id(productData.getPr_id());
            cartItem.setPr_thumbnail(productData.getPr_thumbnail());
            cartItem.setPr_name(productData.getPr_name());
            cartItem.setPr_opt_name(productData.getPr_opt_name());
            cartItem.setPr_opt_price(productData.getPr_opt_price());
            cartItem.setPrsc_quantity(productData.getPrsc_quantity());
            cartItem.setPrsc_price(productData.getPr_opt_price() * productData.getPrsc_quantity());

            // 중복 체크
            int duplicateCount = svc.checkCartDuplicate(cartItem);
            if (duplicateCount > 0) {
                return ResponseEntity.status(HttpStatus.CONFLICT).body("duplicate");
            }

            // 장바구니에 추가
            int result = svc.addToCart(cartItem);
            
            if (result > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("장바구니 추가 실패");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }
    
    @GetMapping("/pr_cart")
    public String viewCart(HttpSession session, Model model) {
        UsersVO user = (UsersVO) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";  // 로그인 페이지로 리다이렉트
        }
        
        // 장바구니 데이터 조회
        List<ProductVO> cartList = svc.getCartList(user.getUs_id());
        if (cartList != null) {
            // 썸네일 이미지 존재 여부 체크
            for (ProductVO item : cartList) {
                if (item.getPr_thumbnail() != null && !item.getPr_thumbnail().isEmpty()) {
                    String imagePath = servletContext.getRealPath("/resources/upload/") + item.getPr_thumbnail();
                    item.setImageExists(new File(imagePath).exists());
                } else {
                    item.setImageExists(false);
                }
            }
            model.addAttribute("cartList", cartList);
        }
        return "/WEB-INF/product/pr_cart.jsp";
    }

    @PostMapping("/update_cart_quantity")
    @ResponseBody
    public ResponseEntity<String> updateCartQuantity(@RequestBody ProductVO productData, HttpSession session) {
        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            productData.setUs_id(user.getUs_id());
            productData.setPrsc_price(productData.getPr_opt_price() * productData.getPrsc_quantity());
            
            int result = svc.updateCartQuantity(productData);
            
            if (result > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수량 변경 실패");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }

	@PostMapping("/remove_from_cart")
	@ResponseBody
	public ResponseEntity<String> removeFromCart(@RequestBody ProductVO productData, HttpSession session) {
	    try {
	        UsersVO user = (UsersVO) session.getAttribute("user");
	        if (user == null) {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
	        }

	        productData.setUs_id(user.getUs_id());
	        
	        int result = svc.removeFromCart(productData);
	        
	        if (result > 0) {
	            return ResponseEntity.ok("success");
	        } else {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
	        }
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
	    }
	}
	
	// 주문 처리
	@PostMapping("/pr_order")
	@ResponseBody
	public ResponseEntity<?> processOrder(@RequestBody List<ProductVO> orderItems, HttpSession session) {
	    try {
	        UsersVO user = (UsersVO) session.getAttribute("user");
	        if (user == null) {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
	        }

	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	        String orderDate = sdf.format(new Date());

	        String userEmail = svc.getUserEmail(user.getUs_id());
	        
	        // 주문 마스터 정보 설정
	        ProductVO masterVO = new ProductVO();
	        masterVO.setUs_id(user.getUs_id());
	        masterVO.setPror_date(orderDate);
	        masterVO.setPror_status("paid");
	        masterVO.setPror_deli_stat("preparation");
	        masterVO.setUs_email(userEmail);
	        
	        // 첫 번째 아이템의 배송 정보 설정
	        if (!orderItems.isEmpty()) {
	            ProductVO firstItem = orderItems.get(0);
	            masterVO.setPror_recipient(firstItem.getPror_recipient());
	            masterVO.setPror_phone(firstItem.getPror_phone());
	            masterVO.setPror_addr(firstItem.getPror_addr());
	            masterVO.setPror_addr_detail(firstItem.getPror_addr_detail());
	            masterVO.setPror_zipcode(firstItem.getPror_zipcode());
	            masterVO.setPror_pay_method(firstItem.getPror_pay_method());
	        }

	        // 총액 계산
	        int totalProductAmount = 0;
	        for (ProductVO item : orderItems) {
	            totalProductAmount += (item.getPr_opt_price() * item.getPror_item_qtt());
	            // 상품별 총액 설정
	            item.setPror_item_amt(item.getPr_opt_price() * item.getPror_item_qtt());
	            
	            String formattedName;
	            if (item.getPr_name().contains("[옵션:")) {
	                // 이미 옵션 정보가 포함된 경우 그대로 사용
	                formattedName = item.getPr_name().replaceAll("\\s+", " ").trim();
	            } else {
	                // 옵션 정보가 없는 경우에만 추가
	                formattedName = String.format("%s [옵션: %s]", 
	                    item.getPr_name().replaceAll("\\s+", " ").trim(), 
	                    item.getPr_opt_name().replaceAll("\\s+", " ").trim()
	                );
	            }
	            item.setPr_name(formattedName);
	        }

	        // 마스터 금액 정보 설정
	        masterVO.setPror_product_amt(totalProductAmount);
	        masterVO.setPror_ship_cost(3000);
	        masterVO.setPror_total_amt(totalProductAmount + masterVO.getPror_ship_cost());

	        // 주문 처리
	        int result = svc.setProductOrder(masterVO, orderItems);

	        if (result > 0) {
	            return ResponseEntity.ok().body(Map.of("success", true));
	        } else {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                               .body("주문 처리에 실패했습니다.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                           .body("주문 처리 중 오류가 발생했습니다.");
	    }
	}

	@PostMapping("/check_review_permission")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> checkReviewPermission(
	        @RequestParam("pr_id") int pr_id,
	        HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    
	    try {
	        UsersVO user = (UsersVO) session.getAttribute("user");
	        if (user == null) {
	            response.put("canWrite", false);
	            response.put("message", "로그인이 필요합니다.");
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
	        }
	        
	        ProductVO vo = new ProductVO();
	        vo.setUs_id(user.getUs_id());
	        vo.setPr_id(pr_id);
	        
	        // 배송완료된 주문건수 확인
	        int orderCount = svc.getDeliveredOrderCount(vo);
	        // 해당 상품의 작성된 리뷰 수 확인
	        int reviewCount = svc.getReviewCount(vo);
	        
	        // 리뷰 수가 주문건수보다 크거나 같으면 더 이상 리뷰를 작성할 수 없음
	        if (reviewCount >= orderCount) {
	            response.put("canWrite", false);
	            response.put("message", "리뷰를 작성할 수 있는 주문이 없습니다.");
	            return ResponseEntity.ok(response);
	        }
	        
	        // 아직 리뷰를 작성하지 않은 주문건 찾기
	        ProductVO purchaseInfo = svc.getPurchaseInfo(vo);
	        
	        if (purchaseInfo == null) {
	            response.put("canWrite", false);
	            response.put("message", "리뷰를 작성할 수 있는 주문이 없습니다.");
	            return ResponseEntity.ok(response);
	        }

	        response.put("canWrite", true);
	        response.put("purchaseInfo", purchaseInfo);
	        return ResponseEntity.ok(response);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("canWrite", false);
	        response.put("message", "오류가 발생했습니다.");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}
	
	// 주문내역 조회
	@GetMapping("/pr_order_list")
	public String orderList(
	        @RequestParam(value = "page", defaultValue = "1") int page,
	        @RequestParam(value = "period", defaultValue = "1w") String period,
	        @RequestParam(value = "startDate", required = false) String startDate,
	        @RequestParam(value = "endDate", required = false) String endDate,
	        @RequestParam(value = "tab", defaultValue = "orders") String tab,
	        ProductVO vo, ProductPagingVO pv,
	        Model model, 
	        HttpSession session) {
	    
	    UsersVO user = (UsersVO) session.getAttribute("user");
	    if (user == null) {
	        return "redirect:/auth/login";
	    }

	    vo.setUs_id(user.getUs_id());
	    
	    // 날짜 처리
	    LocalDate today = LocalDate.now();
	    LocalDate start;
	    LocalDate end = today;
	    
	    if (startDate != null && endDate != null) {
	        // 직접 날짜 입력한 경우
	        start = LocalDate.parse(startDate);
	        end = LocalDate.parse(endDate);
	    } else {
	        // 기간 버튼 클릭한 경우
	        switch (period) {
	            case "1w":
	                start = today.minusWeeks(1);
	                break;
	            case "1m":
	                start = today.minusMonths(1);
	                break;
	            case "3m":
	                start = today.minusMonths(3);
	                break;
	            case "6m":
	                start = today.minusMonths(6);
	                break;
	            case "1y":
	                start = today.minusYears(1);
	                break;
	            default:
	                start = today.minusWeeks(1); // 기본값은 1주일
	                break;
	        }
	    }
	    
	    // VO에 날짜 설정
	    vo.setStartDate(start.toString());
	    vo.setEndDate(end.toString());
	    
	    if ("wishlist".equals(tab)) {
	        // 위시리스트 데이터 조회
	        ProductPagingVO wishlistPaging = new ProductPagingVO();
	        wishlistPaging.setBtnCur(page);
	        wishlistPaging.setRowSizePerPage(10);  // 페이지당 표시할 항목 수
	        wishlistPaging.setRowTotalCount(svc.getWishlistCount(user.getUs_id()));
	        wishlistPaging = new ProductPagingVO(wishlistPaging);
	        
	        vo.setRowFirst(wishlistPaging.getRowFirst());
	        vo.setRowSizePerPage(wishlistPaging.getRowSizePerPage());
	        
	        List<ProductVO> wishlist = svc.getWishlist(vo);
	        // 각 위시리스트 아이템의 이미지 존재 여부 확인
	        for (ProductVO item : wishlist) {
	            if (item.getPr_thumbnail() != null && !item.getPr_thumbnail().isEmpty()) {
	                String imagePath = servletContext.getRealPath("/resources/upload/") + item.getPr_thumbnail();
	                item.setImageExists(new File(imagePath).exists());
	            } else {
	                item.setImageExists(false);
	            }
	        }
	        
	        model.addAttribute("wishlist", wishlist);
	        model.addAttribute("wishlistPaging", wishlistPaging);
	    } else {
	        // 주문 내역 데이터 조회
	        pv.setBtnCur(page);
	        pv.setRowTotalCount(svc.getOrderListCount(vo));
	        pv = new ProductPagingVO(pv);
	        
	        vo.setRowFirst(pv.getRowFirst());
	        vo.setRowSizePerPage(pv.getRowSizePerPage());
	        
	        List<ProductVO> orderList = svc.getProductOrderList(vo);
	        model.addAttribute("orderList", orderList);
	        model.addAttribute("paging", pv);
	    }

	    model.addAttribute("period", period);
	    model.addAttribute("startDate", start.toString());
	    model.addAttribute("endDate", end.toString());
	    model.addAttribute("activeTab", tab);
	    
	    return "/WEB-INF/product/pr_order_list.jsp";
	}
	
    // 주문 상세 정보 조회
	@GetMapping("/get_order_detail")
	@ResponseBody
	public ResponseEntity<?> getOrderDetail(@RequestParam("pror_master_id") int prorMasterId, HttpSession session) {
	    try {
	        // 세션에서 사용자 정보 확인
	        UsersVO user = (UsersVO) session.getAttribute("user");
	        if (user == null) {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
	        }

	        // 주문 정보 조회
	        ProductVO order = svc.getProductOrder(prorMasterId);
	        if (order == null) {
	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("주문을 찾을 수 없습니다.");
	        }
	        
	        // 주문한 사용자와 로그인한 사용자가 다른 경우 (관리자 제외)
	        if (!user.getUs_id().equals(order.getUs_id()) && !user.getUs_id().equals("admin")) {
	            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("접근 권한이 없습니다.");
	        }

	        // 주문 상품 목록 조회
	        List<ProductVO> orderItems = svc.getOrderItems(prorMasterId);
	        
	        Map<String, Object> response = new HashMap<>();
	        
	        String userEmail = svc.getUserEmail(user.getUs_id());
	        
	        // 주문 마스터 정보 설정
	        response.put("pror_master_id", order.getPror_master_id());
	        response.put("pror_date", order.getPror_date());
	        response.put("pror_status", order.getPror_status());
	        response.put("pror_deli_stat", order.getPror_deli_stat());
	        response.put("pror_recipient", order.getPror_recipient());
	        response.put("pror_phone", order.getPror_phone());
	        response.put("pror_addr", order.getPror_addr());
	        response.put("pror_addr_detail", order.getPror_addr_detail());
	        response.put("pror_zipcode", order.getPror_zipcode());
	        response.put("pror_total_amt", order.getPror_total_amt());
	        response.put("pror_ship_cost", order.getPror_ship_cost());
	        response.put("pror_product_amt", order.getPror_product_amt());
	        response.put("pror_pay_method", order.getPror_pay_method());
	        response.put("pror_email", userEmail);
	        // merchant_uid와 imp_uid 추가
	        response.put("merchant_uid", order.getMerchant_uid());
	        response.put("imp_uid", order.getImp_uid());

	        // 주문 상품 목록 설정
	        response.put("items", orderItems);

	        return ResponseEntity.ok(response);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("주문 정보를 불러오는데 실패했습니다.");
	    }
	}

    // 주문 상태 업데이트 (주문 취소)
    @PostMapping("/update_order_status")
    @ResponseBody
    public ResponseEntity<?> updateOrderStatus(@RequestBody ProductVO vo, HttpSession session) {
        try {
            // 세션에서 사용자 정보 확인
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            // 주문 정보 조회
            ProductVO order = svc.getProductOrder(vo.getPror_master_id());
            
            // 주문이 존재하지 않는 경우
            if (order == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("주문을 찾을 수 없습니다.");
            }
            
            // 주문한 사용자와 로그인한 사용자가 다른 경우 (관리자 제외)
            if (!user.getUs_id().equals(order.getUs_id()) && !user.getUs_id().equals("admin")) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("접근 권한이 없습니다.");
            }

            // 주문 취소 가능 여부 확인
            if (!order.getPror_status().equals("pending") && 
                !(order.getPror_status().equals("paid") && order.getPror_deli_stat().equals("preparation"))) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("취소할 수 없는 주문 상태입니다.");
            }

            // 주문 상태 업데이트
            vo.setUs_id(user.getUs_id());  // 사용자 ID 설정
            int result = svc.updateOrderStatus(vo);
            
            if (result > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("주문 상태 업데이트에 실패했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생했습니다.");
        }
    }

    // 주문 상품 목록 조회 메서드 추가
    @GetMapping("/get_order_items")
    @ResponseBody
    public ResponseEntity<?> getOrderItems(@RequestParam("pror_master_id") int prorMasterId, HttpSession session) {
        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            List<ProductVO> orderItems = svc.getOrderItems(prorMasterId);
            return ResponseEntity.ok(orderItems);
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생했습니다.");
        }
    }
    
    @PostMapping("/check_cart_item")
    @ResponseBody
    public Map<String, Boolean> checkCartItem(@RequestBody ProductVO vo, HttpSession session) {
        Map<String, Boolean> response = new HashMap<>();
        
        UsersVO user = (UsersVO) session.getAttribute("user");
        if (user == null) {
            response.put("exists", false);
            return response;
        }
        
        vo.setUs_id(user.getUs_id());
        int count = svc.checkCartDuplicate(vo);
        response.put("exists", count > 0);
        
        return response;
    }
    
    @GetMapping("/get_stock")
    @ResponseBody
    public ResponseEntity<Integer> getStock(@RequestParam int pr_id, @RequestParam String pr_opt_name) {
        try {
            int stock = svc.getProductStock(pr_id, pr_opt_name);
            return ResponseEntity.ok(stock);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(0);
        }
    }
    
    // 위시리스트 추가
    @PostMapping("/add_to_wishlist")
    @ResponseBody
    public ResponseEntity<String> addToWishlist(@RequestBody ProductVO productData, HttpSession session) {
        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            // 등록일 설정
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            productData.setUs_id(user.getUs_id());
            productData.setPrwl_date(sdf.format(new Date()));

            // 중복 체크
            if (svc.checkWishlistDuplicate(productData) > 0) {
                return ResponseEntity.status(HttpStatus.CONFLICT).body("duplicate");
            }

            // 위시리스트에 추가
            int result = svc.addToWishlist(productData);
            if (result > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("위시리스트 추가 실패");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }

    // 위시리스트 삭제
    @PostMapping("/remove_from_wishlist")
    @ResponseBody
    public ResponseEntity<String> removeFromWishlist(@RequestBody Map<String, List<Integer>> requestData, HttpSession session) {
        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            List<Integer> prwlNos = requestData.get("prwl_nos");
            if (prwlNos == null || prwlNos.isEmpty()) {
                return ResponseEntity.badRequest().body("삭제할 항목을 선택해주세요.");
            }

            for (Integer prwlNo : prwlNos) {
                ProductVO vo = new ProductVO();
                vo.setPrwl_no(prwlNo);
                vo.setUs_id(user.getUs_id());
                svc.removeFromWishlist(vo);
            }
            
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }

    // 위시리스트 조회
    @GetMapping("/get_wishlist")
    @ResponseBody
    public ResponseEntity<?> getWishlist(HttpSession session, ProductVO vo) {
        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            vo.setUs_id(user.getUs_id());
            List<ProductVO> wishlist = svc.getWishlist(vo);

            return ResponseEntity.ok(wishlist);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }
    
    @PostMapping("/check_review_exists")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkReviewExists(
        @RequestParam("pror_item_id") int pror_item_id,
        HttpSession session) {
        Map<String, Boolean> response = new HashMap<>();
        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
            }
            
            ProductVO vo = new ProductVO();
            vo.setUs_id(user.getUs_id());
            vo.setPror_item_id(pror_item_id);  // 주문상품번호만 전달
            
            boolean exists = svc.checkReviewExists(vo);
            response.put("exists", exists);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
    
    @PostMapping("/process_payment")
    @ResponseBody
    public ResponseEntity<?> processPayment(@RequestBody List<ProductVO> orderItems, HttpSession session) {
        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("success", false, "message", "로그인이 필요합니다."));
            }

            // 사용자 이메일 조회
            String userEmail = svc.getUserEmail(user.getUs_id());

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            String orderDate = sdf.format(new Date());

            // 주문 마스터 정보 설정
            ProductVO masterVO = new ProductVO();
            masterVO.setUs_id(user.getUs_id());
            masterVO.setUs_email(userEmail);
            masterVO.setPror_date(orderDate);
            masterVO.setPror_status("paid");
            masterVO.setPror_deli_stat("preparation");

            // 상품 총액 계산 및 주문 아이템 처리
            int totalProductAmount = 0;
            for (ProductVO item : orderItems) {
                totalProductAmount += (item.getPr_opt_price() * item.getPror_item_qtt());

                // 상품명에서 옵션 정보 제거
                String cleanProductName = item.getPr_name();
                if (cleanProductName.contains("[옵션:")) {
                    cleanProductName = cleanProductName.substring(0, cleanProductName.indexOf("[옵션:")).trim();
                }
                item.setPr_name(cleanProductName);

                // 주문 상품 정보 설정
                item.setPror_item_qtt(item.getPror_item_qtt());
                item.setPror_item_amt(item.getPr_opt_price() * item.getPror_item_qtt());
            }

            // 배송비 설정
            masterVO.setPror_ship_cost(3000);
            masterVO.setPror_product_amt(totalProductAmount);

            // 첫 번째 아이템의 정보 설정
            if (!orderItems.isEmpty()) {
                ProductVO firstItem = orderItems.get(0);
                masterVO.setPror_recipient(firstItem.getPror_recipient());
                masterVO.setPror_phone(firstItem.getPror_phone());
                masterVO.setPror_addr(firstItem.getPror_addr());
                masterVO.setPror_addr_detail(firstItem.getPror_addr_detail());
                masterVO.setPror_zipcode(firstItem.getPror_zipcode());
                masterVO.setPror_pay_method("card");
                masterVO.setMerchant_uid(firstItem.getMerchant_uid());
                masterVO.setImp_uid(firstItem.getImp_uid());
                masterVO.setPror_total_amt(firstItem.getPror_total_amt());
            }

            // 주문 처리
            int result = svc.setProductOrder(masterVO, orderItems);

            if (result > 0) {
                // 장바구니에서 주문된 상품들 삭제
                for (ProductVO item : orderItems) {
                    ProductVO cartItem = new ProductVO();
                    cartItem.setUs_id(user.getUs_id());
                    cartItem.setPr_id(item.getPr_id());
                    cartItem.setPr_opt_name(item.getPr_opt_name());
                    svc.removeFromCart(cartItem);
                }

                return ResponseEntity.ok().body(Map.of("success", true));
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(Map.of("success", false, "message", "주문 처리에 실패했습니다."));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("success", false, "message", "주문 처리 중 오류가 발생했습니다."));
        }
    }
    
    @PostMapping("/payCancel")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> cancelPayment(@RequestParam String merchant_uid, HttpSession session) {
        try {
            // 세션 체크
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of(
                            "success", false,
                            "message", "로그인이 필요합니다."
                        ));
            }

            // merchant_uid로 주문 정보 조회
            ProductVO order = svc.getOrderByMerchantUid(merchant_uid);
            if (order == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(Map.of(
                            "success", false,
                            "message", "주문 정보를 찾을 수 없습니다."
                        ));
            }

            // 주문 상태 확인
            if (!order.getPror_status().equals("paid") || !order.getPror_deli_stat().equals("preparation")) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of(
                            "success", false,
                            "message", "배송준비 상태의 주문만 취소가 가능합니다."
                        ));
            }

            // 포트원 토큰 발급 요청
            String token = getPortOneToken();
            
            // 결제 취소 API 호출
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setBearerAuth(token);
            
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("merchant_uid", merchant_uid);
            
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
            
            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<Map> response = restTemplate.exchange(
                "https://api.iamport.kr/payments/cancel",
                HttpMethod.POST,
                entity,
                Map.class
            );
            
            Map<String, Object> responseBody = response.getBody();
            int code = (int) responseBody.get("code");
            
            if (code == 0) {
                // 결제 취소 성공 시 DB 업데이트
                order.setPror_status("cancelled");
                int result = svc.updateOrderStatus(order);
                
                if (result > 0) {
                	// 결제 취소 후 수량 증가
                	svc.updateCancelled(merchant_uid);
                	
                    return ResponseEntity.ok(Map.of(
                        "success", true,
                        "message", "주문이 성공적으로 취소되었습니다."
                    ));
                } else {
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(Map.of(
                            "success", false,
                            "message", "주문 상태 업데이트에 실패했습니다."
                        ));
                }
            } else {
                String message = (String) responseBody.get("message");
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of(
                        "success", false,
                        "message", "결제 취소 실패: " + message
                    ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of(
                    "success", false,
                    "message", "결제 취소 중 오류가 발생했습니다."
                ));
        }
    }

    private String getPortOneToken() {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("imp_key", "6053608348155836");
        requestBody.put("imp_secret", "objyxt4w1LZ8thnxbLy1gkeofUpNFdzsP4FZMGgpnBoXA6wxEOMzjbMQPsp1MisLQrKb1rurJizxC1U9");
        
        HttpEntity<Map<String, String>> entity = new HttpEntity<>(requestBody, headers);
        
        ResponseEntity<Map> response = restTemplate.exchange(
            "https://api.iamport.kr/users/getToken",
            HttpMethod.POST,
            entity,
            Map.class
        );
        
        Map<String, Object> responseBody = response.getBody();
        Map<String, Object> responseData = (Map<String, Object>) responseBody.get("response");
        return (String) responseData.get("access_token");
    }
    
    @GetMapping("/getReviewStats")
    @ResponseBody
    public Map<String, Object> getReviewStats(@RequestParam("pr_id") int pr_id) {
        Map<String, Object> response = new HashMap<>();
        
        // 평균 평점 계산
        List<ProductVO> reviewVO = svc.getProductReviewRating(pr_id);
        int averageRating = 0;
        int countRating = reviewVO.size();
        
        for (ProductVO rating : reviewVO) {
            averageRating += rating.getPrc_rating();
        }
        
        double averageRatingDouble = countRating > 0 ? (double) averageRating / countRating : 0;
        averageRating = (int) (averageRatingDouble * 20);
        
        response.put("averageRating", averageRating);
        response.put("countRating", countRating);
        
        return response;
    }
    
    @PostMapping("/check_wishlist_item")
    @ResponseBody
    public Map<String, Boolean> checkWishlistItem(@RequestBody ProductVO vo, HttpSession session) {
        Map<String, Boolean> response = new HashMap<>();
        
        UsersVO user = (UsersVO) session.getAttribute("user");
        if (user == null) {
            response.put("exists", false);
            return response;
        }
        
        vo.setUs_id(user.getUs_id());
        int count = svc.checkWishlistDuplicate(vo);
        response.put("exists", count > 0);
        
        return response;
    }

    @PostMapping("/remove_all_from_cart")
    @ResponseBody
    public ResponseEntity<String> removeAllFromCart(@RequestBody List<Map<String, Object>> items, HttpSession session) {
        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            for (Map<String, Object> item : items) {
                ProductVO vo = new ProductVO();
                vo.setUs_id(user.getUs_id());
                
                Object prIdObj = item.get("pr_id");
                if (prIdObj instanceof String) {
                    vo.setPr_id(Integer.parseInt((String) prIdObj));
                } else if (prIdObj instanceof Number) {
                    vo.setPr_id(((Number) prIdObj).intValue());
                } else {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("잘못된 상품 ID 형식입니다.");
                }
                
                vo.setPr_opt_name((String)item.get("pr_opt_name"));
                svc.removeFromCart(vo);
            }

            return ResponseEntity.ok("success");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }

    @RequestMapping(value = "/mobile_process_payment", method = {RequestMethod.GET, RequestMethod.POST})
    public String processMobilePayment(
            @RequestParam(value = "imp_uid") String imp_uid,
            @RequestParam(value = "merchant_uid") String merchant_uid,
            @RequestParam(value = "imp_success", defaultValue = "false") boolean imp_success,
            @RequestParam(value = "selectedItems", required = false) String selectedItems,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return "redirect:/auth/login";
            }

            if (!imp_success) {
                redirectAttributes.addFlashAttribute("errorMessage", "결제가 취소되었습니다.");
                return "redirect:/product/pr_cart";
            }

            // 장바구니에서 선택된 상품 정보 조회
            List<ProductVO> orderItems = new ArrayList<>();
            int productTotalAmount = 0;

            if (selectedItems != null && !selectedItems.isEmpty()) {
                String[] items = selectedItems.split(",");
                for (String item : items) {
                    String[] parts = item.split("\\|");
                    if (parts.length == 2) {
                        int prId = Integer.parseInt(parts[0]);
                        String prOptName = parts[1];

                        // 장바구니에서 해당 상품 정보 조회
                        ProductVO cartItem = svc.getCartItem(user.getUs_id(), prId, prOptName);
                        if (cartItem != null) {
                            ProductVO orderItem = new ProductVO();
                            orderItem.setPr_id(cartItem.getPr_id());
                            orderItem.setPr_name(cartItem.getPr_name());
                            orderItem.setPr_opt_name(cartItem.getPr_opt_name());
                            orderItem.setPr_opt_price(cartItem.getPr_opt_price());
                            orderItem.setPror_item_qtt(cartItem.getPrsc_quantity());
                            orderItem.setPror_item_amt(cartItem.getPr_opt_price() * cartItem.getPrsc_quantity());
                            
                            orderItems.add(orderItem);
                            productTotalAmount += orderItem.getPror_item_amt();
                        }
                    }
                }
            }

            // 결제 정보 조회
            String token = getPortOneToken();
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(token);
            headers.setContentType(MediaType.APPLICATION_JSON);

            ResponseEntity<Map> paymentResponse = restTemplate.exchange(
                "https://api.iamport.kr/payments/" + imp_uid,
                HttpMethod.GET,
                new HttpEntity<>(headers),
                Map.class
            );

            Map<String, Object> paymentData = (Map<String, Object>) paymentResponse.getBody().get("response");

            String userEmail = svc.getUserEmail(user.getUs_id());
            
            // 주문 마스터 정보 설정
            ProductVO masterVO = new ProductVO();
            masterVO.setUs_id(user.getUs_id());
            masterVO.setUs_email(userEmail);
            masterVO.setPror_date(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()));
            masterVO.setPror_status("paid");
            masterVO.setPror_deli_stat("preparation");
            masterVO.setMerchant_uid(merchant_uid);
            masterVO.setImp_uid(imp_uid);
            masterVO.setPror_recipient((String) paymentData.get("buyer_name"));
            masterVO.setPror_phone((String) paymentData.get("buyer_tel"));
            masterVO.setPror_zipcode((String) paymentData.get("buyer_postcode"));

            // 주소 정보 처리
            String fullAddress = (String) paymentData.get("buyer_addr");
            String[] addressParts = fullAddress.split("\\s+");
            StringBuilder mainAddress = new StringBuilder();
            StringBuilder detailAddress = new StringBuilder();
            boolean isDetail = false;
            
            for (String part : addressParts) {
                if (part.contains("동") || part.contains("호") || part.matches("\\d{1,5}(-\\d{1,5})*")) {
                    isDetail = true;
                }
                if (isDetail) {
                    if (detailAddress.length() > 0) detailAddress.append(" ");
                    detailAddress.append(part);
                } else {
                    if (mainAddress.length() > 0) mainAddress.append(" ");
                    mainAddress.append(part);
                }
            }

            masterVO.setPror_addr(mainAddress.toString());
            masterVO.setPror_addr_detail(detailAddress.toString());
            masterVO.setPror_pay_method("card");
            masterVO.setPror_product_amt(productTotalAmount);
            masterVO.setPror_ship_cost(3000);
            masterVO.setPror_total_amt(((Number) paymentData.get("amount")).intValue());

            // 주문 처리
            int result = svc.setProductOrder(masterVO, orderItems);

            if (result > 0) {
                // 장바구니에서 주문한 상품 제거
                for (ProductVO orderItem : orderItems) {
                    ProductVO cartItem = new ProductVO();
                    cartItem.setUs_id(user.getUs_id());
                    cartItem.setPr_id(orderItem.getPr_id());
                    cartItem.setPr_opt_name(orderItem.getPr_opt_name());
                    svc.removeFromCart(cartItem);
                }

                redirectAttributes.addFlashAttribute("successMessage", "주문이 완료되었습니다.");
                return "redirect:/product/pr_order_list";
            } else {
                throw new RuntimeException("Order processing failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "주문 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/product/pr_cart";
        }
    }
    
    // 관리자 페이지 메인
    @GetMapping("/pr_admin")
    public String adminPage(
        @RequestParam(value = "page", defaultValue = "1") int page,
        @RequestParam(required = false) String tab,
        @RequestParam(required = false) String searchKeyword,
        Model model,
        HttpSession session) {

        UsersVO user = (UsersVO) session.getAttribute("user");
        if (user == null || !user.getUs_id().equals("admin")) {
            return "redirect:/auth/login";
        }

        try {
            // 검색어 처리
            ProductVO vo = new ProductVO();
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                vo.setSearchKeyword(searchKeyword);
            }

            // 페이징 기본 설정
            int pageSize = 10;
            String activeTab = (tab == null) ? "orders" : tab;
            
            switch(activeTab) {
	            case "inquiries":
	                ProductPagingVO inquiryPaging = new ProductPagingVO();
	                inquiryPaging.setBtnCur(page);
	                inquiryPaging.setRowSizePerPage(pageSize);
	                inquiryPaging.setRowTotalCount(svc.getProductQuestionTotalCount(vo)); // 총 개수 설정
	                inquiryPaging = new ProductPagingVO(inquiryPaging); // 페이징 정보 재계산
	                
	                vo.setRowFirst(inquiryPaging.getRowFirst());
	                vo.setRowSizePerPage(inquiryPaging.getRowSizePerPage());
	                
	                List<ProductVO> inquiries = svc.getAdminProductQuestion(vo);
	                model.addAttribute("inquiries", inquiries);
	                model.addAttribute("inquiryPaging", inquiryPaging);
	                break;

	            case "orders":
	                ProductPagingVO orderPaging = new ProductPagingVO();
	                orderPaging.setBtnCur(page);
	                orderPaging.setRowSizePerPage(pageSize);
	                orderPaging.setRowTotalCount(svc.getAdminOrderListCount(vo));
	                orderPaging = new ProductPagingVO(orderPaging);
	                
	                vo.setRowFirst(orderPaging.getRowFirst());
	                vo.setRowSizePerPage(orderPaging.getRowSizePerPage());
	                
	                List<ProductVO> orders = svc.getAdminProductOrderList(vo);
	                model.addAttribute("orders", orders);
	                model.addAttribute("orderPaging", orderPaging);
	                break;

                default: // reviews
                    ProductPagingVO reviewPaging = new ProductPagingVO();
                    reviewPaging.setBtnCur(page);
                    reviewPaging.setRowSizePerPage(pageSize);
                    reviewPaging.setRowTotalCount(svc.getProductReviewTotalCount(vo));
                    reviewPaging = new ProductPagingVO(reviewPaging);
                    
                    vo.setRowFirst(reviewPaging.getRowFirst());
                    vo.setRowSizePerPage(reviewPaging.getRowSizePerPage());
                    
                    List<ProductVO> reviews = svc.getAdminProductReview(vo);
                    model.addAttribute("reviews", reviews);
                    model.addAttribute("reviewPaging", reviewPaging); // 변경: paging -> reviewPaging
                    break;
            }
            
            // 공통 모델 속성 추가
            model.addAttribute("tab", activeTab);
            model.addAttribute("search", searchKeyword);
            
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 처리
        }

        return "/WEB-INF/product/pr_admin.jsp";
    }

    // 배송 상태 업데이트 (관리자용)
    @PostMapping("/update_delivery_status")
    @ResponseBody
    public ResponseEntity<String> updateDeliveryStatus(
            @RequestParam("pror_master_id") int orderId,
            @RequestParam("pror_deli_stat") String status,
            HttpSession session) {
        
        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null || !user.getUs_id().equals("admin")) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .header("Content-Type", "text/plain;charset=UTF-8")
                    .body("관리자만 접근 가능합니다.");
            }

            ProductVO vo = new ProductVO();
            vo.setPror_master_id(orderId);
            vo.setPror_deli_stat(status);
            
            // 현재 주문 상태 확인
            ProductVO currentOrder = svc.getProductOrder(orderId);
            if (currentOrder == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .header("Content-Type", "text/plain;charset=UTF-8")
                    .body("주문을 찾을 수 없습니다.");
            }
            
            // 취소된 주문인 경우
            if ("cancelled".equals(currentOrder.getPror_status())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .header("Content-Type", "text/plain;charset=UTF-8")
                    .body("취소된 주문은 배송상태를 변경할 수 없습니다.");
            }
            
            int result = svc.updateOrderDeliveryStatus(vo);
            if (result > 0) {
                return ResponseEntity.ok()
                    .header("Content-Type", "text/plain;charset=UTF-8")
                    .body("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .header("Content-Type", "text/plain;charset=UTF-8")
                    .body("배송상태 업데이트에 실패했습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .header("Content-Type", "text/plain;charset=UTF-8")
                .body("서버 오류가 발생했습니다.");
        }
    }

    // 문의 답변 관련 처리
    @PostMapping("/answer_inquiry")
    @ResponseBody
    public ResponseEntity<String> answerInquiry(
            @RequestParam("prq_no") int inquiryNo,
            @RequestParam("prq_comments") String answer,
            HttpSession session) {
        
        UsersVO user = (UsersVO) session.getAttribute("user");
        if (user == null || !user.getUs_id().equals("admin")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("관리자만 접근 가능합니다.");
        }
        
        try {
            ProductVO vo = new ProductVO();
            vo.setPrq_no(inquiryNo);
            vo.setPrq_comments(answer);
            vo.setPrq_date(new SimpleDateFormat("yyyy/MM/dd").format(new Date()));
            
            int result = svc.setProductQuestionComments(vo);
            return result > 0 ? ResponseEntity.ok("success") : ResponseEntity.badRequest().body("답변 등록 실패");
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생했습니다.");
        }
    }

    // 검색 기능
    @GetMapping("/admin_search")
    @ResponseBody
    public ResponseEntity<?> adminSearch(
            @RequestParam String keyword,
            @RequestParam String type,
            HttpSession session) {
        
        UsersVO user = (UsersVO) session.getAttribute("user");
        if (user == null || !user.getUs_id().equals("admin")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("관리자만 접근 가능합니다.");
        }
        
        try {
            ProductVO vo = new ProductVO();
            vo.setSearchKeyword(keyword);
            vo.setRowFirst(0);
            vo.setRowSizePerPage(10);
            
            Map<String, Object> response = new HashMap<>();
            
            switch (type) {
                case "reviews":
                    response.put("items", svc.getAdminProductReview(vo));
                    response.put("total", svc.getProductReviewTotalCount(vo));
                    break;
                case "inquiries":
                    response.put("items", svc.getAdminProductQuestion(vo));
                    response.put("total", svc.getProductQuestionTotalCount(vo));
                    break;
                case "orders":
                    response.put("items", svc.getAdminProductOrderList(vo));
                    response.put("total", svc.getAdminOrderListCount(vo));
                    break;
                default:
                    return ResponseEntity.badRequest().body("잘못된 검색 유형입니다.");
            }
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                               .body("검색 중 오류가 발생했습니다.");
        }
    }    
}