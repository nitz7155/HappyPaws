package com.happypaws.vo;

public class ProductVO {
	// PRODUCTS 테이블 컬럼들
	private int pr_id;                            
	private String pr_name;                     
	private String pr_desc;                                    
	private String pr_detail_desc;                                       
	private String pr_up_date;                                     
	private String pr_status;    
	private String pr_category;                                    
	private String pr_thumbnail;  
	private int pr_price;
	// PRODUCTS_OPTIONS 테이블 컬럼들
	private String us_id;
	private int pr_opt_id;
	private String pr_opt_name;                              
	private int pr_opt_stock;                                      
	private int pr_opt_price;
	// PRODUCTS_COMMENTS 테이블 컬럼들
	private int prc_no;
	private String prc_desc;
	private String prc_image;
	private int prc_rating;
	private String prc_start_date;
	private String prc_status;
	private String prc_review_deadline;
	// PRODUCTS_QNA 테이블 컬럼들
	private int prq_no;
	private String prq_desc;
	private String prq_comments;
	private String prq_lock;
	private String prq_status;
	private String prq_date;
	// PRODUCTS_SHOPPING_CARTS 테이블 컬럼들
	private int prsc_no;
	private int prsc_quantity;
	private int prsc_price;
    // PRODUCTS_ORDERS 테이블 컬럼들
	private String us_email;
    private int pror_master_id;          // 주문 마스터 번호
    private String pror_date;            // 주문 일시
    private String pror_status;          // 주문 상태
    private String pror_deli_stat;       // 배송 상태
    private String pror_recipient;       // 수령인
    private String pror_phone;           // 연락처
    private String pror_addr;            // 배송지 주소
    private String pror_addr_detail;     // 상세주소
    private String pror_zipcode;         // 우편번호
    private int pror_total_amt;          // 총 결제금액
    private int pror_ship_cost;          // 배송비
    private int pror_product_amt;        // 상품 총액
    private int pror_coupon_amt;         // 쿠폰 할인액
    private String pror_pay_method;      // 결제 수단
    private String pror_user_email;     // 주문자 이메일
    private String pror_user_id;     // 주문자 아이디
    private String merchant_uid;
    private String imp_uid;
    // PRODUCTS_ORDER_ITEMS 테이블 컬럼들
    private int pror_item_id;            // 주문상품 번호
    private int pror_item_qtt;           // 주문 수       
    private int pror_item_amt;           // 상품별 총 금액
    // PRODUCTS_WISHLIST 테이블 컬럼들
    private int prwl_no;          // 위시리스트 번호
    private String prwl_date;
	// 페이징, 검색 처리
	private String searchKeyword = "";
	private int rowFirst;
	private int rowSizePerPage;
	// 이미지 존재 여부 
	private boolean imageExists;
	// 정렬 타입을 저장할 필드
	private String sortType;  
	// 리뷰 개수를 저장할 필드 추가
	private int reviewCount; 
	// 평균 평점
	private double avgRating;
	// 기간 정렬(pr_order_list에 사용)
	private String startDate;
	private String endDate;
	// 결제 api 관련 필드
	private boolean success;          // 결제 성공 여부
	private String error_code;        // 결제 실패 코드
	private String error_msg;         // 결제 실패 메시지 
	private String paid_at;           // 결제 시각
	private String status;            // 결제 상태 (ready, paid, failed)
	private String pay_method;        // 결제수단 구분코드
	private String pg_provider;       // PG사 구분코드
	private String pg_tid;           // PG사 거래번호
	private String receipt_url;      // 영수증 URL
	private String custom_data;      // 커스텀 데이터
	
    private int review_count;      // 리뷰 수
    private int total_orders;      // 총 주문 수
    
    private String status_date;    // 배송상태 변경일
    private String old_status;     // 이전 배송상태
    private String new_status;     // 새로운 배송상태
	
	public int getPr_id() {
		return pr_id;
	}
	
	public void setPr_id(int pr_id) {
		this.pr_id = pr_id;
	}
	
	public String getPr_name() {
		return pr_name;
	}
	
	public void setPr_name(String pr_name) {
		this.pr_name = pr_name;
	}
	
	public String getPr_desc() {
		return pr_desc;
	}
	
	public void setPr_desc(String pr_desc) {
		this.pr_desc = pr_desc;
	}
	
	public String getPr_detail_desc() {
		return pr_detail_desc;
	}
	
	public void setPr_detail_desc(String pr_detail_desc) {
		this.pr_detail_desc = pr_detail_desc;
	}
	
	public String getPr_up_date() {
		return pr_up_date;
	}
	
	public void setPr_up_date(String pr_up_date) {
		this.pr_up_date = pr_up_date;
	}
	
	public String getPr_status() {
		return pr_status;
	}
	
	public void setPr_status(String pr_status) {
		this.pr_status = pr_status;
	}
	
	public String getPr_category() {
		return pr_category;
	}
	
	public void setPr_category(String pr_category) {
		this.pr_category = pr_category;
	}
	
	public String getPr_thumbnail() {
		return pr_thumbnail;
	}
	
