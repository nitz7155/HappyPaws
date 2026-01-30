package com.happypaws.svc;

import java.net.URI;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.AuthDAO;
import com.happypaws.vo.UsersVO;

@Service
public class AuthSVC {
	@Autowired
	private AuthDAO dao;

	public UsersVO login(UsersVO user) {
		return dao.login(user);
	}

    public Map<String, String> getQueryParams(String url) {
        Map<String, String> queryPairs = new HashMap<>();
        try {
            URI uri = new URI(url);
            String query = uri.getQuery(); // 쿼리 문자열 추출
            if (query != null) {
                String[] pairs = query.split("&");
                for (String pair : pairs) {
                    String[] keyValue = pair.split("=", 2);
                    String key = URLDecoder.decode(keyValue[0], StandardCharsets.UTF_8);
                    String value = keyValue.length > 1 
                                   ? URLDecoder.decode(keyValue[1], StandardCharsets.UTF_8)
                                   : "";
                    queryPairs.put(key, value);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return queryPairs;
    }

	public boolean snsJoin(UsersVO user) {
		return dao.snsJoin(user);
	}

	public boolean checkId(String id) {
		return dao.checkId(id);
	}

	public boolean checkNick(String nick) {
		return dao.checkNick(nick);
	}

	public boolean join(UsersVO user) {
		return dao.join(user);
	}

	public List<String> findId(UsersVO user) {
		List<String> findIds = dao.findId(user);
		findIds.replaceAll(findId -> findId = maskUserName(findId));
		return findIds;
	}
	
	private String maskUserName(String username) {
        int length = username.length();

        if (length <= 4) {
            // 길이가 4자 이하인 경우, 마지막 두 글자 마스킹
            return username.substring(0, 2) + "**";
        } else if (length <= 8) {
            // 길이가 5~8자인 경우, 중간 2~3글자 마스킹
            int start = 2;
            int end = Math.min(length, start + 3);
            return username.substring(0, start) + "*".repeat(end - start) + username.substring(end);
        } else {
            // 길이가 9자 이상인 경우, 중간 4글자 마스킹
            int start = 3;
            int end = Math.min(length, start + 4);
            return username.substring(0, start) + "*".repeat(end - start) + username.substring(end);
        }
    }

	public boolean checkUser(UsersVO user) {
		return dao.checkUser(user);
	}

	public boolean findPw(UsersVO user) {
		return dao.findPw(user);
	}
}