package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.LostPetDAO;
import com.happypaws.vo.LostPetVO;

@Service("lostPetSVC")
public class LostPetSVC {
    
    @Autowired
    private LostPetDAO lostPetDAO;

    public void insertLostPet(LostPetVO vo) {
        lostPetDAO.insertLostPet(vo);
    }

    public void updateLostPet(LostPetVO vo) {
        lostPetDAO.updateLostPet(vo);
    }
    
    public void deleteLostPet(LostPetVO vo) {
        lostPetDAO.deleteLostPet(vo);
    }

    public LostPetVO getLostPet(LostPetVO vo) {
        return lostPetDAO.getLostPet(vo);
    }

    public List<LostPetVO> getLostPetList(LostPetVO vo) {
        return lostPetDAO.getLostPetList(vo);
    }

    public List<LostPetVO> getLostPetList() {
        return lostPetDAO.getLostPetList();
    }

    public int countLostPet(LostPetVO vo) {
        return lostPetDAO.countLostPet(vo);
    }

    public void updateLostPetCnt(LostPetVO vo) {
        lostPetDAO.updateLostPetCnt(vo);
    }

    public String getCurrentImage(int lp_seq) {
        return lostPetDAO.getCurrentImage(lp_seq);
    }

    public void countLpComment(List<LostPetVO> lostPetList) {
        for (LostPetVO lostPet : lostPetList) {
            int commentCount = lostPetDAO.countLpComment(lostPet.getLp_seq());
            lostPet.setCommentCount(commentCount);
        }
    }
}
