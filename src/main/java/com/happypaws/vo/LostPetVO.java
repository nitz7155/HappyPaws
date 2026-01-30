package com.happypaws.vo;

import org.springframework.web.multipart.MultipartFile;

public class LostPetVO {
	private int lp_seq;
	private String lp_id;
	private String lp_title;
	private String lp_ph;
	private String lp_place;
	private String lp_time;
	private String lp_category;
	private String lp_breed;
	private int lp_reward;
	private String formattedReward;
	private String lp_content;
	private String lp_date;
	private int lp_cnt;
	private String lp_ok;
	private String lp_del;

	private String nowPage;
	private String searchCondition;
	private String searchKeyword;
	private String category;

	private MultipartFile uploadFile;
	private String lp_img;

	private int start;
	private int listcnt;
	
	private String us_profile;
	private String us_nick;
	
	private int commentCount;

	public int getLp_seq() {
		return lp_seq;
	}

	public void setLp_seq(int lp_seq) {
		this.lp_seq = lp_seq;
	}

	public String getLp_id() {
		return lp_id;
	}

	public void setLp_id(String lp_id) {
		this.lp_id = lp_id;
	}

	public String getLp_title() {
		return lp_title;
	}

	public void setLp_title(String lp_title) {
		this.lp_title = lp_title;
	}

	public String getLp_ph() {
		return lp_ph;
	}

	public void setLp_ph(String lp_ph) {
		this.lp_ph = lp_ph;
	}

	public String getLp_place() {
		return lp_place;
	}

	public void setLp_place(String lp_place) {
		this.lp_place = lp_place;
	}

	public String getLp_time() {
		return lp_time;
	}

	public void setLp_time(String lp_time) {
		this.lp_time = lp_time;
	}

	public String getLp_category() {
		return lp_category;
	}

	public void setLp_category(String lp_category) {
		this.lp_category = lp_category;
	}

	public String getLp_breed() {
		return lp_breed;
	}

	public void setLp_breed(String lp_breed) {
		this.lp_breed = lp_breed;
	}

	public int getLp_reward() {
		return lp_reward;
	}

	public void setLp_reward(int lp_reward) {
		this.lp_reward = lp_reward;
	}

	public String getFormattedReward() {
		return formattedReward;
	}

	public void setFormattedReward(String formattedReward) {
		this.formattedReward = formattedReward;
	}

	public String getLp_content() {
		return lp_content;
	}

	public void setLp_content(String lp_content) {
		this.lp_content = lp_content;
	}

	public String getLp_date() {
		return lp_date;
	}

	public void setLp_date(String lp_date) {
		this.lp_date = lp_date;
	}

	public int getLp_cnt() {
		return lp_cnt;
	}

	public void setLp_cnt(int lp_cnt) {
		this.lp_cnt = lp_cnt;
	}

	public String getLp_ok() {
		return lp_ok;
	}

	public void setLp_ok(String lp_ok) {
		this.lp_ok = lp_ok;
	}

	public String getLp_del() {
		return lp_del;
	}

	public void setLp_del(String lp_del) {
		this.lp_del = lp_del;
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

	public String getLp_img() {
		return lp_img;
	}

	public void setLp_img(String lp_img) {
		this.lp_img = lp_img;
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
		return "LostPetVO [lp_seq=" + lp_seq + ", lp_id=" + lp_id + ", lp_title=" + lp_title + ", lp_ph=" + lp_ph
				+ ", lp_place=" + lp_place + ", lp_time=" + lp_time + ", lp_category=" + lp_category + ", lp_breed="
				+ lp_breed + ", lp_reward=" + lp_reward + ", formattedReward=" + formattedReward + ", lp_content="
				+ lp_content + ", lp_date=" + lp_date + ", lp_cnt=" + lp_cnt + ", lp_ok=" + lp_ok + ", lp_del=" + lp_del
				+ ", nowPage=" + nowPage + ", searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword
				+ ", category=" + category + ", uploadFile=" + uploadFile + ", lp_img=" + lp_img + ", start=" + start
				+ ", listcnt=" + listcnt + ", us_profile=" + us_profile + ", us_nick=" + us_nick + ", commentCount="
				+ commentCount + "]";
	}
	
	
}
