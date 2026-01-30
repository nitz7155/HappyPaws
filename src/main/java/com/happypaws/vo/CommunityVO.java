package com.happypaws.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CommunityVO {
	private int cmty_seq; // 커뮤니티 번호
	private String cmty_id; // 커뮤니티 작성자 아이디
	private String cmty_title; // 커뮤니티 제목
	private String cmty_content; // 커뮤니티 내용
	private String cmty_date; // 커뮤니티 작성날짜
	private String cmty_category; // 커뮤니티 카테고리
	private int cmty_count; // 커뮤니티 조회수
	private int cmty_cp; // 커뮤니티 추천
	private String cmty_del; // 삭제여부
	
	//검색기능
	private String searchCondition; 
	private String searchKeyword;
	private int start; 
	private int listcnt;
	
	//댓글 
	private int comment_count;
	
	//작성자 닉네임 , 사진 추가
	private String us_profile;
	private String us_nick;
	
	public String getFormattedCmtyDate() {
	    if (cmty_date != null) {
	        try {
	            // 날짜가 yyyy-MM-dd HH:mm:ss 형식인 경우 yyyy-MM-dd로 변환
	            if (cmty_date.length() == 19) {  // yyyy-MM-dd HH:mm:ss
	                SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	                SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
	                Date date = originalFormat.parse(cmty_date);
	                return targetFormat.format(date);
	            } 
	            // 날짜가 yyyy-MM-dd 형식인 경우 그대로 반환
	            else if (cmty_date.length() == 10) {  // yyyy-MM-dd
	                return cmty_date;
	            }
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }
	    }
	    return null;
	}
	
    // 한글로 변환된 카테고리 값을 반환하는 메서드
    public String getCmty_category_kr() {
        switch (cmty_category) {
            case "General":
                return "자유게시판";
            case "AdoptionReview":
                return "입양/분양 후기";
            case "FoundReview":
                return "찾은 후기";
            default:
                return "알 수 없는 카테고리";
        }
    }
	
	public int getCmty_seq() {
		return cmty_seq;
	}

	public void setCmty_seq(int cmty_seq) {
		this.cmty_seq = cmty_seq;
	}

	public String getCmty_id() {
		return cmty_id;
	}

	public void setCmty_id(String cmty_id) {
		this.cmty_id = cmty_id;
	}

	public String getCmty_title() {
		return cmty_title;
	}

	public void setCmty_title(String cmty_title) {
		this.cmty_title = cmty_title;
	}

	public String getCmty_content() {
		return cmty_content;
	}

	public void setCmty_content(String cmty_content) {
		this.cmty_content = cmty_content;
	}

	public String getCmty_date() {
		return cmty_date;
	}

	public void setCmty_date(String cmty_date) {
		this.cmty_date = cmty_date;
	}

	public String getCmty_category() {
		return cmty_category;
	}

	public void setCmty_category(String cmty_category) {
		this.cmty_category = cmty_category;
	}

	public int getCmty_count() {
		return cmty_count;
	}

	public void setCmty_count(int cmty_count) {
		this.cmty_count = cmty_count;
	}

	public int getCmty_cp() {
		return cmty_cp;
	}

	public void setCmty_cp(int cmty_cp) {
		this.cmty_cp = cmty_cp;
	}

	public String getCmty_del() {
		return cmty_del;
	}

	public void setCmty_del(String cmty_del) {
		this.cmty_del = cmty_del;
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

	public int getComment_count() {
		return comment_count;
	}

	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
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

	@Override
	public String toString() {
		return "CommunityVO [cmty_seq=" + cmty_seq + ", cmty_id=" + cmty_id + ", cmty_title=" + cmty_title
				+ ", cmty_content=" + cmty_content + ", cmty_date=" + cmty_date + ", cmty_category=" + cmty_category
				+ ", cmty_count=" + cmty_count + ", cmty_cp=" + cmty_cp + ", cmty_del=" + cmty_del
				+ ", searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword + ", start=" + start
				+ ", listcnt=" + listcnt + ", comment_count=" + comment_count + "]";
	}

	
}
