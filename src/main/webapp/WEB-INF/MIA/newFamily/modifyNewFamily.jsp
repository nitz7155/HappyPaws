<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../MIA.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>행복한 발자국</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/MIA.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/newFamily.js"></script>
<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
</head>
<body>
    <jsp:include page="${pageContext.request.contextPath}/header.jsp" />
    <main>
        <div class="n_write">
            <h1>새로운 가족을 찾아요</h1>
            <div class="n_writeform">
                <form action="/MIA/updateNewFamily" method="post" enctype="multipart/form-data" name="boardform">
                    <input type="hidden" name="nf_seq" value="${newFamily.nf_seq}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="category" value="${category}">
                    <input type="hidden" name="nowPage" value="${nowPage}">

                    <div class="n_title">
                        <input type="text" class="form-control" name="nf_title" value="${newFamily.nf_title}" placeholder="제목을 입력하세요." required maxlength="30">
                    </div>

                    <div class="n_ph">
                        <input type="text" class="form-control" name="nf_ph" value="${newFamily.nf_ph}" placeholder="연락처를 입력하세요." required
                        oninput="formatPhoneNumber(this)" maxlength="13">
                    </div>

                    <div class="n_img">
                        <img src="${pageContext.request.contextPath}/resources/MIA-img/newFamilyImg/${newFamily.nf_img}" 
                        onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/MIA-img/default.png';"
                        alt="New Family Image" class="new-family-image">
                        <div class="img_save">
                            <label for="file2" class="upload-btn" style="cursor: pointer;">
                                <input id="file2" type="file" name="uploadFile" accept="image/*" style="display: none;" />
                                <span>사진 첨부</span>
                            </label>
                        </div>
                    </div>

                    <div class="n_detail">
                        <table class="detail-table">
                            <tr class="detail-row">
                                <td class="label">분양 지역</td>
                                <td class="value">
                                    <input type="text" class="form-control" name="nf_place" value="${newFamily.nf_place}" required maxlength="30">
                                </td>
                            </tr>
                            <tr class="detail-row">
                                <td class="label">나이</td>
                                <td class="value">
                                    <input type="text" class="form-control" name="nf_age" value="${newFamily.nf_age}" required maxlength="10">
                                </td>
                            </tr>
                            <tr class="detail-row">
                                <td class="label">성별</td>
                                <td class="value">
                                    <select class="form-control" name="nf_gender" required>
                                        <option value="M" <c:if test="${newFamily.nf_gender.equals('M')}">selected</c:if>>남</option>
                                        <option value="F" <c:if test="${newFamily.nf_gender.equals('F')}">selected</c:if>>여</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="detail-row">
                                <td class="label">분류</td>
                                <td class="value">
                                    <select class="form-control" name="nf_category" required>
                                        <option value="dog" <c:if test="${newFamily.nf_category == 'dog'}">selected</c:if>>강아지</option>
                                        <option value="cat" <c:if test="${newFamily.nf_category == 'cat'}">selected</c:if>>고양이</option>
                                        <option value="small" <c:if test="${newFamily.nf_category == 'small'}">selected</c:if>>소동물</option>
                                        <option value="etc" <c:if test="${newFamily.nf_category == 'etc'}">selected</c:if>>기타</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="detail-row">
                                <td class="label">품종</td>
                                <td class="value">
                                    <input type="text" class="form-control" name="nf_breed" value="${newFamily.nf_breed}" required maxlength="10">
                                </td>
                            </tr>
                            <tr class="detail-row">
                                <td class="label">상태</td>
                                <td class="value">
                                    <select class="form-control" name="nf_ok" required>
                                        <option value="N" <c:if test="${newFamily.nf_ok == 'N'}">selected</c:if>>분양 중이에요</option>
                                        <option value="Y" <c:if test="${newFamily.nf_ok == 'Y'}">selected</c:if>>분양 완료했어요</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="n_content">
                        <textarea cols="100" wrap="soft" class="form-control" rows="5" name="nf_content" placeholder="상세 설명을 입력하세요">${newFamily.nf_content}</textarea>
                    </div>

                    <input type="hidden" name="nf_del" value="${newFamily.nf_del}">
                    <div class="btn-container">
                        <button id="submit" type="submit">글 수정</button>
                        <button id="rollback" type="button" onclick="history.back()">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
    <jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>
