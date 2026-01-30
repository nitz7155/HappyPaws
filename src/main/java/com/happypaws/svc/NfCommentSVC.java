package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.NfCommentDAO;
import com.happypaws.vo.NfCommentVO;

@Service("nfCommentSVC")
public class NfCommentSVC {
	
	@Autowired
	private NfCommentDAO nfCommentDAO;

	public void insertNfComment(NfCommentVO vo) {
		nfCommentDAO.insertNfComment(vo);
	}

	public void updateNfComment(NfCommentVO vo) {
		nfCommentDAO.updateNfComment(vo);
	}

	public List<NfCommentVO> getNfCommentList(NfCommentVO vo) {
		return nfCommentDAO.getNfCommentList(vo);
	}
	public void deleteNfComment(NfCommentVO vo) {
		nfCommentDAO.deleteNfComment(vo);
	}
}
