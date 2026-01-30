package com.happypaws.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.UsersVO;

@Repository
public class AdDAO {

    @Autowired
    private SqlSession sqlSession;
    
 // 관리자 정보 조회 메서드
    public UsersVO getAdminById(String us_id) {
        return sqlSession.selectOne("AdDAO.getAdminById", us_id);
    }


    // 관리자 비밀번호 조회
    public String getPasswordById(String us_id) {
        return sqlSession.selectOne("AdDAO.getPasswordById", us_id);
    }

    // 비밀번호 업데이트
    public void updatePassword(String us_id, String newPassword) {
    	
        Map<String, Object> params = new HashMap<>();
        params.put("us_id", us_id);
        params.put("us_password", newPassword);
        sqlSession.update("AdDAO.updatePassword", params);
    }


}
