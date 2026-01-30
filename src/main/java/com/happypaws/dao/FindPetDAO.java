package com.happypaws.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.FindPetVO;

@Repository
public class FindPetDAO {
    @Autowired
    private SqlSessionTemplate mybatis;

    // 글등록
    public void insertFindPet(FindPetVO vo) {
        // 현재 날짜와 시간 가져오기
        LocalDateTime currentDateTime = LocalDateTime.now();
        
        // 날짜 포맷
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDateTime = currentDateTime.format(formatter);
        
        vo.setFp_date(formattedDateTime);
        mybatis.insert("FindPetDAO.insertFindPet", vo);
    }

    // 글수정
    public void updateFindPet(FindPetVO vo) {
        mybatis.update("FindPetDAO.updateFindPet", vo);
    }

    // 글삭제
    public void deleteFindPet(FindPetVO vo) {
        mybatis.delete("FindPetDAO.deleteFindPet", vo);
    }

    // 글상세 조회
    public FindPetVO getFindPet(FindPetVO vo) {
        return mybatis.selectOne("FindPetDAO.getFindPet", vo);
    }

    // 글목록 조회
    public List<FindPetVO> getFindPetList(FindPetVO vo) {
        return mybatis.selectList("FindPetDAO.getFindPetList", vo);
    }
    
    // 전체 페이지 수 조회
    public int countFindPet(FindPetVO vo) {
        return mybatis.selectOne("FindPetDAO.countFindPet", vo);
    }

    // 조회수 카운트
    public void updateFindPetCnt(FindPetVO vo) {
        mybatis.update("FindPetDAO.updateFindPetCnt", vo);
    }

    // 현재 이미지 이름 가져오기
    public String getCurrentImage(int fpSeq) {
        return mybatis.selectOne("FindPetDAO.getCurrentImage", fpSeq);
    }

    // 댓글 수 조회
    public int countFpComment(int fp_seq) {
        return mybatis.selectOne("FindPetDAO.countFpComment", fp_seq);
    }
    
    // 비밀 번호 일치확인
    public int verifyPassword(int fpSeq, String enteredPassword) {
        Map<String, Object> params = new HashMap<>();
        params.put("fpSeq", fpSeq);
        params.put("enteredPassword", enteredPassword);
        return mybatis.selectOne("FindPetDAO.verifyPassword", params);
    }
}
