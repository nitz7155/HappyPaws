package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.AdminProductDAO;
import com.happypaws.vo.ProductOptionVO;
import com.happypaws.vo.ProductsVO;

@Service
public class AdminProductSVC {
	@Autowired
	private AdminProductDAO dao;

	//상품 등록
	public int addProduct(ProductsVO vo) {
		return dao.addProduct(vo);
	}
	//상품 옵션 등록
	public int addProductOption(ProductOptionVO opt) {
		return dao.addProductOption(opt);
	}
	
	//상품 삭제
	public int deleteProduct(ProductsVO vo) {
		return dao.deleteProduct(vo);
	}
	//옵션 삭제
	public int deleteProductOpt(ProductOptionVO opt) {
		return dao.deleteProductOpt(opt);
	}
	
	//옵션 추가를 위한 아이디 조회
	public int getProductId(ProductsVO vo) {
		   return dao.getProductId(vo);
	}
	
	//관리자 상품 목록
	public List<ProductsVO> adminProductList(ProductsVO vo) {
		return dao.adminProductList(vo);
	}
	
	//옵션 목록 가져오기-id 조건 맞아야 함
	public List<ProductOptionVO> adminProductList(ProductOptionVO opt) {
		return dao.adminProductList(opt);
	}
	
	//옵션 목록 가져오기 - id 조건 없음
	public List<ProductOptionVO> allOpts(ProductOptionVO opt) {
		return dao.allOpts(opt);
	}
	
	//상품 수정
	public int modifyProduct(ProductsVO vo) {
		return dao.modifyProduct(vo);
	}
	
	//상품 옵션 수정
	public int modifyProductOption(ProductOptionVO opt) {
		return dao.modifyProduct(opt);
	}
	
	
	//상품 조회
	public ProductsVO productModifyView(ProductsVO vo) {
		return dao.productModifyView(vo);
	}
	
	//게시물 총 갯수
	public int countProducts(ProductsVO vo) {
		return dao.countProducts(vo);
	}
	
	
	
}
