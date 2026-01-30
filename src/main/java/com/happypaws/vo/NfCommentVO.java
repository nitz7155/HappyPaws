package com.happypaws.vo;

public class NfCommentVO {
	private int nf_seq;
	private int nfc_seq;
	private String nfc_id;
	private String nfc_content;
	private String nfc_date;

	private String us_profile;
	private String us_nick;

	public int getNf_seq() {
		return nf_seq;
	}

	public void setNf_seq(int nf_seq) {
		this.nf_seq = nf_seq;
	}

	public int getNfc_seq() {
		return nfc_seq;
	}

	public void setNfc_seq(int nfc_seq) {
		this.nfc_seq = nfc_seq;
	}

	public String getNfc_id() {
		return nfc_id;
	}

	public void setNfc_id(String nfc_id) {
		this.nfc_id = nfc_id;
	}

	public String getNfc_content() {
		return nfc_content;
	}

	public void setNfc_content(String nfc_content) {
		this.nfc_content = nfc_content;
	}

	public String getNfc_date() {
		return nfc_date;
	}

	public void setNfc_date(String nfc_date) {
		this.nfc_date = nfc_date;
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
		return "NfCommentVO [nf_seq=" + nf_seq + ", nfc_seq=" + nfc_seq + ", nfc_Id=" + nfc_id + ", nfc_content="
				+ nfc_content + ", nfc_date=" + nfc_date + ", us_profile=" + us_profile + ", us_nick=" + us_nick
				+ ", getNf_seq()=" + getNf_seq() + ", getNfc_seq()=" + getNfc_seq() + ", getNfc_id()=" + getNfc_id()
				+ ", getNfc_content()=" + getNfc_content() + ", getNfc_date()=" + getNfc_date() + ", getUs_profile()="
				+ getUs_profile() + ", getUs_nick()=" + getUs_nick() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}

}
