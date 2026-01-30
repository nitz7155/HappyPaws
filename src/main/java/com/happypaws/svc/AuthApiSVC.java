package com.happypaws.svc;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import javax.annotation.PreDestroy;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.happypaws.util.Argon2Util;
import com.happypaws.vo.UsersVO;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service
public class AuthApiSVC implements InitializingBean {
	@Autowired
	private ServletContext servletContext;

	// ========== naver ========== //
	@Value("${spring.security.oauth2.client.registration.naver.client-id}")
	private String naverClientId;
	@Value("${spring.security.oauth2.client.registration.naver.client-secret}")
	private String naverClientSecret;
	@Value("${spring.security.oauth2.client.provider.naver.authorization-uri}")
	private String naverAuthorizationUri;
	@Value("${spring.security.oauth2.client.registration.naver.redirect-uri}")
	private String naverRedirectUri;
	@Value("${spring.security.oauth2.client.provider.naver.token-uri}")
	private String naverTokenUri;
	@Value("${spring.security.oauth2.client.provider.naver.user-info-uri}")
	private String naverUserInfoUrl;
	@Value("${spring.security.oauth2.client.provider.naver.logout-uri}")
	private String naverLogoutUri;
	@Value("${spring.security.oauth2.client.provider.naver.logout-returl}")
	private String naverLogoutReturl;

	// ========== kakao ========== //
	@Value("${spring.security.oauth2.client.registration.kakao.client-id}")
	private String kakaoClientId;
	@Value("${spring.security.oauth2.client.registration.kakao.client-secret}")
	private String kakaoClientSecret;
	@Value("${spring.security.oauth2.client.provider.kakao.authorization-uri}")
	private String kakaoAuthorizationUri;
	@Value("${spring.security.oauth2.client.registration.kakao.redirect-uri}")
	private String kakaoRedirectUri;
	@Value("${spring.security.oauth2.client.provider.kakao.token-uri}")
	private String kakaoTokenUri;
	@Value("${spring.security.oauth2.client.provider.kakao.user-info-uri}")
	private String kakaoUserInfoUri;
	@Value("${spring.security.oauth2.client.provider.kakao.logout-uri}")
	private String kakaoLogoutUri;
	@Value("${spring.security.oauth2.client.provider.kakao.logout-continue-uri}")
	private String kakaoLogoutContinueUri;
	@Value("${spring.security.oauth2.client.provider.kakao.logout-redirect-uri}")
	private String kakaoLogoutRedirectUri;

	// ========== coolsms ========== //
	private DefaultMessageService messageService;
	private final Map<String, String> verificationCodeStore = new HashMap<>();
	private final Map<String, ScheduledFuture<?>> scheduledTasks = new HashMap<>();
	private final SecureRandom random = new SecureRandom();
	private final ThreadPoolTaskScheduler taskScheduler = new ThreadPoolTaskScheduler();

	@Value("${spring.security.oauth2.client.registration.coolsms.client-id}")
	private String coolsmsApiKey;
	@Value("${spring.security.oauth2.client.registration.coolsms.client-secret}")
	private String coolsmsApiSecret;
	@Value("${spring.security.oauth2.client.registration.coolsms.sender-number}")
	private String coolsmsSendNumber;

	public AuthApiSVC() {
		taskScheduler.initialize();
	}

	// ========== login divider common ========== //
	@Value("${spring.security.oauth2.client.registration.divider.authorization-grant-type}")
	private String grantType;

	public void snsLoginUrl(HttpServletRequest request) throws UnsupportedEncodingException {
		String state = UUID.randomUUID().toString();
		request.getSession().setAttribute("oauthState", state);

		String naverLoginUrl = naverAuthorizationUri
			+ "?response_type=code"
			+ "&client_id=" + naverClientId
			+ "&state=" + state
			+ "&redirect_uri=" + URLEncoder.encode(naverRedirectUri, "UTF-8");

		String kakaoLoginUrl = kakaoAuthorizationUri
			+ "?response_type=code"
			+ "&client_id=" + kakaoClientId
			+ "&state=" + state
			+ "&redirect_uri=" + URLEncoder.encode(kakaoRedirectUri, "UTF-8");

		request.setAttribute("naverLoginUrl", naverLoginUrl);
		request.setAttribute("kakaoLoginUrl", kakaoLoginUrl);
	}

