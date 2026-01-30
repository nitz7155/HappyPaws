package com.happypaws.vo;

import java.sql.Timestamp;

public class CmtyupVO {
	private int cmty_up_id; // 추천의 고유 ID
	private int cmty_seq; // 추천한 댓글의 고유 ID (외래키)
	private String us_id; // 추천한 사용자 ID
	private Timestamp created_at; // 추천 날짜 및 시간
	
	public int getCmty_up_id() {
		return cmty_up_id;
	}
	public void setCmty_up_id(int cmty_up_id) {
		this.cmty_up_id = cmty_up_id;
	}
	public int getCmty_seq() {
		return cmty_seq;
	}
	public void setCmty_seq(int cmty_seq) {
		this.cmty_seq = cmty_seq;
	}
	public String getUs_id() {
		return us_id;
	}
	public void setUs_id(String us_id) {
		this.us_id = us_id;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	
	@Override
	public String toString() {
		return "CmtyupVO [cmty_up_id=" + cmty_up_id + ", cmty_seq=" + cmty_seq + ", us_id=" + us_id + ", created_at="
				+ created_at + "]";
	}
	
}
