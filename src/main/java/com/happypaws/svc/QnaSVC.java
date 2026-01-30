package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.QnaDAO;
import com.happypaws.vo.QnaCmtVO;
import com.happypaws.vo.QnaVO;

@Service
public class QnaSVC {
	
	@Autowired
	private QnaDAO dao;
	
	//QNA - 리스트 불러오기
	public List<QnaVO> qna_list(QnaVO vo) {
		return dao.qna_list(vo);

	}

	// QNA - 글 갯수 보기
	public int countQna(QnaVO vo) {
		return dao.countQna(vo);
	}
	
	//QNA - 상세보기
	public QnaVO qna_view(QnaVO vo) {
		return dao.qna_view(vo);
	}

	// QNA - 조회수 update
	public void qna_count(QnaVO vo) {
		dao.qna_count(vo);
	}
	
	//QNA - QNA 수정
	public void qna_update(QnaVO vo) {
		dao.qna_update(vo);
	}
	
	//QNA - 글쓰기
	public int qna_insert(QnaVO vo) {
		return dao.qna_insert(vo);
	}
	
	//QNA - 글삭제
	public void qna_delete(QnaVO vo) {
		dao.qna_delete(vo);
	}
	
	//댓글 입력
	public void addComment(QnaCmtVO comment) {
    	dao.addComment(comment);
    }
    //댓글 가져오기
    public List<QnaCmtVO> commentList(QnaCmtVO comment) {
        return dao.commentList(comment);
    }
    //댓글 삭제
    public void deleteComment(QnaCmtVO comment) {
    	dao.deleteComment(comment);
    }
  //댓글 수정
    public void updateComment(QnaCmtVO comment) {
    	dao.updateComment(comment);
    }
}
