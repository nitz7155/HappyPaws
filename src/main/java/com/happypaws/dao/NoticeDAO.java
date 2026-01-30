package com.happypaws.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.InfoVO;
import com.happypaws.vo.NoticeVO;

@Repository
public class NoticeDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	//관리자 통계
	public List<Map<String, Object>> getDaysTotalAmount(){
		return mybatis.selectList("NoticeDAO.getDaysTotalAmount");
	}
	
	//관리자 7일 데이터
	public List<InfoVO> info() {
		return mybatis.selectList("NoticeDAO.info");
	}
	
	//공지사항 -글쓰기
	public int notice_insert(NoticeVO vo) {
		// 현재 날짜와 시간 가져오기
        LocalDateTime currentDateTime = LocalDateTime.now();
        
        // 원하는 형식으로 포맷하기
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = currentDateTime.format(formatter);
        
		vo.setN_date(formattedDateTime);
		
		return mybatis.insert("NoticeDAO.notice_insert", vo);
	}
	
	//공지사항 - 리스트 불러오기
	public List<NoticeVO> notice_list(NoticeVO vo){
		return mybatis.selectList("NoticeDAO.notice_list", vo);
		
	}
	//공지사항 - 상세보기
	public NoticeVO notice_view(NoticeVO vo) {
		return mybatis.selectOne("NoticeDAO.notice_view",vo);
	}
	
	//공지사항 - 조회수 update
	public void notice_count(NoticeVO vo) {
		mybatis.update("NoticeDAO.notice_count", vo);
	}
	
	//공지사항 - 글 수정
	public void notice_update(NoticeVO vo) {
		mybatis.update("NoticeDAO.notice_update",vo);
	}
	
	//공지사항 - 글 삭제
	public void notice_delete(NoticeVO vo) {
		mybatis.update("NoticeDAO.notice_delete",vo);
	}
	
	//공지사항 - 글 갯수 보기
	public int countNotice(NoticeVO vo) {
		return mybatis.selectOne("NoticeDAO.countNotice",vo);
	}

	public NoticeVO notice_index() {
		return mybatis.selectOne("NoticeDAO.notice_index");
	}
}
