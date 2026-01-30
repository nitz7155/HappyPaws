package com.happypaws.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.NfCommentVO;

@Repository
public class NfCommentDAO {
    @Autowired
    private SqlSessionTemplate mybatis;

    // 댓글 등록
    public void insertNfComment(NfCommentVO vo) {
        // 현재 날짜와 시간 가져오기
        LocalDateTime currentDateTime = LocalDateTime.now();
        
        // 날짜 포맷
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDateTime = currentDateTime.format(formatter);
        
        vo.setNfc_date(formattedDateTime);  // 댓글 날짜 설정
        mybatis.insert("NfCommentDAO.insertNfComment", vo);  // 새로운 댓글 등록
    }

    // 댓글 목록 조회
    public List<NfCommentVO> getNfCommentList(NfCommentVO vo) {
        return mybatis.selectList("NfCommentDAO.getNfCommentList", vo);  // 댓글 목록 조회
    }

    // 댓글 수정
    public void updateNfComment(NfCommentVO vo) {
        mybatis.update("NfCommentDAO.updateNfComment", vo);  // 댓글 내용 수정
    }

    // 댓글 삭제
    public void deleteNfComment(NfCommentVO vo) {
        mybatis.delete("NfCommentDAO.deleteNfComment", vo);  // 댓글 삭제
    }
}
