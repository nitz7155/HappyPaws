package com.happypaws.vo;

import org.springframework.web.multipart.MultipartFile;

public class NewFamilyVO {
	private int nf_seq;
	private String nf_id;
	private String nf_title;
	private String nf_ph;
	private String nf_place;
	private String nf_age;
	private char nf_gender;
	private String nf_category;
	private String nf_breed;
	private String nf_content;
	private String nf_date;
	private int nf_cnt;
	private String nf_ok;
	private String nf_del;

	private String nowPage;
	private String searchCondition;
	private String searchKeyword;
	private String category;

	private MultipartFile uploadFile;
	private String nf_img;

	private int start;
	private int listcnt;

	private String us_profile;
	private String us_nick;

	private int commentCount;

	public int getNf_seq() {
		return nf_seq;
	}

	public void setNf_seq(int nf_seq) {
		this.nf_seq = nf_seq;
	}

	public String getNf_id() {
		return nf_id;
	}

	public void setNf_id(String nf_id) {
		this.nf_id = nf_id;
	}

	public String getNf_title() {
		return nf_title;
	}

	public void setNf_title(String nf_title) {
		this.nf_title = nf_title;
	}

	public String getNf_ph() {
		return nf_ph;
	}

	public void setNf_ph(String nf_ph) {
		this.nf_ph = nf_ph;
	}

	public String getNf_place() {
		return nf_place;
	}

	public void setNf_place(String nf_place) {
		this.nf_place = nf_place;
	}

	public String getNf_age() {
		return nf_age;
	}

	public void setNf_age(String nf_age) {
		this.nf_age = nf_age;
	}

	public char getNf_gender() {
		return nf_gender;
	}

	public void setNf_gender(char nf_gender) {
		this.nf_gender = nf_gender;
	}

	public String getNf_category() {
		return nf_category;
	}

	public void setNf_category(String nf_category) {
		this.nf_category = nf_category;
	}

	public String getNf_breed() {
		return nf_breed;
	}

	public void setNf_breed(String nf_breed) {
		this.nf_breed = nf_breed;
	}

	public String getNf_content() {
		return nf_content;
	}

	public void setNf_content(String nf_content) {
		this.nf_content = nf_content;
	}

	public String getNf_date() {
		return nf_date;
	}

	public void setNf_date(String nf_date) {
		this.nf_date = nf_date;
	}

	public int getNf_cnt() {
		return nf_cnt;
	}

	public void setNf_cnt(int nf_cnt) {
		this.nf_cnt = nf_cnt;
	}

	public String getNf_ok() {
		return nf_ok;
	}

	public void setNf_ok(String nf_ok) {
		this.nf_ok = nf_ok;
	}

	public String getNf_del() {
		return nf_del;
	}

	public void setNf_del(String nf_del) {
		this.nf_del = nf_del;
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

	public String getNf_img() {
		return nf_img;
	}

	public void setNf_img(String nf_img) {
		this.nf_img = nf_img;
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
		return "NewFamilyVO [nf_seq=" + nf_seq + ", nf_id=" + nf_id + ", nf_title=" + nf_title + ", nf_ph=" + nf_ph
				+ ", nf_place=" + nf_place + ", nf_age=" + nf_age + ", nf_gender=" + nf_gender + ", nf_category="
				+ nf_category + ", nf_breed=" + nf_breed + ", nf_content=" + nf_content + ", nf_date=" + nf_date
				+ ", nf_cnt=" + nf_cnt + ", nf_ok=" + nf_ok + ", nf_del=" + nf_del + ", nowPage=" + nowPage
				+ ", searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword + ", category=" + category
				+ ", uploadFile=" + uploadFile + ", nf_img=" + nf_img + ", start=" + start + ", listcnt=" + listcnt
				+ ", us_profile=" + us_profile + ", us_nick=" + us_nick + ", commentCount=" + commentCount + "]";
	}
	
}
