package com.happypaws.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.UsersVO;

@Repository
public class AuthDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	public UsersVO login(UsersVO user) {
		return mybatis.selectOne("AuthDAO.login", user);
	}

	public boolean snsJoin(UsersVO user) {
		return mybatis.insert("AuthDAO.snsJoin", user) > 0;
	}

	public boolean checkId(String id) {
		return (int) mybatis.selectOne("AuthDAO.checkId", id) <= 0;
	}

	public boolean checkNick(String nick) {
		return (int) mybatis.selectOne("AuthDAO.checkNick", nick) <= 0;
	}

	public boolean join(UsersVO user) {
		return mybatis.insert("AuthDAO.join", user) > 0;
	}

	public List<String> findId(UsersVO user) {
		return mybatis.selectList("AuthDAO.findId", user);
	}

	public boolean checkUser(UsersVO user) {
		return (int) mybatis.selectOne("AuthDAO.checkUser", user) > 0;
	}

	public boolean findPw(UsersVO user) {
		return mybatis.update("AuthDAO.findPw", user) > 0;
	}
}