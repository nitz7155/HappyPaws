package com.happypaws.svc;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.happypaws.dao.ProductDAO;
import com.happypaws.vo.ProductVO;

@Service
public class ProductSVC {
	@Autowired
	private ProductDAO dao;
	
	@Autowired
	private ServletContext servletContext;
	
	public int getProductListCount(ProductVO vo) {
		return dao.getProductListCount(vo);
	}
	
	public List<ProductVO> getProductList(ProductVO vo) {
		return dao.getProductList(vo);
	}
	
	public List<ProductVO> getProductDetail(int pr_id) {
		return dao.getProductDetail(pr_id);
	}

	public int getProductReviewCount(int pr_id) {
		return dao.getProductReviewCount(pr_id);
	}
	
	public List<ProductVO> getProductReviewRating(int pr_id) {
		return dao.getProductReviewRating(pr_id);
	}	
	
	public List<ProductVO> getProductReview(ProductVO vo) {
		return dao.getProductReview(vo);
	}
	
	public int getMyReviewCount(ProductVO vo) {
		return dao.getMyReviewCount(vo);
	}
	
	public int deleteProductReview(int prc_no) {
		return dao.deleteProductReview(prc_no);
	}
	
	@Transactional
	public int setProductReview(ProductVO vo) {
	    // 기존 리뷰 삭제
	    dao.deleteExistingReview(vo);
	    // 새 리뷰 추가
	    return dao.setProductReview(vo);
	}
	
	public List<ProductVO> getProductQuestion(ProductVO vo) {
		return dao.getProductQuestion(vo);
	}
	
	public int setProductQuestion(ProductVO vo) {
		return dao.setProductQuestion(vo);
	}
	
	public int deleteProductQuestion(int prq_no) {
		return dao.deleteProductQuestion(prq_no);
	}	
	
	public int setProductQuestionComments(ProductVO vo) {
		return dao.setProductQuestionComments(vo);
	}
	
	public int getProductQuestionCount(int pr_id) {
		return dao.getProductQuestionCount(pr_id);
	}
	
	public int addToCart(ProductVO vo) {
		return dao.addToCart(vo);
	}
	
	public List<ProductVO> getCartList(String us_id) {
		return dao.getCartList(us_id);
	}
	
	public int updateCartQuantity(ProductVO vo) {
		return dao.updateCartQuantity(vo);
	}
	
	public int removeFromCart(ProductVO vo) {
		return dao.removeFromCart(vo);
	}
	
	public int checkCartDuplicate(ProductVO vo) {
	    return dao.checkCartDuplicate(vo);
	}
	
    // 주문 등록 (트랜잭션 처리를 위해 @Transactional 추가)
    @Transactional
    public int setProductOrder(ProductVO masterVO, List<ProductVO> orderItems) {
        try {
            // 1. 주문 마스터 등록
            int result = dao.setProductOrder(masterVO);
            if (result <= 0) return 0;
            
            // 2. 주문 상세 등록 및 재고 감소
            for (ProductVO item : orderItems) {
                item.setPror_master_id(masterVO.getPror_master_id());
                item.setUs_id(masterVO.getUs_id());
                
                // 주문 상세 등록
                result = dao.setProductOrderItem(item);
                if (result <= 0) return 0;
                
                // 재고 감소
                result = dao.updateProductStock(item);
                if (result <= 0) return 0;
                
                // 상품 상태 업데이트
                result = dao.updateProductStatus(item.getPr_id());
                if (result <= 0) return 0;
                
                // 장바구니에서 주문된 상품 제거
                dao.deleteCartAfterOrder(item);
            }
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;  // 트랜잭션 롤백을 위해 예외 다시 throw
        }
    }
    
    // 주문 조회
    public ProductVO getProductOrder(int pror_master_id) {
        return dao.getProductOrder(pror_master_id);
    }
    
    // 사용자별 주문 목록 조회
    public List<ProductVO> getProductOrderList(ProductVO vo) {
        return dao.getProductOrderList(vo);
    }
    
    // 주문 상태 업데이트
    public int updateOrderStatus(ProductVO vo) {
        return dao.updateOrderStatus(vo);
    }

