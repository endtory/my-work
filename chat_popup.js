/**
 * 
 */
document.addEventListener("DOMContentLoaded", function () {
    // 채팅 리스트용 (a 태그 기반)
    document.querySelectorAll('.chat-item').forEach(item => {
        item.addEventListener('click', function (event) {
            event.preventDefault();
            const url = this.href;
            window.open(url, 'chatPopup', 'width=600,height=700,scrollbars=yes,resizable=yes');
        });
    });

    // 상세보기 페이지용 (button 클릭 + input hidden 기반)
    const chatButton = document.getElementById("chatButton");
    const userIdInput = document.getElementById("userId");
    const chatRoomIdInput = document.getElementById("chatRoomId");

    if (chatButton && userIdInput && chatRoomIdInput && typeof contextPath !== 'undefined') {
        chatButton.addEventListener("click", function () {
            const userId = userIdInput.value;
            const chatRoomId = chatRoomIdInput.value || "";

            const url = `${contextPath}/chat.do?id=${encodeURIComponent(userId)}&chatRoomId=${encodeURIComponent(chatRoomId)}`;
            console.log(url);
            window.open(url, 'chatPopup', 'width=600,height=700,scrollbars=yes,resizable=yes');
        });
    }
});
