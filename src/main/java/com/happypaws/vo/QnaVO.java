package com.happypaws.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class QnaVO {

	private int qna_seq;            // qna 번호
    private String qna_id;          // 작성자 아이디
    private String qna_title;       // 제목
    private String qna_content;     // 내용
    private String qna_date;        // 작성 날짜
    private int qna_count;          // 조회수
    private String qna_del;         // 삭제 여부
	
	
	//검색기능
	private String searchCondition; 
	private String searchKeyword;
	private int start; 
	private int listcnt;
	
	//댓글 개수
	private int comment_count;
	
	//작성자 닉네임 , 사진 추가
	private String us_profile;
	private String us_nick;
	
	public String getFormattedQnaDate() {
	    if (qna_date != null) {
	        try {
	            // 날짜가 yyyy-MM-dd HH:mm:ss 형식인 경우 yyyy-MM-dd로 변환
	            if (qna_date.length() == 19) {  // yyyy-MM-dd HH:mm:ss
	                SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	                SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
	                Date date = originalFormat.parse(qna_date);
	                return targetFormat.format(date);
	            } 
	            // 날짜가 yyyy-MM-dd 형식인 경우 그대로 반환
	            else if (qna_date.length() == 10) {  // yyyy-MM-dd
	                return qna_date;
	            }
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }
	    }
	    return null;
	}
	
	public int getQna_seq() {
		return qna_seq;
	}
	public void setQna_seq(int qna_seq) {
		this.qna_seq = qna_seq;
	}
	public String getQna_id() {
		return qna_id;
	}
	public void setQna_id(String qna_id) {
		this.qna_id = qna_id;
	}
	public String getQna_title() {
		return qna_title;
	}
	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}
	public String getQna_content() {
		return qna_content;
	}
	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}
	public String getQna_date() {
		return qna_date;
	}
	public void setQna_date(String qna_date) {
		this.qna_date = qna_date;
	}
	public int getQna_count() {
		return qna_count;
	}
	public void setQna_count(int qna_count) {
		this.qna_count = qna_count;
	}
	public String getQna_del() {
		return qna_del;
	}
	public void setQna_del(String qna_del) {
		this.qna_del = qna_del;
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
		return "QnaVO [qna_seq=" + qna_seq + ", qna_id=" + qna_id + ", qna_title=" + qna_title + ", qna_content="
				+ qna_content + ", qna_date=" + qna_date + ", qna_count=" + qna_count + ", qna_del=" + qna_del
				+ ", searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword + ", start=" + start
				+ ", listcnt=" + listcnt + "]";
	}
	
	
	
}
