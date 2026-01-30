package com.happypaws.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.happypaws.vo.UsersVO;

public class CookieReadingFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		if (request instanceof HttpServletRequest) {
			HttpServletRequest httpRequest = (HttpServletRequest) request;
			HttpSession session = httpRequest.getSession();
			UsersVO sessionValue = (session != null) ? (UsersVO) session.getAttribute("user") : null;

			if (sessionValue == null) {
				UsersVO user = JwtCookieUtil.extractJwtFromCookie(httpRequest);
				if (user != null) {
					session.setAttribute("user", user);
				}
			}
		}

		chain.doFilter(request, response);
	}
}