	// 주문 완료된 상품 장바구니에서 제거
	public int deleteCartAfterOrder(ProductVO vo) {
		return dao.deleteCartAfterOrder(vo);
	}	
	
    // 구매 이력 확인 (리뷰 작성 권한 확인용)
	public boolean canWriteReview(ProductVO vo) {
	    // 구매 이력 확인 (paid 상태인 주문만)
	    int purchaseCount = dao.checkPurchaseHistory(vo);
	    // 리뷰 작성 이력 확인
	    int reviewCount = dao.checkReviewHistory(vo);
	    
	    return purchaseCount > 0 && reviewCount == 0;
	}
	
	public int checkPurchaseHistory(ProductVO vo) {
	    return dao.checkPurchaseHistory(vo);
	}
	
	public int checkReviewHistory(ProductVO vo) {
	    return dao.checkReviewHistory(vo);
	}
	
	public ProductVO getPurchaseInfo(ProductVO vo) {
	    return dao.getPurchaseInfo(vo);
	}
	
	public int getOrderListCount(ProductVO vo) {
	    return dao.getOrderListCount(vo);
	}
	
    // 주문 상품 목록 조회
    public List<ProductVO> getOrderItems(int pror_master_id) {
        return dao.getOrderItems(pror_master_id);
    }
    
    public int getProductStock(int pr_id, String pr_opt_name) {
        return dao.getProductStock(pr_id, pr_opt_name);
    }
    
    public ProductVO getExistingReview(ProductVO vo) {
        return dao.getExistingReview(vo);
    }
    
    // 위시리스트 관련 메서드 추가
    public int addToWishlist(ProductVO vo) {
        return dao.addToWishlist(vo);
    }

    public int removeFromWishlist(ProductVO vo) {
        return dao.removeFromWishlist(vo);
    }

    public int checkWishlistDuplicate(ProductVO vo) {
        return dao.checkWishlistDuplicate(vo);
    }

    public List<ProductVO> getWishlist(ProductVO vo) {
        List<ProductVO> wishlist = dao.getWishlist(vo);
        // 이미지 존재 여부 체크
        for (ProductVO item : wishlist) {
            if (item.getPr_thumbnail() != null && !item.getPr_thumbnail().isEmpty()) {
                String imagePath = servletContext.getRealPath("/resources/upload/") + item.getPr_thumbnail();
                item.setImageExists(new File(imagePath).exists());
            } else {
                item.setImageExists(false);
            }
        }
        return wishlist;
    }

    // 위시리스트 페이징을 위한 카운트 조회
    public int getWishlistCount(String us_id) {
        return dao.getWishlistCount(us_id);
    }
    
    public boolean checkReviewExists(ProductVO vo) {
        return dao.checkReviewExists(vo);
    }
    
    public String getUserEmail(String us_id) {
        return dao.getUserEmail(us_id);
    }
    
    public ProductVO getOrderByMerchantUid(String merchantUid) {
        return dao.getOrderByMerchantUid(merchantUid);
    }
    
    public ProductVO getNextPurchaseInfo(ProductVO vo) {
        return dao.getNextPurchaseInfo(vo);
    }
    
    public int getReviewCount(ProductVO vo) {
        return dao.getReviewCount(vo);
    }
    
    public int getDeliveredOrderCount(ProductVO vo) {
        return dao.getDeliveredOrderCount(vo);
    }
    
    public ProductVO getReviewById(int prc_no) {
        return dao.getReviewById(prc_no);
    }
    
    public ProductVO getCartItem(String usId, int prId, String prOptName) {
        return dao.getCartItem(usId, prId, prOptName);
    }
    
    // 인덱스 페이지에 보여주기
    public List<ProductVO> productIndex() {
        return dao.productIndex();
    }

    // 관리자용 리뷰 목록 조회
    public List<ProductVO> getAdminProductReview(ProductVO vo) {
        List<ProductVO> reviews = dao.getAdminProductReview(vo);
        return reviews;
    }

    // 관리자용 문의 목록 조회
    public List<ProductVO> getAdminProductQuestion(ProductVO vo) {
        List<ProductVO> inquiries = dao.getAdminProductQuestion(vo);
        return inquiries;
    }

