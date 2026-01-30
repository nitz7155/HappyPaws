package com.happypaws.vo;

public class LpCommentVO {
    private int lp_seq;
    private int lpc_seq;
    private String lpc_id;
    private String lpc_content;
    private String lpc_date;
    
    private String us_profile;
	private String us_nick;
	
	public int getLp_seq() {
		return lp_seq;
	}
	public void setLp_seq(int lp_seq) {
		this.lp_seq = lp_seq;
	}
	public int getLpc_seq() {
		return lpc_seq;
	}
	public void setLpc_seq(int lpc_seq) {
		this.lpc_seq = lpc_seq;
	}
	public String getLpc_id() {
		return lpc_id;
	}
	public void setLpc_id(String lpc_id) {
		this.lpc_id = lpc_id;
	}
	public String getLpc_content() {
		return lpc_content;
	}
	public void setLpc_content(String lpc_content) {
		this.lpc_content = lpc_content;
	}
	public String getLpc_date() {
		return lpc_date;
	}
	public void setLpc_date(String lpc_date) {
		this.lpc_date = lpc_date;
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
		return "LpCommentVO [lp_seq=" + lp_seq + ", lpc_seq=" + lpc_seq + ", lpc_id=" + lpc_id + ", lpc_content="
				+ lpc_content + ", lpc_date=" + lpc_date + ", us_profile=" + us_profile + ", us_nick=" + us_nick + "]";
	}
	
}
