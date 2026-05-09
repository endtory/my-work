/**
 * 
 */
let ws;

//update
function connect() {
    const userId = document.getElementById("userId").value;
    const sellerId = document.getElementById("id").value;
    const chatRoomId = document.getElementById("chatRoomId").value;
    
    window.open(
        `chat.do?id=${encodeURIComponent(sellerId)}`,  // sellerId 변수 값으로 전달
        'chatPopup',
        'width=600,height=700,scrollbars=yes,resizable=yes'
    );

    ws = new WebSocket("ws://" + location.host + contextPath + 
        `/chat-socket?userId=${encodeURIComponent(userId)}&targetId=${encodeURIComponent(sellerId)}&chatRoomId=${encodeURIComponent(chatRoomId)}`);

    ws.onmessage = function(event) {
        const raw = event.data;
        if (raw.startsWith("ME:")) {
            appendMessage(raw.substring(3), "me");
        } else if (raw.startsWith("OTHER:")) {
            appendMessage(raw.substring(6), "other");
        }
    };
}

function sendMessage() {
    const msgInput = document.getElementById("msgInput");
    const msg = msgInput.value.trim();
    if (!msg) return;
    
    const targetId = document.getElementById("id").value;
    ws.send(targetId + ":" + msg);
    msgInput.value = "";
}
// --------------------------------------------------------------

let lastMessageTime = null;
let lastMessageSender = null;

function formatToHourMinute(date) {
  return date.getHours().toString().padStart(2, '0') + ":" + date.getMinutes().toString().padStart(2, '0');
}

function appendMessage(msg, sender) {
  const chatBox = document.getElementById("chatBox");
  const now = new Date();
  const nowHM = formatToHourMinute(now);

  // 메시지 div 생성 및 추가
  const messageDiv = document.createElement("div");
  messageDiv.className = "message " + (sender === "me" ? "me" : "other");
  messageDiv.textContent = msg;
  chatBox.appendChild(messageDiv);

  // 시간 표시 여부 결정
  let showTime = false;

  if (!lastMessageTime || !lastMessageSender) {
    showTime = true; // 첫 메시지
  } else {
    const lastHM = formatToHourMinute(lastMessageTime);

    if (nowHM !== lastHM || sender !== lastMessageSender) {
      showTime = true; // 시:분 다르거나 보낸사람 바뀌면 표시
    }
  }

  // 기존 모든 시간 표시 삭제
  const timeStamps = chatBox.querySelectorAll(".time-stamp");
  timeStamps.forEach(el => el.remove());

  if (showTime) {
    const timeDiv = document.createElement("div");
    timeDiv.className = "time-stamp";
    timeDiv.textContent = nowHM;
    chatBox.appendChild(timeDiv);
  }

  lastMessageTime = now;
  lastMessageSender = sender;

  // 스크롤 아래로
  chatBox.scrollTop = chatBox.scrollHeight;
}

window.onload = connect;