	public void setPr_thumbnail(String pr_thumbnail) {
		this.pr_thumbnail = pr_thumbnail;
	}
	
	public int getPr_price() {
		return pr_price;
	}
	
	public void setPr_price(int pr_price) {
		this.pr_price = pr_price;
	}
	
	public String getUs_id() {
		return us_id;
	}

	public void setUs_id(String us_id) {
		this.us_id = us_id;
	}

	public int getPr_opt_id() {
		return pr_opt_id;
	}

	public void setPr_opt_id(int pr_opt_id) {
		this.pr_opt_id = pr_opt_id;
	}

	public String getPr_opt_name() {
		return pr_opt_name;
	}
	
	public void setPr_opt_name(String pr_opt_name) {
		this.pr_opt_name = pr_opt_name;
	}
	
	public int getPr_opt_stock() {
		return pr_opt_stock;
	}
	
	public void setPr_opt_stock(int pr_opt_stock) {
		this.pr_opt_stock = pr_opt_stock;
	}
	
	public int getPr_opt_price() {
		return pr_opt_price;
	}
	
	public void setPr_opt_price(int pr_opt_price) {
		this.pr_opt_price = pr_opt_price;
	}

	public int getPrc_no() {
		return prc_no;
	}

	public void setPrc_no(int prc_no) {
		this.prc_no = prc_no;
	}

	public String getPrc_desc() {
		return prc_desc;
	}

	public void setPrc_desc(String prc_desc) {
		this.prc_desc = prc_desc;
	}

	public String getPrc_image() {
		return prc_image;
	}

	public void setPrc_image(String prc_image) {
		this.prc_image = prc_image;
	}

	public int getPrc_rating() {
		return prc_rating;
	}

	public void setPrc_rating(int prc_rating) {
		this.prc_rating = prc_rating;
	}

	public String getPrc_start_date() {
		return prc_start_date;
	}

	public void setPrc_start_date(String prc_start_date) {
		this.prc_start_date = prc_start_date;
	}
	
	public String getPrc_status() {
		return prc_status;
	}

	public void setPrc_status(String prc_status) {
		this.prc_status = prc_status;
	}

	public String getPrc_review_deadline() {
		return prc_review_deadline;
	}

	public void setPrc_review_deadline(String prc_review_deadline) {
		this.prc_review_deadline = prc_review_deadline;
	}

	public int getPrq_no() {
		return prq_no;
	}

	public void setPrq_no(int prq_no) {
		this.prq_no = prq_no;
	}

	public String getPrq_desc() {
		return prq_desc;
	}

	public void setPrq_desc(String prq_desc) {
		this.prq_desc = prq_desc;
	}

	public String getPrq_comments() {
		return prq_comments;
	}

	public void setPrq_comments(String prq_comments) {
		this.prq_comments = prq_comments;
	}

	public String getPrq_lock() {
		return prq_lock;
	}

	public void setPrq_lock(String prq_lock) {
		this.prq_lock = prq_lock;
	}
	
	public String getPrq_status() {
		return prq_status;
	}

	public void setPrq_status(String prq_status) {
		this.prq_status = prq_status;
	}

	public String getPrq_date() {
		return prq_date;
	}

	public void setPrq_date(String prq_date) {
		this.prq_date = prq_date;
	}
	
	public int getPrsc_no() {
		return prsc_no;
	}

	public void setPrsc_no(int prsc_no) {
		this.prsc_no = prsc_no;
	}
	
	public int getPrsc_quantity() {
		return prsc_quantity;
	}

	public void setPrsc_quantity(int prsc_quantity) {
		this.prsc_quantity = prsc_quantity;
	}

	public int getPrsc_price() {
		return prsc_price;
	}

	public void setPrsc_price(int prsc_price) {
		this.prsc_price = prsc_price;
	}
	
	public String getUs_email() {
		return us_email;
	}

	public void setUs_email(String us_email) {
		this.us_email = us_email;
	}

	public int getPror_master_id() {
		return pror_master_id;
	}

	public void setPror_master_id(int pror_master_id) {
		this.pror_master_id = pror_master_id;
	}

	public String getPror_date() {
		return pror_date;
	}

	public void setPror_date(String pror_date) {
		this.pror_date = pror_date;
	}

	public String getPror_status() {
		return pror_status;
	}

	public void setPror_status(String pror_status) {
		this.pror_status = pror_status;
	}

	public String getPror_deli_stat() {
		return pror_deli_stat;
	}

	public void setPror_deli_stat(String pror_deli_stat) {
		this.pror_deli_stat = pror_deli_stat;
	}

	public String getPror_recipient() {
		return pror_recipient;
	}

	public void setPror_recipient(String pror_recipient) {
		this.pror_recipient = pror_recipient;
	}

	public String getPror_phone() {
		return pror_phone;
	}

	public void setPror_phone(String pror_phone) {
		this.pror_phone = pror_phone;
	}

	public String getPror_addr() {
		return pror_addr;
	}

	public void setPror_addr(String pror_addr) {
		this.pror_addr = pror_addr;
	}

	public String getPror_addr_detail() {
		return pror_addr_detail;
	}

