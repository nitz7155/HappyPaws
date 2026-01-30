package com.happypaws.util;

import java.nio.charset.StandardCharsets;
import java.util.Date;

import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.happypaws.vo.UsersVO;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JwtCookieUtil {
	private static final String SECRET_KEY = "JHaTvaaeFpualplmsytLaPcikaCflwaesss"; // 비밀키
	private static final long EXPIRATION_TIME = 1000 * 60 * 60 * 12; // 1일 유효
	private static final String TOKEN_NAME = "uithp";

	// JWT 생성 및 쿠키 저장 메서드
	/** 로그인 시 */
	public static void createJwtCookie(HttpServletResponse response, UsersVO user) {
		SecretKeySpec secretKeySpec = new SecretKeySpec(
				SECRET_KEY.getBytes(StandardCharsets.UTF_8),
				SignatureAlgorithm.HS256.getJcaName());

		String token = Jwts.builder().setSubject(user.getUs_id())
				.claim("us_sns", user.getUs_sns())
				.claim("us_name", user.getUs_name())
				.claim("us_nick", user.getUs_nick())
				.claim("us_profile", user.getUs_profile())
				.setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
				.signWith(secretKeySpec, SignatureAlgorithm.HS256)
				.compact();

		Cookie jwtCookie = new Cookie(TOKEN_NAME, token);
		jwtCookie.setHttpOnly(true);
		jwtCookie.setSecure(false);
		jwtCookie.setMaxAge((int) EXPIRATION_TIME / 1000);
		jwtCookie.setPath("/");
		response.addCookie(jwtCookie);
	}

	// 쿠키에서 JWT 추출 및 정보 검증 메서드
	/** 상시 */
	public static UsersVO extractJwtFromCookie(HttpServletRequest request) {
		SecretKeySpec secretKeySpec = new SecretKeySpec(
				SECRET_KEY.getBytes(StandardCharsets.UTF_8),
				SignatureAlgorithm.HS256.getJcaName());

		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (TOKEN_NAME.equals(cookie.getName())) {
					Claims claims = Jwts.parserBuilder()
							.setSigningKey(secretKeySpec).build()
							.parseClaimsJws(cookie.getValue()).getBody();
					UsersVO user = new UsersVO();
					user.setUs_id(claims.getSubject());
					user.setUs_sns((String) claims.get("us_sns"));
					user.setUs_name((String) claims.get("us_name"));
					user.setUs_nick((String) claims.get("us_nick"));
					user.setUs_profile((String) claims.get("us_profile"));
					return user;
				}
			}
		}
		return null;
	}

	// JWT 쿠키 삭제 메서드
	/** 로그아웃 시 */
	public static void deleteJwtCookie(HttpServletResponse response) {
		Cookie jwtCookie = new Cookie(TOKEN_NAME, null);
		jwtCookie.setMaxAge(0);
		jwtCookie.setPath("/");
		response.addCookie(jwtCookie);
	}
}