	// ========== method by login divider ========== //
	public UsersVO requestNaverUserDetails(String code, String state) throws JsonMappingException, JsonProcessingException, UnsupportedEncodingException {
		// request token
		String tokenUrl = naverTokenUri
			+ "?grant_type=" + grantType
			+ "&client_id=" + naverClientId
			+ "&client_secret=" + naverClientSecret
			+ "&code=" + code
			+ "&state=" + state;
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> response = restTemplate.exchange(
			tokenUrl,
			HttpMethod.GET,
			new HttpEntity<>(new HttpHeaders()),
			String.class
		);

		String accessToken = (new ObjectMapper()).readTree(response.getBody()).path("access_token").asText();

		if (accessToken == null) {
			return null;
		}

		// request profile
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + accessToken);
	
		restTemplate = new RestTemplate();
		response = restTemplate.exchange(
			naverUserInfoUrl,
			HttpMethod.GET,
			new HttpEntity<>(headers),
			String.class
		);

		JsonNode responseNode = (new ObjectMapper()).readTree(response.getBody()).path("response");
		UsersVO user = new UsersVO();
		user.setUs_id(responseNode.path("id").asText());
		user.setUs_sns("naver");
		user.setUs_password(Argon2Util.hashPassword(Argon2Util.hashPassword(accessToken)));
		user.setUs_name(URLDecoder.decode(responseNode.path("name").asText(), "UTF-8"));
		user.setUs_nick(URLDecoder.decode(responseNode.path("nickname").asText(), "UTF-8"));
		user.setUs_email(responseNode.path("email").asText());
		user.setUs_phone(responseNode.path("mobile").asText());
		user.setUs_profile(responseNode.path("profile_image").asText().replaceAll("\\/", "/"));

