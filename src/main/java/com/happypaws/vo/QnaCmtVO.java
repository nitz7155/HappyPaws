package com.happypaws.vo;

public class QnaCmtVO {
	
	private int qna_cmt_seq;       // qna 댓글 번호
	private int qna_seq;            // qna 번호
	private String qna_cmt_id;      // qna 댓글 작성자
	private String qna_cmt_content;  // qna 댓글 내용
	private String qna_cmt_date;    // qna 댓글 작성 날짜
	
	//작성자 닉네임 , 사진 추가
	private String us_profile;
	private String us_nick;
	
	public int getQna_cmt_seq() {
		return qna_cmt_seq;
	}
	public void setQna_cmt_seq(int qna_cmt_seq) {
		this.qna_cmt_seq = qna_cmt_seq;
	}
	public int getQna_seq() {
		return qna_seq;
	}
	public void setQna_seq(int qna_seq) {
		this.qna_seq = qna_seq;
	}
	public String getQna_cmt_id() {
		return qna_cmt_id;
	}
	public void setQna_cmt_id(String qna_cmt_id) {
		this.qna_cmt_id = qna_cmt_id;
	}
	public String getQna_cmt_content() {
		return qna_cmt_content;
	}
	public void setQna_cmt_content(String qna_cmt_content) {
		this.qna_cmt_content = qna_cmt_content;
	}
	public String getQna_cmt_date() {
		return qna_cmt_date;
	}
	public void setQna_cmt_date(String qna_cmt_date) {
		this.qna_cmt_date = qna_cmt_date;
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

	
}
