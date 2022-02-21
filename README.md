# nomad-workshop

## Dockerイメージの作成

テスト用に簡単なウェブサーバーを作成

```bash
cd docker
docker build -t testserver:1 .
```

念のため動作確認

```bash
docker run -p 3000:3000 --name=testcontainer testserver:1

# 別の端末からアクセス→地獄の言葉が聞こえたら成功
curl http://localhost:3000

# 確認できたら後片付け
docker stop testcontainer
docker rm testcontainer
```
