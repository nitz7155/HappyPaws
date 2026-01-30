package com.happypaws.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.LpCommentVO;

@Repository
public class LpCommentDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	// CRUD 기능의 메소드 구현
	// 댓글등록
	public void insertLpComment(LpCommentVO vo) {

		// 현재 날짜와 시간 가져오기
		LocalDateTime currentDateTime = LocalDateTime.now();

		// 원하는 형식으로 포맷하기
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formattedDateTime = currentDateTime.format(formatter);

		vo.setLpc_date(formattedDateTime);
		mybatis.insert("LpCommentDAO.insertLpComment", vo);
		
	}

	//댓글 보기
	public List<LpCommentVO> getLpCommentList(LpCommentVO vo) {
		List<LpCommentVO> list = mybatis.selectList("LpCommentDAO.getLpCommentList", vo);
		return list;
	}
	
	// 댓글수정
	public void updateLpComment(LpCommentVO vo) {
		mybatis.update("LpCommentDAO.updateLpComment", vo);
	}

	// 댓글삭제
	public void deleteLpComment(LpCommentVO vo) {
		mybatis.delete("LpCommentDAO.deleteLpComment", vo);
	}

}
