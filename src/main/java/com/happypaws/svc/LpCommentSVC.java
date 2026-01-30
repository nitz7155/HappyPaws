package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.LpCommentDAO;
import com.happypaws.vo.LpCommentVO;

@Service("lpCommentSVC")
public class LpCommentSVC {
	
	@Autowired
	private LpCommentDAO lpCommentDAO;

	public void insertLpComment(LpCommentVO vo) {
		lpCommentDAO.insertLpComment(vo);
	}

	public void updateLpComment(LpCommentVO vo) {
		lpCommentDAO.updateLpComment(vo);
	}

	public List<LpCommentVO> getLpCommentList(LpCommentVO vo) {
		return lpCommentDAO.getLpCommentList(vo);
	}
	public void deleteLpComment(LpCommentVO vo) {
		lpCommentDAO.deleteLpComment(vo);
	}
}
