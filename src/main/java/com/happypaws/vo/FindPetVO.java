package com.happypaws.vo;

import org.springframework.web.multipart.MultipartFile;

public class FindPetVO {

	private int fp_seq;         
    private String fp_id;        
    private String fp_code;      
    private String fp_title;     
    private String fp_ph;        
    private String fp_place;     
    private String fp_time;      
    private String fp_category;  
    private String fp_breed;     
    private String fp_content;   
    private String fp_date;      
    private int fp_cnt;         
    private String fp_login;     
    private String fp_ok;        
    private String fp_del;       
	
	private String nowPage;
	private String searchCondition;
	private String searchKeyword;
	private String category;

	private MultipartFile uploadFile;
	private String fp_img;

	private int start;
	private int listcnt;
	
	private String us_profile;
	private String us_nick;
	
	private int commentCount;
	
	public int getFp_seq() {
		return fp_seq;
	}
	public void setFp_seq(int fp_seq) {
		this.fp_seq = fp_seq;
	}
	public String getFp_id() {
		return fp_id;
	}
	public void setFp_id(String fp_id) {
		this.fp_id = fp_id;
	}
	public String getFp_code() {
		return fp_code;
	}
	public void setFp_code(String fp_code) {
		this.fp_code = fp_code;
	}
	public String getFp_title() {
		return fp_title;
	}
	public void setFp_title(String fp_title) {
		this.fp_title = fp_title;
	}
	public String getFp_ph() {
		return fp_ph;
	}
	public void setFp_ph(String fp_ph) {
		this.fp_ph = fp_ph;
	}
	public String getFp_place() {
		return fp_place;
	}
	public void setFp_place(String fp_place) {
		this.fp_place = fp_place;
	}
	public String getFp_time() {
		return fp_time;
	}
	public void setFp_time(String fp_time) {
		this.fp_time = fp_time;
	}
	public String getFp_category() {
		return fp_category;
	}
	public void setFp_category(String fp_category) {
		this.fp_category = fp_category;
	}
	public String getFp_breed() {
		return fp_breed;
	}
	public void setFp_breed(String fp_breed) {
		this.fp_breed = fp_breed;
	}
	public String getFp_content() {
		return fp_content;
	}
	public void setFp_content(String fp_content) {
		this.fp_content = fp_content;
	}
	public String getFp_date() {
		return fp_date;
	}
	public void setFp_date(String fp_date) {
		this.fp_date = fp_date;
	}
	public int getFp_cnt() {
		return fp_cnt;
	}
	public void setFp_cnt(int fp_cnt) {
		this.fp_cnt = fp_cnt;
	}
	public String getFp_login() {
		return fp_login;
	}
	public void setFp_login(String fp_login) {
		this.fp_login = fp_login;
	}
	public String getFp_ok() {
		return fp_ok;
	}
	public void setFp_ok(String fp_ok) {
		this.fp_ok = fp_ok;
	}
	public String getFp_del() {
		return fp_del;
	}
	public void setFp_del(String fp_del) {
		this.fp_del = fp_del;
	}
	public String getNowPage() {
		return nowPage;
	}
	public void setNowPage(String nowPage) {
		this.nowPage = nowPage;
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getFp_img() {
		return fp_img;
	}
	public void setFp_img(String fp_img) {
		this.fp_img = fp_img;
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
	public String getUs_profile() {
		return us_profile;
	}
	public void setUs_profile(String us_profile) {
		this.us_profile = us_profile;
	}
	public String getUs_nick() {
		return us_nick;
	}
	public void setUs_nick(String us_nick) {
		this.us_nick = us_nick;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	@Override
	public String toString() {
		return "FindPetVO [fp_seq=" + fp_seq + ", fp_id=" + fp_id + ", fp_code=" + fp_code + ", fp_title=" + fp_title
				+ ", fp_ph=" + fp_ph + ", fp_place=" + fp_place + ", fp_time=" + fp_time + ", fp_category="
				+ fp_category + ", fp_breed=" + fp_breed + ", fp_content=" + fp_content + ", fp_date=" + fp_date
				+ ", fp_cnt=" + fp_cnt + ", fp_login=" + fp_login + ", fp_ok=" + fp_ok + ", fp_del=" + fp_del
				+ ", nowPage=" + nowPage + ", searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword
				+ ", category=" + category + ", uploadFile=" + uploadFile + ", fp_img=" + fp_img + ", start=" + start
				+ ", listcnt=" + listcnt + ", us_profile=" + us_profile + ", us_nick=" + us_nick + ", commentCount="
				+ commentCount + "]";
	}
	
}
