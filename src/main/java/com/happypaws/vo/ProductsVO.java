package com.happypaws.vo;

import org.springframework.web.multipart.MultipartFile;

public class ProductsVO {
	private int pr_id;                   // 상품 아이디
    private String pr_name;              // PR_NAME
    private String pr_desc;              // PR_DESC
    private String pr_detail_desc;       // PR_DETAIL_DESC
    private String pr_up_date;           // 상품 업로드 날짜
    private String pr_status;            // 디폴트 available
    private String pr_category;          // PR_CATEGORY
    private String pr_thumbnail;         // PR_THUMBNAIL
    private MultipartFile pr_thumbnail_file;
    private int pr_price;
    
    
    //검색기능
    private String searchCondition; 
	private String searchKeyword; 
	private int start;
	private int listcnt;
    
	
	
	public int getPr_price() {
		return pr_price;
	}
	public void setPr_price(int pr_price) {
		this.pr_price = pr_price;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getListcnt() {
		return listcnt;
	}
	public void setListcnt(int listcnt) {
		this.listcnt = listcnt;
	}
	public MultipartFile getPr_thumbnail_file() {
		return pr_thumbnail_file;
	}
	public void setPr_thumbnail_file(MultipartFile pr_thumbnail_file) {
		this.pr_thumbnail_file = pr_thumbnail_file;
	}
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
	
	
	@Override
	public String toString() {
		return "ProductsVO [pr_id=" + pr_id + ", pr_name=" + pr_name + ", pr_desc=" + pr_desc + ", pr_detail_desc="
				+ pr_detail_desc + ", pr_up_date=" + pr_up_date + ", pr_status=" + pr_status + ", pr_category="
				+ pr_category + ", pr_thumbnail=" + pr_thumbnail + ", pr_thumbnail_file=" + pr_thumbnail_file
				+ ", searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword + ", start=" + start
				+ ", listcnt=" + listcnt + "]";
	}
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
    
    
}
