package com.happypaws.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class NoticeVO {

	private int n_seq;          // 번호
	private String n_id;       // 작성자 아이디
	private String n_title;    // 제목
	private String n_content;  // 내용
	private String n_date;     // 작성날짜
	private int n_count;       // 조회수
	private String n_chk = "N";    // 중요공지 체크
	private String n_del;      // 삭제여부
	
	
	//검색기능
	private String searchCondition; 
	private String searchKeyword;
	private int start; 
	private int listcnt;
	
	
	//작성자 닉네임 , 사진 추가
	private String us_profile;
	private String us_nick;
	
	//날짜 변환기능
	public String getFormattedNoticeDate() {
	    if (n_date != null) {
	        try {
	            // 날짜가 yyyy-MM-dd HH:mm:ss 형식인 경우 yyyy-MM-dd로 변환
	            if (n_date.length() == 19) {  // yyyy-MM-dd HH:mm:ss
	                SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	                SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
	                Date date = originalFormat.parse(n_date);
	                return targetFormat.format(date);
	            } 
	            // 날짜가 yyyy-MM-dd 형식인 경우 그대로 반환
	            else if (n_date.length() == 10) {  // yyyy-MM-dd
	                return n_date;
	            }
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }
	    }
	    return null;
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
	public int getN_seq() {
		return n_seq;
	}
	public void setN_seq(int n_seq) {
		this.n_seq = n_seq;
	}
	public String getN_id() {
		return n_id;
	}
	public void setN_id(String n_id) {
		this.n_id = n_id;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	public String getN_date() {
		return n_date;
	}
	public void setN_date(String n_date) {
		this.n_date = n_date;
	}
	public int getN_count() {
		return n_count;
	}
	public void setN_count(int n_count) {
		this.n_count = n_count;
	}
	
	public String getN_chk() {
		return n_chk;
	}
	public void setN_chk(String n_chk) {
		this.n_chk = n_chk;
	}
	public String getN_del() {
		return n_del;
	}
	public void setN_del(String n_del) {
		this.n_del = n_del;
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
		return "NoticeVO [n_seq=" + n_seq + ", n_id=" + n_id + ", n_title=" + n_title + ", n_content=" + n_content
				+ ", n_date=" + n_date + ", n_count=" + n_count + ", n_chk=" + n_chk + ", n_del=" + n_del + "]";
	}
	
	
	 
	
}