    // 관리자용 주문 목록 조회
    public List<ProductVO> getAdminProductOrderList(ProductVO vo) {
        return dao.getAdminProductOrderList(vo);
    }

    // 배송 상태 업데이트
    public int updateOrderDeliveryStatus(ProductVO vo) {
        return dao.updateOrderDeliveryStatus(vo);
    }

    // 리뷰 총 갯수 조회 (검색 조건 포함)
    public int getProductReviewTotalCount(ProductVO vo) {
        return dao.getProductReviewTotalCount(vo);
    }

    // 관리자용 주문 총 갯수 조회 (검색 조건 포함)
    public int getAdminOrderListCount(ProductVO vo) {
        return dao.getAdminOrderListCount(vo);
    }

    // 리뷰 파일 삭제 처리
    private void deleteReviewImage(int prc_no) {
        ProductVO review = getReviewById(prc_no);
        if(review != null && review.getPrc_image() != null && !review.getPrc_image().isEmpty()) {
            File imageFile = new File(servletContext.getRealPath("/resources/upload/") + review.getPrc_image());
            if(imageFile.exists()) {
                imageFile.delete();
            }
        }
    }

    // 리뷰 삭제 (이미지 파일도 함께 삭제)
    @Transactional
    public int adminDeleteReview(int prc_no) {
        deleteReviewImage(prc_no);
        return dao.deleteProductReview(prc_no);
    }

    // 문의 답변 업데이트
    public int updateQuestionAnswer(ProductVO vo) {
        return dao.updateQuestionAnswer(vo);
    }

    // 주문 상세 정보 조회 (관리자용)
    public Map<String, Object> getAdminOrderDetail(int orderId) {
        Map<String, Object> result = new HashMap<>();
        
        // 주문 마스터 정보 조회
        ProductVO orderMaster = dao.getProductOrder(orderId);
        if(orderMaster != null) {
            // 주문 상세 목록 조회
            List<ProductVO> orderItems = dao.getOrderItems(orderId);
            
            result.put("master", orderMaster);
            result.put("items", orderItems);
        }
        
        return result;
    }

    // 배송상태 이력 저장
    public int insertDeliveryStatusHistory(ProductVO vo) {
        vo.setStatus_date(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()));
        return dao.insertDeliveryStatusHistory(vo);
    }

    // 주문 상태별 통계
    public Map<String, Object> getOrderStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        // 결제상태별 주문 수
        stats.put("paymentStats", dao.getPaymentStatusStats());
        
        // 배송상태별 주문 수
        stats.put("deliveryStats", dao.getDeliveryStatusStats());
        
        // 오늘의 주문/취소 현황
        stats.put("todayStats", dao.getTodayOrderStats());
        
        return stats;
    }

    // 기간별 매출 통계
    public List<Map<String, Object>> getSalesStatsByPeriod(String startDate, String endDate) {
        Map<String, String> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        return dao.getSalesStatsByPeriod(params);
    }

    // 특정 상품의 리뷰 평균 평점
    public double getProductAverageRating(int pr_id) {
        List<ProductVO> reviews = dao.getProductReviewRating(pr_id);
        if(reviews == null || reviews.isEmpty()) {
            return 0.0;
        }
        
        double totalRating = 0;
        for(ProductVO review : reviews) {
            totalRating += review.getPrc_rating();
        }
        
        return totalRating / reviews.size();
    }

    // 상품별 문의 응답률
    public Map<String, Object> getInquiryResponseRate(int pr_id) {
        Map<String, Object> result = new HashMap<>();
        
        int totalCount = dao.getProductQuestionCount(pr_id);
        int answeredCount = dao.getAnsweredQuestionCount(pr_id);
        
        result.put("totalCount", totalCount);
        result.put("answeredCount", answeredCount);
        result.put("responseRate", totalCount > 0 ? (double)answeredCount/totalCount * 100 : 0);
        
        return result;
    } 
    
    // ProductSVC에 추가할 메서드
    public int getProductQuestionTotalCount(ProductVO vo) {
        return dao.getProductQuestionTotalCount(vo);
    }
    
    public void updateCancelled(String merchant_uid) {
    	dao.updateCancelled(merchant_uid);
    }
}
