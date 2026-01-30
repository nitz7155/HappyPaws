package com.happypaws.svc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.happypaws.dao.AdDAO;
import com.happypaws.util.Argon2Util;

@Service
public class AdSVC {

    @Autowired
    private AdDAO dao;

    // 데이터베이스에서 저장된 해시된 비밀번호 가져오기
    public String getStoredPasswordHash(String us_id) {
        return dao.getPasswordById(us_id); // DAO에서 비밀번호 해시 가져오기
    }

    // 현재 비밀번호 검증
    public boolean verifyPassword(String us_id, String currentPassword) {
        // 저장된 해시된 비밀번호 가져오기
        String storedHash = getStoredPasswordHash(us_id);
        return storedHash != null && Argon2Util.verifyPassword(storedHash, currentPassword);
    }

    // 비밀번호 업데이트
    public void updatePassword(String us_id, String hashedPassword) {
        dao.updatePassword(us_id, hashedPassword); // 해시된 비밀번호 저장
    }
}
