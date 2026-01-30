package com.happypaws.vo;

public class ProductOptionVO {
	private int pr_id;
	private int pr_opt_id;
	private String pr_opt_name;
	private int pr_opt_stock;
	private int pr_opt_price;
	private String pr_opt_status;
	
	
	
	public int getPr_id() {
		return pr_id;
	}
	public void setPr_id(int pr_id) {
		this.pr_id = pr_id;
	}
	public int getPr_opt_id() {
		return pr_opt_id;
	}
	public void setPr_opt_id(int pr_opt_id) {
		this.pr_opt_id = pr_opt_id;
	}
	public String getPr_opt_name() {
		return pr_opt_name;
	}
	public void setPr_opt_name(String pr_opt_name) {
		this.pr_opt_name = pr_opt_name;
	}
	public int getPr_opt_stock() {
		return pr_opt_stock;
	}
	public void setPr_opt_stock(int pr_opt_stock) {
		this.pr_opt_stock = pr_opt_stock;
	}
	public int getPr_opt_price() {
		return pr_opt_price;
	}
	public void setPr_opt_price(int pr_opt_price) {
		this.pr_opt_price = pr_opt_price;
	}
	
	
	public String getPr_opt_status() {
		return pr_opt_status;
	}
	public void setPr_opt_status(String pr_opt_status) {
		this.pr_opt_status = pr_opt_status;
	}
	
	@Override
	public String toString() {
		return "ProductOptionVO [pr_id=" + pr_id + ", pr_opt_id=" + pr_opt_id + ", pr_opt_name=" + pr_opt_name
				+ ", pr_opt_stock=" + pr_opt_stock + ", pr_opt_price=" + pr_opt_price + ", pr_opt_status="
				+ pr_opt_status + ", getPr_opt_status()=" + getPr_opt_status() + ", getPr_id()=" + getPr_id()
				+ ", getPr_opt_id()=" + getPr_opt_id() + ", getPr_opt_name()=" + getPr_opt_name()
				+ ", getPr_opt_stock()=" + getPr_opt_stock() + ", getPr_opt_price()=" + getPr_opt_price()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}
	
	
	
}
