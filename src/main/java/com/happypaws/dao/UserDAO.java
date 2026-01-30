package com.happypaws.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.MyPostVO;
import com.happypaws.vo.UsersVO;


@Component
@Repository
public class UserDAO {
    @Autowired
    private SqlSession sql;

    public List<UsersVO> userSelectAll() {
        return sql.selectList("com.happypaws.dao.UserDAO.userSelectAll");
    }

    public List<UsersVO> searchUsers(String searchType, String searchKeyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);

        return sql.selectList("com.happypaws.dao.UserDAO.searchUsers", params);
    }

    
    public UsersVO user_detail(String us_id) {
        return sql.selectOne("com.happypaws.dao.UserDAO.user_detail", us_id);
    }

    
    public void user_update(UsersVO vo) {
    	
        sql.update("com.happypaws.dao.UserDAO.user_update", vo);
        
    }

//    public void us_is_del(String us_id) {
//        int deletedRows = sql.delete("com.happypaws.dao.UserDAO.us_is_del", us_id);
//       
//    }

    
    public UsersVO myPage(String us_id) {
        return sql.selectOne("com.happypaws.dao.UserDAO.myPage", us_id);
    }
    
    public void updateUserInfo(UsersVO user) {
        sql.update("com.happypaws.dao.UserDAO.updateUserInfo", user);
    }
    public UsersVO getUserById(String userId) {
        return sql.selectOne("com.happypaws.dao.UserDAO.getUserById", userId);
    }

    public void updatePassword(String adminId, String newPassword) {
        UsersVO user = new UsersVO();
        user.setUs_id(adminId);
        user.setUs_password(newPassword);
        sql.update("com.happypaws.dao.UserDAO.updatePassword", user);
    }
    
    public boolean updateUserToDeleted(String us_id) {
        int affectedRows = sql.update("com.happypaws.dao.UserDAO.updateUserToDeleted", us_id);
        return affectedRows > 0;  
    }



    public List<MyPostVO> findPostsByUserId(String usId) {
        return sql.selectList("com.happypaws.dao.UserDAO.findPostsByUserId", usId);
    }
    
    // 사용자 ID와 검색 조건으로 게시물 조회
    public List<MyPostVO> searchPostsByUserId(String us_id, String searchField, String searchQuery) {
        Map<String, Object> params = new HashMap<>();
        params.put("us_id", us_id);
        params.put("searchField", searchField);
        params.put("searchQuery", searchQuery);
        
        return sql.selectList("com.happypaws.dao.UserDAO.searchPostsByUserId", params);
      
    }

    // 단일 게시물 조회
    public MyPostVO findPostById(int postId) {
        return sql.selectOne("com.happypaws.dao.UserDAO.findPostById", postId);
    }
}





	
