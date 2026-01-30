package com.happypaws.util;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;

public class Argon2Util {
	/** 비밀번호 해싱 */
	public static String hashPassword(String password) {
		// Argon2 인스턴스 생성
		Argon2 argon2 = Argon2Factory.create();
		String hash = null;

		try {
			int iterations = 3; // 해시 반복 횟수
			int memory = 65536; // 메모리 사용량(64MB)
			int parallelism = 1; // 병렬 처리 스레드 수

			// 비밀번호를 Argon2로 해싱
			String[] hashArray = argon2.hash(iterations, memory, parallelism, password.toCharArray()).split("\\$");
			hash = hashArray[4] + "$" + hashArray[5];
		} finally {
			// 비밀번호 메모리에서 지우기
			argon2.wipeArray(password.toCharArray());
		}

		return hash;
	}

	/* 비밀번호 검증 */
	public static boolean verifyPassword(String hash, String password) {
		Argon2 argon2 = Argon2Factory.create();

		// 비밀번호와 해시 값 비교
		return argon2.verify("$argon2i$v=19$m=65536,t=3,p=1$" + hash, password.toCharArray());
	}
}