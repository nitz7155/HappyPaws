package com.happypaws.vo;

import java.sql.Date;

public class MyPostVO {
    private int post_id;         // 게시물 ID
    private String title;        // 게시물 제목
    private String source_table; // 소스 테이블
    private Date created_date;   // 작성일
    private String us_id;        // 작성자 ID

    // 기본 생성자
    public MyPostVO() {}

    // 매개변수를 받는 생성자
    public MyPostVO(int post_id, String title, String source_table, Date created_date, String us_id) {
        this.post_id = post_id;
        this.title = title;
        this.source_table = source_table;
        this.created_date = created_date;
        this.us_id = us_id;
    }

    // Getters and Setters
    public int getPost_id() {
        return post_id;
    }

    public void setPost_id(int post_id) {
        this.post_id = post_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSource_table() {
        return source_table;
    }

    public void setSource_table(String source_table) {
        this.source_table = source_table;
    }

    public Date getCreated_date() {
        return created_date;
    }

    public void setCreated_date(Date created_date) {
        this.created_date = created_date;
    }

    public String getUs_id() {
        return us_id;
    }

    public void setUs_id(String us_id) {
        this.us_id = us_id;
    }

    @Override
    public String toString() {
        return "MyPostVO{" +
                "post_id=" + post_id +
                ", title='" + title + '\'' +
                ", source_table='" + source_table + '\'' +
                ", created_date=" + created_date +
                ", us_id='" + us_id + '\'' +
                '}';
    }
}
