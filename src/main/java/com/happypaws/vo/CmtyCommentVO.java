package com.happypaws.vo;

public class CmtyCommentVO {
	private int cmty_cmt_seq; // 커뮤니티 댓글 번호
	private int cmty_seq; // 커뮤니티 번호
	private Integer cmty_cmt_parent_seq; // 커뮤니티 부모댓글 번호 (nullable)
	private String cmty_cmt_id; // 커뮤니티 댓글 작성자
	private String cmty_cmt_content; // 커뮤니티 댓글 내용
	private String cmty_cmt_date; // 커뮤니티 댓글 작성날짜
	private String cmty_cmt_del;
	
	//대댓글
	private int depth; // 깊이
	private String has_active_child; //자식여부
	
	
	//작성자 닉네임 , 사진 추가
	private String us_profile;
	private String us_nick;
	private String us_id;
	
	public int getCmty_cmt_seq() {
		return cmty_cmt_seq;
	}
	public void setCmty_cmt_seq(int cmty_cmt_seq) {
		this.cmty_cmt_seq = cmty_cmt_seq;
	}
	public int getCmty_seq() {
		return cmty_seq;
	}
	public void setCmty_seq(int cmty_seq) {
		this.cmty_seq = cmty_seq;
	}
	public Integer getCmty_cmt_parent_seq() {
		return cmty_cmt_parent_seq;
	}
	public void setCmty_cmt_parent_seq(Integer cmty_cmt_parent_seq) {
		this.cmty_cmt_parent_seq = cmty_cmt_parent_seq;
	}
	public String getCmty_cmt_id() {
		return cmty_cmt_id;
	}
	public void setCmty_cmt_id(String cmty_cmt_id) {
		this.cmty_cmt_id = cmty_cmt_id;
	}
	public String getCmty_cmt_content() {
		return cmty_cmt_content;
	}
	public void setCmty_cmt_content(String cmty_cmt_content) {
		this.cmty_cmt_content = cmty_cmt_content;
	}
	public String getCmty_cmt_date() {
		return cmty_cmt_date;
	}
	public void setCmty_cmt_date(String cmty_cmt_date) {
		this.cmty_cmt_date = cmty_cmt_date;
	}

	
	public String getCmty_cmt_del() {
		return cmty_cmt_del;
	}
	public void setCmty_cmt_del(String cmty_cmt_del) {
		this.cmty_cmt_del = cmty_cmt_del;
	}
	
	
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	
	public String getHas_active_child() {
		return has_active_child;
	}
	public void setHas_active_child(String has_active_child) {
		this.has_active_child = has_active_child;
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
	
	public String getUs_id() {
		return us_id;
	}
	public void setUs_id(String us_id) {
		this.us_id = us_id;
	}
	@Override
	public String toString() {
		return "CmtyCommentVO [cmty_cmt_seq=" + cmty_cmt_seq + ", cmty_seq=" + cmty_seq + ", cmty_cmt_parent_seq="
				+ cmty_cmt_parent_seq + ", cmty_cmt_id=" + cmty_cmt_id + ", cmty_cmt_content=" + cmty_cmt_content
				+ ", cmty_cmt_date=" + cmty_cmt_date + ", depth=" + depth + "]";
	}
	
	
}
