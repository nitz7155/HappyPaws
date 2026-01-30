package com.happypaws.svc;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.NoticeDAO;
import com.happypaws.vo.InfoVO;
import com.happypaws.vo.NoticeVO;

@Service
public class NoticeSVC {
	
	@Autowired
	private NoticeDAO dao;
	
	//관리자 통계
	public List<Map<String, Object>> getDaysTotalAmount(){
		return dao.getDaysTotalAmount();
	}
	
	//관리자 7일 데이터
	public List<InfoVO> info() {
		return dao.info();
	}
	
	public int notice_insert(NoticeVO vo) {
		return dao.notice_insert(vo);
	}
	
	public List<NoticeVO> notice_list(NoticeVO vo){
		return dao.notice_list(vo);
	}
	
	public NoticeVO notice_view(NoticeVO vo) {
		return dao.notice_view(vo);
	}
	
	public void notice_count(NoticeVO vo) {
		dao.notice_count(vo);
	}
	
	public void notice_update(NoticeVO vo) {
		dao.notice_update(vo);
	}
	
	public void notice_delete(NoticeVO vo) {
		dao.notice_delete(vo);
	}
	
	public int countNotice(NoticeVO vo) {
		return dao.countNotice(vo);
	}

	public NoticeVO notice_index() {
		return dao.notice_index();
	}
	
}
