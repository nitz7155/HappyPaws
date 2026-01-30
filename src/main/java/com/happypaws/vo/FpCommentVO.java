package com.happypaws.vo;

public class FpCommentVO {
	private int fp_seq;
	private int fpc_seq;
	private String fpc_id;
	private String fpc_code;
	private String fpc_content;
	private String fpc_date;
	private String fpc_login;

	private String us_profile;
	private String us_nick;
	
	public int getFp_seq() {
		return fp_seq;
	}
	public void setFp_seq(int fp_seq) {
		this.fp_seq = fp_seq;
	}
	public int getFpc_seq() {
		return fpc_seq;
	}
	public void setFpc_seq(int fpc_seq) {
		this.fpc_seq = fpc_seq;
	}
	public String getFpc_id() {
		return fpc_id;
	}
	public void setFpc_id(String fpc_id) {
		this.fpc_id = fpc_id;
	}
	public String getFpc_content() {
		return fpc_content;
	}
	public void setFpc_content(String fpc_content) {
		this.fpc_content = fpc_content;
	}
	public String getFpc_code() {
		return fpc_code;
	}
	public void setFpc_code(String fpc_code) {
		this.fpc_code = fpc_code;
	}
	public String getFpc_date() {
		return fpc_date;
	}
	public void setFpc_date(String fpc_date) {
		this.fpc_date = fpc_date;
	}
	public String getFpc_login() {
		return fpc_login;
	}
	public void setFpc_login(String fpc_login) {
		this.fpc_login = fpc_login;
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
		return "FpCommentVO [fp_seq=" + fp_seq + ", fpc_seq=" + fpc_seq + ", fpc_id=" + fpc_id + ", fpc_content="
				+ fpc_content + ", fpc_code=" + fpc_code + ", fpc_date=" + fpc_date + ", fpc_login=" + fpc_login
				+ ", us_profile=" + us_profile + ", us_nick=" + us_nick + "]";
	}
	
}