		return user;
	}

	public UsersVO requestKakaoUserDetails(String code) throws JsonMappingException, JsonProcessingException, UnsupportedEncodingException {
		// request token
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", grantType);
		params.add("client_id", kakaoClientId);
		params.add("redirect_uri", kakaoRedirectUri);
		params.add("code", code);
		params.add("client_secret", kakaoClientSecret);

		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
		ResponseEntity<String> response = restTemplate.postForEntity(kakaoTokenUri, request, String.class);

		String accessToken = (new ObjectMapper()).readTree(response.getBody()).path("access_token").asText();

		if (accessToken == null) {
			return null;
		}

		// request profile
		headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + accessToken);

		restTemplate = new RestTemplate();
		HttpEntity<String> entity = new HttpEntity<>(headers);

		response = restTemplate.exchange(kakaoUserInfoUri, HttpMethod.GET, entity, String.class);

		ObjectMapper objectMapper = new ObjectMapper();
		UsersVO user = null;
		JsonNode rootNode = objectMapper.readTree(response.getBody());
		JsonNode kakaoAccountNode = rootNode.path("kakao_account");
		user = new UsersVO();
		user.setUs_id(rootNode.path("id").asText());
		user.setUs_sns("kakao");
		user.setUs_password(Argon2Util.hashPassword(Argon2Util.hashPassword(accessToken)));
		user.setUs_name(kakaoAccountNode.path("name").asText());
		user.setUs_nick(kakaoAccountNode.path("profile").path("nickname").asText());
		user.setUs_email(kakaoAccountNode.path("email").asText());
		user.setUs_phone(kakaoAccountNode.path("phone_number").asText());
		user.setUs_profile(kakaoAccountNode.path("profile").path("thumbnail_image_url").asText());
		return user;
	}

	public void saveProfileImage(UsersVO user) {
		String imageUrl = user.getUs_profile();
		if (imageUrl.isEmpty() || imageUrl == null) {
			user.setUs_profile("default.jpg");
			return;
		}
		String fileName = user.getUs_id();

		try {
			// 이미지 URL에서 확장자 추출
			String fileExtension = imageUrl.substring(imageUrl.lastIndexOf('.'));
			if (!fileName.endsWith(fileExtension)) {
				fileName = fileName + fileExtension;
			}

			// webapp/resources/uploads 폴더의 절대 경로 가져오기
			String uploadDirPath = servletContext.getRealPath("/resources/profile_images/");
			File uploadDir = new File(uploadDirPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs(); // 디렉토리가 없으면 생성
			}

			File saveFile = new File(uploadDir, fileName);

			// URL로부터 연결을 생성하여 이미지 다운로드
			URL url = new URL(imageUrl);
			URLConnection connection = url.openConnection();
			BufferedInputStream inputStream = new BufferedInputStream(connection.getInputStream());
			FileOutputStream fileOutputStream = new FileOutputStream(saveFile);

			byte[] buffer = new byte[1024];
			int bytesRead;
			while ((bytesRead = inputStream.read(buffer, 0, 1024)) != -1) {
				fileOutputStream.write(buffer, 0, bytesRead);
			}

			// 스트림 닫기
			inputStream.close();
			fileOutputStream.close();
			user.setUs_profile(fileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// ========== method by logout divider ========== //
	public String requestNaverLogoutUri(Model model) {
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet get = new HttpGet(naverLogoutUri);
		try {
			client.execute(get);
			model.addAttribute("logoutMassage", "네이버에서 정상적으로 로그아웃 처리되었습니다.");
		} catch (Exception e) {
			model.addAttribute("logoutMassage", "네이버에서 정상적으로 로그아웃 처리되지 않았습니다.");
		}
		return "/WEB-INF/auth/naverLogout.jsp";
	}

	public String requestKakaoLogoutUri(HttpServletRequest request) throws UnsupportedEncodingException {
		String state = UUID.randomUUID().toString();
		request.getSession().setAttribute("oauthState", state);

		String logoutUri = kakaoLogoutUri
				+ "?continue=" + URLEncoder.encode(kakaoLogoutContinueUri
					+ "?through_account=true"
					+ "&state=" + state
					+ "&logout_redirect_uri=" + URLEncoder.encode(kakaoLogoutRedirectUri, "UTF-8")
					+ "&client_id=" + kakaoClientId, "UTF-8");

		return logoutUri;
	}
	
	// ========== cool sms methods ========== //
	@Override
	public void afterPropertiesSet() {
		this.messageService = NurigoApp.INSTANCE.initialize(coolsmsApiKey, coolsmsApiSecret, "https://api.coolsms.co.kr");
	}

	public String generateAndSendCode(String phoneNumber) {
		String code = String.format("%06d", random.nextInt(1000000));
		verificationCodeStore.put(phoneNumber, code);

		// 인증 코드는 5분 동안 유효
		ScheduledFuture<?> scheduledTask = taskScheduler.schedule(() -> {
			verificationCodeStore.remove(phoneNumber);
			scheduledTasks.remove(phoneNumber);
		}, new java.util.Date(System.currentTimeMillis() + TimeUnit.MINUTES.toMillis(5)));
		scheduledTasks.put(phoneNumber, scheduledTask);

		Message message = new Message();
		message.setFrom(coolsmsSendNumber);
		message.setTo(phoneNumber);
		message.setText("HappyPaws\n인증번호는 [" + code + "] 입니다.");

		try {
			SingleMessageSentResponse response = messageService.sendOne(new SingleMessageSendingRequest(message));
			return response.getMessageId();
		} catch (Exception e) {
			return null;
		}
	}

	public boolean verifyCode(String phoneNumber, String code) {
		String storedCode = verificationCodeStore.get(phoneNumber);
		if (storedCode != null && storedCode.equals(code)) {
			ScheduledFuture<?> scheduledTask = scheduledTasks.remove(phoneNumber);
			if (scheduledTask != null) {
				scheduledTask.cancel(true);
			}
			verificationCodeStore.remove(phoneNumber);
			return true;
		}
		return false;
	}

	@PreDestroy
	public void cleanUp() {
		taskScheduler.shutdown();
	}
}