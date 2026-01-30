package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.CmtyDAO;
import com.happypaws.vo.CmtyCommentVO;
import com.happypaws.vo.CmtyupVO;
import com.happypaws.vo.CommunityVO;
import com.happypaws.vo.NoticeVO;

@Service
public class CmtySVC {
	
	@Autowired
	private CmtyDAO dao;
	
	//커뮤니티 - 리스트 불러오기
	public List<CommunityVO> cmty_list(CommunityVO vo) {
		return dao.cmty_list(vo);
	}
	
	//커뮤니티 - 글 갯수 보기
	public int countCmty(CommunityVO vo) {
		return dao.countCmty(vo);
	}
	
	//커뮤니티 - 상세보기
	public CommunityVO cmty_view(CommunityVO vo) {
		return dao.cmty_view(vo);
	}

	//커뮤니티 - 조회수 update
	public void cmty_count(CommunityVO vo) {
		dao.cmty_count(vo);
	}
	
	//커뮤니티 - 커뮤니티 수정
	public void cmty_update(CommunityVO vo) {
		dao.cmty_update(vo);
	}
	
	//커뮤니티 -글쓰기
	public int cmty_insert(CommunityVO vo) {
		return dao.cmty_insert(vo);
	}

	// 커뮤니티 - 글 삭제
	public void cmty_delete(CommunityVO vo) {
		dao.cmty_delete(vo);
	}
	
	//커뮤니티 - 댓글쓰기(기본)
	public void c_addComment(CmtyCommentVO vo) {
		dao.c_addComment(vo);
	}
	
    //커뮤니티 - 댓글 삭제
    public void c_delComment(CmtyCommentVO comment) {
    	dao.c_delComment(comment);
    }

    //커뮤니티 - 댓글 수정
    public void c_updateComment(CmtyCommentVO comment) {
    	dao.c_updateComment(comment);
    }
    
	//커뮤니티 - 댓글 가져오기
    public List<CmtyCommentVO> c_commentList(CmtyCommentVO comment) {
    	return dao.c_commentList(comment);
    }
    
    //커뮤니티 - 대댓글추가
    public void c_addReply(CmtyCommentVO comment) {
    	dao.c_addReply(comment);
    }
    
    //커뮤니티 -추천
    public String cmty_up(CmtyupVO vo) {
    	return dao.cmty_up(vo);
    }
    
    //커뮤니티 -추천수 가져오기
    public int cmty_up_cut(CmtyupVO vo) {
    	return dao.cmty_up_cut(vo);
    }

    // 시작 페이지
	public List<CmtyupVO> cmyt_index() {
		return dao.cmty_index();
	}
    
}
