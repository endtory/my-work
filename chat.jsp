<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1 채팅</title>

    <!-- CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/chat.css">

    <!-- contextPath 변수 정의 -->
    <script type="text/javascript">
        const contextPath = "<%= request.getContextPath() %>";
    </script>

    <!-- JavaScript -->
    <script src="<%= request.getContextPath() %>/resources/js/chat.js"></script>
</head>
<body>
    
    <!-- update -->
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

    <!-- 로그인 사용자 아이디 변수 -->
    <c:set var="loginUserId" value="${sessionScope.user_Id}" />

    <!-- 상대방 ID 제목 표시 -->
    <h2><c:out value="${partnerNickname}"/>님과의 채팅</h2>

    <!-- 숨겨진 필드로 JS에서 사용자 정보 사용 -->
    <input type="hidden" id="userId" value="${loginUserId}" />
    <input type="hidden" id="id" value="${id}" />
    <input type="hidden" id="partnerNickname" value="${partnerNickname}" />
    <input type="hidden" id="chatRoomId" value="${chatRoomId}" />

    <!-- 채팅 메시지 영역 -->
    <div id="chatBox" class="chat-container">
        <c:forEach var="msg" items="${chatHistory}">
            <c:set var="isMe" value="${msg.sender_id eq loginUserId}" />

            <div class="message ${isMe ? 'me' : 'other'}">
                <c:out value="${msg.message}" />
            </div>
            <div class="time-stamp ${isMe ? 'me' : 'other'}">
    			<fmt:formatDate value="${msg.timestamp}" pattern="a hh:mm"/>
			</div>
        </c:forEach>
    </div>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

    <!-- 메시지 입력 및 전송 -->
    <div class="input-area">
        <input type="text" id="msgInput" placeholder="메시지를 입력하세요" autocomplete="off"
            onkeydown="if(event.key === 'Enter') { sendMessage(); event.preventDefault(); }" />
        <button onclick="sendMessage()">보내기</button>
    </div>

</body>
</html>
