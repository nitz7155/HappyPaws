package com.happypaws.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.LostPetVO;

@Repository
public class LostPetDAO {
    @Autowired
    private SqlSessionTemplate mybatis;

    // 글등록
    public void insertLostPet(LostPetVO vo) {
        // 현재 날짜와 시간 가져오기
        LocalDateTime currentDateTime = LocalDateTime.now();
        
        // 날짜 포맷
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDateTime = currentDateTime.format(formatter);
        
        vo.setLp_date(formattedDateTime);
        mybatis.insert("LostPetDAO.insertLostPet", vo);
    }

    // 글수정
    public void updateLostPet(LostPetVO vo) {
        mybatis.update("LostPetDAO.updateLostPet", vo);
    }

    // 글삭제
    public void deleteLostPet(LostPetVO vo) {
        mybatis.delete("LostPetDAO.deleteLostPet", vo);
    }
    
    // 글상세 조회
    public LostPetVO getLostPet(LostPetVO vo) {
        return mybatis.selectOne("LostPetDAO.getLostPet", vo);
    }

    // 글목록 조회
    public List<LostPetVO> getLostPetList(LostPetVO vo) {
        return mybatis.selectList("LostPetDAO.getLostPetList", vo);
    }
    
    // 글목록 조회
    public List<LostPetVO> getLostPetList() {
    	return mybatis.selectList("LostPetDAO.getLostPetListIndex");
    }

    
    // 전체 페이지 수 조회
    public int countLostPet(LostPetVO vo) {
        return mybatis.selectOne("LostPetDAO.countLostPet", vo);
    }

    // 조회수 카운트
    public void updateLostPetCnt(LostPetVO vo) {
        mybatis.update("LostPetDAO.updateLostPetCnt", vo);
    }

    // 현재 이미지 이름 가져오기
    public String getCurrentImage(int lp_seq) {
        return mybatis.selectOne("LostPetDAO.getCurrentImage", lp_seq);
    }
    
    // 댓글 수 조회
    public int countLpComment(int lp_seq) {
        return mybatis.selectOne("LostPetDAO.countLpComment", lp_seq);
    }
}
