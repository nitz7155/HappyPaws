package com.happypaws.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.FpCommentVO;

@Repository
public class FpCommentDAO {

    @Autowired
    private SqlSessionTemplate mybatis;

    // 댓글 등록
    public void insertFpComment(FpCommentVO vo) {

        // 현재 날짜와 시간 가져오기
        LocalDateTime currentDateTime = LocalDateTime.now();

        // 원하는 형식으로 포맷하기
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDateTime = currentDateTime.format(formatter);

        vo.setFpc_date(formattedDateTime);
        mybatis.insert("FpCommentDAO.insertFpComment", vo);
    }

    // 댓글 목록 조회
    public List<FpCommentVO> getFpCommentList(FpCommentVO vo) {
        return mybatis.selectList("FpCommentDAO.getFpCommentList", vo);
    }

    // 댓글 수정
    public void updateFpComment(FpCommentVO vo) {
        mybatis.update("FpCommentDAO.updateFpComment", vo);
    }

    // 댓글 삭제
    public void deleteFpComment(FpCommentVO vo) {
        mybatis.delete("FpCommentDAO.deleteFpComment", vo);
    }
    
    // 비밀 번호 일치확인
    public int verifyFpcPassword(int fpcSeq, String enteredPassword) {
        Map<String, Object> params = new HashMap<>();
        params.put("fpcSeq", fpcSeq);
        params.put("enteredPassword", enteredPassword);
        return mybatis.selectOne("FpCommentDAO.verifyFpcPassword", params);
    }
}
