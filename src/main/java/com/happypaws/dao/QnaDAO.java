package com.happypaws.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.QnaCmtVO;
import com.happypaws.vo.QnaVO;

@Repository
public class QnaDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	//QNA - 리스트 불러오기
	public List<QnaVO> qna_list(QnaVO vo) {
		return mybatis.selectList("QnaDAO.qna_list", vo);

	}
	
	//QNA - 글 갯수 보기
	public int countQna(QnaVO vo) {
		return mybatis.selectOne("QnaDAO.countQna",vo);
	}
	
	//QNA - 상세보기
	public QnaVO qna_view(QnaVO vo) {
		return mybatis.selectOne("QnaDAO.qna_view", vo);
	}

	//QNA - 조회수 update
	public void qna_count(QnaVO vo) {
		mybatis.update("QnaDAO.qna_count", vo);
	}
	
	//QNA - QNA 수정
	public void qna_update(QnaVO vo) {
		mybatis.update("QnaDAO.qna_update",vo);
	}
	
	//QNA -글쓰기
	public int qna_insert(QnaVO vo) {
		// 현재 날짜와 시간 가져오기
        LocalDateTime currentDateTime = LocalDateTime.now();
        
        // 원하는 형식으로 포맷하기
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = currentDateTime.format(formatter);
        
		vo.setQna_date(formattedDateTime);
		
		return mybatis.insert("QnaDAO.qna_insert", vo);
	}
	
	//QNA - 글 삭제
	public void qna_delete(QnaVO vo) {
		mybatis.update("QnaDAO.qna_delete",vo);
	}
	
	//QNA 댓글 만들기====================
	//댓글 입력
    public void addComment(QnaCmtVO comment) {
    	mybatis.insert("QnaDAO.addComment",comment);
    }
    //댓글 가져오기
    public List<QnaCmtVO> commentList(QnaCmtVO comment) {
        return mybatis.selectList("QnaDAO.commentList",comment);
    }
    //댓글 삭제
    public void deleteComment(QnaCmtVO comment) {
    	mybatis.delete("QnaDAO.deleteComment",comment);
    }
	//댓글 수정
    public void updateComment(QnaCmtVO comment) {
    	mybatis.update("QnaDAO.updateComment",comment);
    }
}
