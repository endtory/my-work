<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고 도서 판매/나눔</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat_list.css">
    <script src="${pageContext.request.contextPath}/resources/js/chat_popup.js"></script>
</head>
<body>

<jsp:include page="/common/header.jsp" />

<h2>채팅 리스트</h2>

<div class="button">
<form action="junggo_list.do" method="get" class="junggo-form">
    <input type="submit" value="목록">
</form>

<form action="junggo_write.do" method="get" class="write-form">
    <input type="submit" value="글쓰기">
</form>
</div>

<!-- 로그인 사용자 아이디 -->
<c:set var="loginUserId" value="${sessionScope.user_Id}" />

<!-- 로그인 여부 체크 -->
<c:if test="${not empty loginRequired and loginRequired == true}">
    <script>
        if (confirm('로그인하지 않았습니다. 로그인 화면으로 이동하시겠습니까?')) {
            location.href = '${pageContext.request.contextPath}/login.do';
        } else {
            history.back();
        }
    </script>
</c:if>

<!-- 채팅방 리스트 -->
<div class="chat-list">
    <c:forEach var="chat" items="${chatList}">
	    <a class="chat-item" href="chat.do?id=${chat.OTHERUSERID}&chatRoomId=${chat.CHATROOMID}">
	        <div class="chat-info">
	            <div class="chat-title">
	                <b>${chat.OTHERNICKNAME}</b>
	            </div>
	            <div class="last-message">
	                <c:out value="${chat.LASTMESSAGE}" default="메시지 없음" />
	            </div>
	        </div>
	        <div class="chat-meta">
	            <c:if test="${not empty chat.LASTMESSAGETIME}">
	                <fmt:formatDate value="${chat.LASTMESSAGETIME}" pattern="MM.dd HH:mm"/>
	            </c:if>
	        </div>
	    </a>
	</c:forEach>

    <c:if test="${empty chatList}">
        <p class="no-chat">채팅 내역이 없습니다.</p>
    </c:if>
</div>

<!-- 페이지네이션 -->
<div class="pagination">
    <form method="get" action="chatList.do">
        <button name="page" value="${prevPage}" <c:if test="${!hasPrev}">disabled</c:if> >&lt;-</button>
        <c:forEach var="p" begin="1" end="${totalPages}">
            <button name="page" value="${p}" <c:if test="${currentPage == p}">disabled</c:if> >${p}</button>
        </c:forEach>
        <button name="page" value="${nextPage}" <c:if test="${!hasNext}">disabled</c:if> >&gt;-</button>
    </form>
</div>

<!-- 검색 폼 -->
<form method="get" action="chat_list.do" class="search-box">
    <label for="date">기간</label>
    <select name="date" id="date">
        <option value="전체기간">전체기간</option>
        <option value="1일">1일</option>
        <option value="1주">1주</option>
        <option value="1개월">1개월</option>
        <option value="6개월">6개월</option>
        <option value="1년">1년</option>
    </select>

    <label for="classification">검색 분류</label>
    <select name="classification" id="classification">
        <option value="글+댓글">글+댓글</option>
        <option value="제목">제목</option>
        <option value="작성자">작성자</option>
    </select>

    <label for="keyword">검색어</label>
    <input type="text" name="keyword" id="keyword">
    <input type="submit" value="검색">
</form>

<jsp:include page="/common/footer.jsp" />
</body>
</html>
