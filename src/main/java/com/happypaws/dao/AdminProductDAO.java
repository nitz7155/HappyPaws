package com.happypaws.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.ProductOptionVO;
import com.happypaws.vo.ProductsVO;

@Repository
public class AdminProductDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	//상품 추가 - 상품 테이블
	public int addProduct(ProductsVO vo) {
		return mybatis.insert("ProductsDAO.addProduct", vo);
	}
	
	//상품 추가 - 상품 옵션 테이블
	public int addProductOption(ProductOptionVO opt) {
		return mybatis.insert("ProductsDAO.addProductOption",opt);
	}
	
	//옵션 추가를 위한 아이디 조회
	public int getProductId(ProductsVO vo) {
		return mybatis.selectOne("ProductsDAO.getProductId", vo);
	}
	
	//상품 삭제
	public int deleteProduct(ProductsVO vo) {
		return mybatis.delete("ProductsDAO.deleteProduct",vo);
	}
	
	//상품 옵션 삭제
	public int deleteProductOpt(ProductOptionVO opt) {
		return mybatis.delete("ProductsDAO.deleteProductOpt",opt);
	}
	
	//상품 목록 조회
	public List<ProductsVO> adminProductList(ProductsVO vo) { 
		return mybatis.selectList("ProductsDAO.adminProductList", vo);
	}
	
	//상품 조회(수정 시 끌고 옴)
	public ProductsVO productModifyView(ProductsVO vo) {
		return mybatis.selectOne("ProductsDAO.getProduct",vo);
	}
	
	//상품 목록 - 옵션 조회 - id 맞는 것 가져옴
	public List<ProductOptionVO> adminProductList(ProductOptionVO opt) { 
		return mybatis.selectList("ProductsDAO.adminProductOption", opt);
	}
	//상품 목록 - 옵션 조회 - where 조건 없음
	public List<ProductOptionVO> allOpts(ProductOptionVO opt) { 
		return mybatis.selectList("ProductsDAO.allOpts", opt);
	}

	//상품 수 카운트
	public int countProducts(ProductsVO vo) {
		return mybatis.selectOne("ProductsDAO.countProducts", vo);
	}
	
	//상품 수정 - 상품 테이블
	public int modifyProduct(ProductsVO vo) {
		return mybatis.update("ProductsDAO.modifyProduct", vo);
	}
	
	//상품 수정 - 상품 옵션 테이블
	public int modifyProduct(ProductOptionVO opt) {
		return mybatis.update("ProductsDAO.modifyProductOption", opt);
	}

	
 

}
