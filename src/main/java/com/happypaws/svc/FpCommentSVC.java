package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.FpCommentDAO;
import com.happypaws.vo.FpCommentVO;

@Service("fpCommentSVC")
public class FpCommentSVC {

    @Autowired
    private FpCommentDAO fpCommentDAO;

    // 댓글 추가
    public void insertFpComment(FpCommentVO vo) {
        fpCommentDAO.insertFpComment(vo);
    }

    // 댓글 수정
    public void updateFpComment(FpCommentVO vo) {
        fpCommentDAO.updateFpComment(vo);
    }

    // 댓글 목록 조회
    public List<FpCommentVO> getFpCommentList(FpCommentVO vo) {
        return fpCommentDAO.getFpCommentList(vo);
    }

    // 댓글 삭제
    public void deleteFpComment(FpCommentVO vo) {
        fpCommentDAO.deleteFpComment(vo);
    }
    
    // 비밀 번호 일치확인
    public int verifyFpcPassword(int fpcSeq, String enteredPassword) {
        return fpCommentDAO.verifyFpcPassword(fpcSeq, enteredPassword);
    }
}
