package com.happypaws.vo;

import org.springframework.web.multipart.MultipartFile;

public class UsersVO {
	private String us_id = null;
	private String us_sns = "default";
	private String us_password = null;
	private String us_name = null;
	private String us_nick = null;
	private String us_email = null;
	private String us_phone = null;
	private String us_address = null;
	private String us_date = null;
	private String us_is_del = null;
	private String us_profile = null;
	private MultipartFile us_profile_file = null;
	private String postcode = null;

	public String getUs_id() { return us_id; }
	public void setUs_id(String us_id) { this.us_id = us_id; }

	public String getUs_sns() { return us_sns; }
	public void setUs_sns(String us_sns) { this.us_sns = us_sns; }

	public String getUs_password() { return us_password; }
	public void setUs_password(String us_password) { this.us_password = us_password; }

	public String getUs_name() { return us_name; }
	public void setUs_name(String us_name) { this.us_name = us_name; }

	public String getUs_nick() { return us_nick; }
	public void setUs_nick(String us_nick) { this.us_nick = us_nick; }

	public String getUs_email() { return us_email; }
	public void setUs_email(String us_email) { this.us_email = us_email; }

	public String getUs_phone() { return us_phone; }
	public void setUs_phone(String us_phone) { this.us_phone = us_phone; }

	public String getUs_address() { return us_address; }
	public void setUs_address(String us_address) { this.us_address = us_address; }

	public String getUs_date() { return us_date; }
	public void setUs_date(String us_date) { this.us_date = us_date; }

	public String getUs_is_del() { return us_is_del; }
	public void setUs_is_del(String us_is_del) { this.us_is_del = us_is_del; }

	public String getUs_profile() { return us_profile; }
	public void setUs_profile(String us_profile) { this.us_profile = us_profile; }

	public MultipartFile getUs_profile_file() { return us_profile_file; }
	public void setUs_profile_file(MultipartFile us_profile_file) { this.us_profile_file = us_profile_file; }

	public String getPostcode() { return postcode; }
	public void setPostcode(String postcode) { this.postcode = postcode; }

	@Override
	public String toString() {
		return "UsersVO [us_id=" + us_id + ", us_sns=" + us_sns + ", us_password=" + us_password + ", us_name="
				+ us_name + ", us_nick=" + us_nick + ", us_email=" + us_email + ", us_phone=" + us_phone
				+ ", us_address=" + us_address + ", us_date=" + us_date + ", us_is_del=" + us_is_del + ", us_profile="
				+ us_profile + ", us_profile_file=" + us_profile_file + ", postcode=" + postcode + "]";
	}
}