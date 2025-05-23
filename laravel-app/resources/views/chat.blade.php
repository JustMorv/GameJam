<!DOCTYPE html>
<html>
<head>
    <title>Консультант для абитуриентов</title>
    <style>
        body { font-family: Arial; max-width: 600px; margin: 0 auto; padding: 20px; }
        #chat { border: 1px solid #ddd; height: 400px; overflow-y: scroll; padding: 10px; margin-bottom: 10px; }
        input { width: 80%; padding: 8px; }
        button { padding: 8px 15px; }
    </style>
</head>
<body>
<h1>Консультант для абитуриентов</h1>
<div id="chat"></div>
<input type="text" id="message" placeholder="Ваш вопрос...">
<button onclick="sendMessage()">Отправить</button>

<script>
    function addMessage(text, isUser = false) {
        const chat = document.getElementById('chat');
        const msg = document.createElement('div');
        msg.style.margin = '5px';
        msg.style.padding = '8px';
        msg.style.borderRadius = '5px';
        msg.style.backgroundColor = isUser ? '#e3f2fd' : '#f5f5f5';
        msg.textContent = text;
        chat.appendChild(msg);
        chat.scrollTop = chat.scrollHeight;
    }

    function sendMessage() {
        const input = document.getElementById('message');
        const message = input.value.trim();

        if (message) {
            addMessage(message, true);
            input.value = '';

            fetch('/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': '{{ csrf_token() }}' },
                body: JSON.stringify({ message: message })
            })
                .then(response => response.json())
                .then(data => addMessage(data.response))
                .catch(error => addMessage('Ошибка соединения с сервером'));
        }
    }

    // Отправка по Enter
    document.getElementById('message').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') sendMessage();
    });

    // Приветственное сообщение
    addMessage("Здравствуйте! Я помогу с поступлением. Вы можете спросить:\n• Какие экзамены нужны на ФИЦТ?\n• Какие документы подавать?\n• Какие проходные баллы?\n• Сроки подачи документов\n• Про общежитие");</script>
</body>
</html>
