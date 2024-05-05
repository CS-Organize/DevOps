# Slack Bot

GitHub 리포지토리의 PR(Pull Request)마다 알림을 Slack으로 보내주는 Slack bot을 만드는 과정은 크게 몇 가지 단계로 나눌 수 있습니다. 이 작업을 수행하려면, GitHub의 Webhooks, Slack API, 그리고 중간에 연동을 담당할 서버 또는 서버리스 플랫폼을 사용할 것입니다.

### 1. Slack App 설정하기

1. **Slack App 생성**: Slack API 웹사이트에서 새로운 App을 생성합니다. [Slack API](https://api.slack.com/apps) 페이지에 접속하여 `Create New App`을 선택하고, 앱 이름과 워크스페이스를 설정합니다.
   
2. **Incoming Webhooks 사용 설정**: 앱 설정에서 `Incoming Webhooks`를 찾아 활성화합니다. 이후, 웹훅 URL을 생성하기 위해 `Add New Webhook to Workspace`를 클릭하고, 메시지를 받을 채널을 선택합니다. 생성된 웹훅 URL은 나중에 사용할 예정입니다.

### 2. GitHub 설정하기

1. **리포지토리에 Webhook 추가**: GitHub 리포지토리 설정에서 `Webhooks` 메뉴로 이동하여 `Add webhook`을 클릭합니다.
   
2. **Webhook 설정**: `Payload URL`에는 알림을 받아 Slack으로 전송할 서버의 URL을 입력합니다. `Content type`은 `application/json`으로 설정하고, `Which events would you like to trigger this webhook?`에서 `Let me select individual events.`를 선택, `Pull requests`를 체크합니다. 마지막으로 `Add webhook` 버튼을 클릭하여 설정을 완료합니다.

### 3. 서버 또는 서버리스 함수 설정하기

1. **서버 설정**: Node.js를 예로 들면, `Express`와 같은 웹 프레임워크를 사용하여 GitHub의 Webhook 요청을 받을 수 있는 서버를 설정할 수 있습니다. 이 서버는 GitHub로부터 PR 이벤트를 받아 Slack의 Incoming Webhook URL로 메시지를 전송하는 역할을 합니다.

2. **서버리스 함수 사용**: AWS Lambda, Google Cloud Functions, Vercel, Netlify Functions 등의 서버리스 플랫폼을 사용하면 서버 관리 없이 이 기능을 구현할 수 있습니다. 이 경우, 해당 플랫폼의 API 게이트웨이를 통해 GitHub Webhook 요청을 받고, Slack으로 알림을 전송하는 함수를 작성합니다.

### 예제 코드 (Node.js + Express)

아래는 Node.js와 Express를 사용하여 GitHub의 PR 이벤트를 받아 Slack으로 알림을 보내는 간단한 예제입니다.

```javascript
const express = require('express');
const axios = require('axios');
const app = express();
app.use(express.json());

app.post('/github-webhook', async (req, res) => {
  const {pull_request, action} = req.body;
  const message = {
    text: `Pull Request #${pull_request.number} is ${action}. Title: ${pull_request.title}`,
  };

  await axios.post('YOUR_SLACK_WEBHOOK_URL', message);

  res.status(200).send('OK');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
```

이 예제에서는 PR이 생성되거나 업데이트될 때 해당 정보를 Slack 메시지로 전송합니다. 여기서 `'YOUR_SLACK_WEBHOOK_URL'`은 Slack에서 생성한 Incoming Webhook URL로 대체해야 합니다.

### 마무리 단계

- 서버 또는 서버리스 함수가 준비되면, GitHub Webhook의 Payload URL을 해당 서버의 주소로 설정합니다.
- Slack과 GitHub 설정을 확인하고, PR 이벤트가 Slack 채널로 올바르게 전송되는지 테스트합니다.

이러한 단계를

 통해 GitHub 리포지토리의 PR 알림을 Slack으로 전송하는 Slack bot을 만들 수 있습니다. 필요에 따라 메시지 포맷이나 이벤트 종류를 조정하여 원하는 방식으로 알림을 설정하세요.
