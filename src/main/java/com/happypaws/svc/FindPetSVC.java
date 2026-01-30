package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.FindPetDAO;
import com.happypaws.vo.FindPetVO;

@Service("findPetSVC")
public class FindPetSVC {

    @Autowired
    private FindPetDAO findPetDAO;

    // 글등록
    public void insertFindPet(FindPetVO vo) {
        findPetDAO.insertFindPet(vo);
    }

    // 글수정
    public void updateFindPet(FindPetVO vo) {
        findPetDAO.updateFindPet(vo);
    }

    // 글삭제
    public void deleteFindPet(FindPetVO vo) {
        findPetDAO.deleteFindPet(vo);
    }

    // 글상세 조회
    public FindPetVO getFindPet(FindPetVO vo) {
        return findPetDAO.getFindPet(vo);
    }

    // 글목록 조회
    public List<FindPetVO> getFindPetList(FindPetVO vo) {
        return findPetDAO.getFindPetList(vo);
    }

    // 전체 페이지 수 조회
    public int countFindPet(FindPetVO vo) {
        return findPetDAO.countFindPet(vo);
    }

    // 조회수 카운트
    public void updateFindPetCnt(FindPetVO vo) {
        findPetDAO.updateFindPetCnt(vo);
    }

    // 현재 이미지 이름 가져오기
    public String getCurrentImage(int fpSeq) {
        return findPetDAO.getCurrentImage(fpSeq);
    }

    // 댓글 수 조회
    public void countFpComment(List<FindPetVO> findPetList) {
        for (FindPetVO findPet : findPetList) {
            int commentCount = findPetDAO.countFpComment(findPet.getFp_seq());
            findPet.setCommentCount(commentCount);
        }
    }
    
    // 비밀 번호 일치확인
    public int verifyPassword(int fpSeq, String enteredPassword) {
        return findPetDAO.verifyPassword(fpSeq, enteredPassword);
    }
}