	public void setPror_addr_detail(String pror_addr_detail) {
		this.pror_addr_detail = pror_addr_detail;
	}

	public String getPror_zipcode() {
		return pror_zipcode;
	}

	public void setPror_zipcode(String pror_zipcode) {
		this.pror_zipcode = pror_zipcode;
	}

	public int getPror_total_amt() {
		return pror_total_amt;
	}

	public void setPror_total_amt(int pror_total_amt) {
		this.pror_total_amt = pror_total_amt;
	}

	public int getPror_ship_cost() {
		return pror_ship_cost;
	}

	public void setPror_ship_cost(int pror_ship_cost) {
		this.pror_ship_cost = pror_ship_cost;
	}

	public int getPror_product_amt() {
		return pror_product_amt;
	}

	public void setPror_product_amt(int pror_product_amt) {
		this.pror_product_amt = pror_product_amt;
	}

	public int getPror_coupon_amt() {
		return pror_coupon_amt;
	}

	public void setPror_coupon_amt(int pror_coupon_amt) {
		this.pror_coupon_amt = pror_coupon_amt;
	}

	public String getPror_pay_method() {
		return pror_pay_method;
	}

	public void setPror_pay_method(String pror_pay_method) {
		this.pror_pay_method = pror_pay_method;
	}
	
	public String getPror_user_email() {
		return pror_user_email;
	}

	public void setPror_user_email(String pror_user_email) {
		this.pror_user_email = pror_user_email;
	}

	public String getPror_user_id() {
		return pror_user_id;
	}

	public void setPror_user_id(String pror_user_id) {
		this.pror_user_id = pror_user_id;
	}
	
	public String getMerchant_uid() {
		return merchant_uid;
	}

	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}

	public String getImp_uid() {
		return imp_uid;
	}

	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}

	public int getPror_item_id() {
		return pror_item_id;
	}

	public void setPror_item_id(int pror_item_id) {
		this.pror_item_id = pror_item_id;
	}

	public int getPror_item_qtt() {
		return pror_item_qtt;
	}

	public void setPror_item_qtt(int pror_item_qtt) {
		this.pror_item_qtt = pror_item_qtt;
	}

	public int getPror_item_amt() {
		return pror_item_amt;
	}
	
	public int getPrwl_no() {
		return prwl_no;
	}

	public void setPrwl_no(int prwl_no) {
		this.prwl_no = prwl_no;
	}

	public String getPrwl_date() {
		return prwl_date;
	}

	public void setPrwl_date(String prwl_date) {
		this.prwl_date = prwl_date;
	}

	public void setPror_item_amt(int pror_item_amt) {
		this.pror_item_amt = pror_item_amt;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public int getRowFirst() {
		return rowFirst;
	}

	public void setRowFirst(int rowFirst) {
		this.rowFirst = rowFirst;
	}

	public int getRowSizePerPage() {
		return rowSizePerPage;
	}

	public void setRowSizePerPage(int rowSizePerPage) {
		this.rowSizePerPage = rowSizePerPage;
	}

	public boolean isImageExists() {
		return imageExists;
	}

	public void setImageExists(boolean imageExists) {
		this.imageExists = imageExists;
	}

	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public double getAvgRating() {
		return avgRating;
	}

	public void setAvgRating(double avgRating) {
		this.avgRating = avgRating;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getError_code() {
		return error_code;
	}

	public void setError_code(String error_code) {
		this.error_code = error_code;
	}

	public String getError_msg() {
		return error_msg;
	}

	public void setError_msg(String error_msg) {
		this.error_msg = error_msg;
	}

	public String getPaid_at() {
		return paid_at;
	}

	public void setPaid_at(String paid_at) {
		this.paid_at = paid_at;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPay_method() {
		return pay_method;
	}

	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}

	public String getPg_provider() {
		return pg_provider;
	}

	public void setPg_provider(String pg_provider) {
		this.pg_provider = pg_provider;
	}

	public String getPg_tid() {
		return pg_tid;
	}

	public void setPg_tid(String pg_tid) {
		this.pg_tid = pg_tid;
	}

	public String getReceipt_url() {
		return receipt_url;
	}

	public void setReceipt_url(String receipt_url) {
		this.receipt_url = receipt_url;
	}

	public String getCustom_data() {
		return custom_data;
	}

	public void setCustom_data(String custom_data) {
		this.custom_data = custom_data;
	}

	public int getReview_count() {
		return review_count;
	}

	public void setReview_count(int review_count) {
		this.review_count = review_count;
	}

	public int getTotal_orders() {
		return total_orders;
	}

	public void setTotal_orders(int total_orders) {
		this.total_orders = total_orders;
	}

	public String getStatus_date() {
		return status_date;
	}

	public void setStatus_date(String status_date) {
		this.status_date = status_date;
	}

	public String getOld_status() {
		return old_status;
	}

	public void setOld_status(String old_status) {
		this.old_status = old_status;
	}

	public String getNew_status() {
		return new_status;
	}

	public void setNew_status(String new_status) {
		this.new_status = new_status;
	}
}