package com.happypaws.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.NewFamilyVO;

@Repository
public class NewFamilyDAO {

    @Autowired
    private SqlSessionTemplate mybatis;

 
    public void insertNewFamily(NewFamilyVO vo) {
        // 현재 날짜와 시간 가져오기
        LocalDateTime currentDateTime = LocalDateTime.now();

        // 날짜 포맷
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDateTime = currentDateTime.format(formatter);

        vo.setNf_date(formattedDateTime);
        mybatis.insert("NewFamilyDAO.insertNewFamily", vo);
    }

    
    public void updateNewFamily(NewFamilyVO vo) {
        mybatis.update("NewFamilyDAO.updateNewFamily", vo);
    }

    public void deleteNewFamily(NewFamilyVO vo) {
        mybatis.update("NewFamilyDAO.deleteNewFamily", vo);
    }

    public NewFamilyVO getNewFamily(NewFamilyVO vo) {
        return mybatis.selectOne("NewFamilyDAO.getNewFamily", vo);
    }

    public List<NewFamilyVO> getNewFamilyList(NewFamilyVO vo) {
        return mybatis.selectList("NewFamilyDAO.getNewFamilyList", vo);
    }
    
    public List<NewFamilyVO> getNewFamilyList() {
        return mybatis.selectList("NewFamilyDAO.getNewFamilyListIndex");
    }
     
    public int countNewFamily(NewFamilyVO vo) {
        return mybatis.selectOne("NewFamilyDAO.countNewFamily", vo);
    }

    public void updateNewFamilyCnt(NewFamilyVO vo) {
        mybatis.update("NewFamilyDAO.updateNewFamilyCnt", vo);
    }

    // 현재 이미지 이름 가져오기
    public String getCurrentImage(int nf_seq) {
        return mybatis.selectOne("NewFamilyDAO.getCurrentImage", nf_seq);
    }
 
    public int countNfComment(int nf_seq) {
        return mybatis.selectOne("NewFamilyDAO.countNfComment", nf_seq);
    }
}
