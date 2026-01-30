package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.NewFamilyDAO;  // NewFamilyDAO로 변경
import com.happypaws.vo.NewFamilyVO;    // NewFamilyVO로 변경

@Service("newFamilySVC")  // 서비스 이름도 변경
public class NewFamilySVC {
    
    @Autowired
    private NewFamilyDAO newFamilyDAO;  // NewFamilyDAO로 변경

    // 글 등록
    public void insertNewFamily(NewFamilyVO vo) {
        newFamilyDAO.insertNewFamily(vo);  // NewFamily 글 등록 (NewFamilyDAO 메서드 호출)
    }

    // 글 수정
    public void updateNewFamily(NewFamilyVO vo) {
        newFamilyDAO.updateNewFamily(vo);  // NewFamily 글 수정 (NewFamilyDAO 메서드 호출)
    }
    
    // 글 삭제
    public void deleteNewFamily(NewFamilyVO vo) {
        newFamilyDAO.deleteNewFamily(vo);  // NewFamily 글 삭제 (NewFamilyDAO 메서드 호출)
    }
    
    // 글 상세 조회
    public NewFamilyVO getNewFamily(NewFamilyVO vo) {
        return newFamilyDAO.getNewFamily(vo);  // NewFamily 글 상세 조회 (NewFamilyDAO 메서드 호출)
    }

    // 글 목록 조회
    public List<NewFamilyVO> getNewFamilyList(NewFamilyVO vo) {
        return newFamilyDAO.getNewFamilyList(vo);  // NewFamily 글 목록 조회 (NewFamilyDAO 메서드 호출)
    }
    
    // 글 목록 조회
    public List<NewFamilyVO> getNewFamilyList() {
        return newFamilyDAO.getNewFamilyList();
    }

    // 전체 페이지 수 조회
    public int countNewFamily(NewFamilyVO vo) {
        return newFamilyDAO.countNewFamily(vo);  // NewFamily 전체 글 수 조회 (NewFamilyDAO 메서드 호출)
    }

    // 조회수 카운트
    public void updateNewFamilyCnt(NewFamilyVO vo) {
        newFamilyDAO.updateNewFamilyCnt(vo);  // NewFamily 글 조회수 카운트 업데이트 (NewFamilyDAO 메서드 호출)
    }

    // 현재 이미지 이름 가져오기
    public String getCurrentImage(int nf_seq) {
        return newFamilyDAO.getCurrentImage(nf_seq);  // NewFamily 이미지 가져오기 (NewFamilyDAO 메서드 호출)
    }

    // 댓글 수 조회
    public void countNfComment(List<NewFamilyVO> newFamilyList) {
        for (NewFamilyVO newFamily : newFamilyList) {
            int commentCount = newFamilyDAO.countNfComment(newFamily.getNf_seq());  // 댓글 수 조회 (NewFamilyDAO 메서드 호출)
            newFamily.setCommentCount(commentCount);  // 댓글 수 설정
        }
    }
}
