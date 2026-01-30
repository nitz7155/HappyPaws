package com.happypaws.vo;

public class AdVO {

    private String us_id;        // 관리자 ID
    private String us_password;  // 암호화된 관리자 비밀번호

    // 기본 생성자
    public AdVO() {}

    // 모든 필드를 포함하는 생성자
    public AdVO(String us_id, String us_password) {
        this.us_id = us_id;
        this.us_password = us_password;
    }

    // Getter 및 Setter 메서드
    public String getUs_id() {
        return us_id;
    }

    public void setAd_id(String us_id) {
        this.us_id = us_id;
    }

    public String getUs_password() {
        return us_password;
    }

    public void setUs_password(String us_password) {
        this.us_password = us_password;
    }

    @Override
    public String toString() {
        return "UsVO{" +
                "us_id='" + us_id + '\'' +
                ", us_password='" + us_password + '\'' +
                '}';
    }
}
