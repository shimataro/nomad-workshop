# nomad-workshop

## 前提

* このリポジトリーを各自のアカウント上にフォークしてください
* 移行の手順で出てくるユーザー名 `shimataro` は、各自のユーザー名に置き換えてください

## GitHub Container Registryの利用準備

### パーソナルアクセストークンの取得

[ここ](https://github.com/settings/tokens)からアクセストークンを作成してください。
スコープには `write:packages` を指定してください。

アクセストークンを `token.txt` というファイル名で保存してください。

### GitHub Container Registryへログイン

以下のコマンドでログインします。

```bash
docker login ghcr.io -u shimataro --password-stdin <token.txt
```

何かメッセージが出て、最後に `Login Succeeded` と表示されればログイン成功です。

## Dockerイメージの作成

テスト用の簡単なウェブサーバーを `docker` ディレクトリーにしているので、これを使ってイメージを作成します。

```bash
cd docker

# "1.0" と "latest" の2つのタグをつける
docker build -t ghcr.io/shimataro/nomad-workshop/testserver:1.0 -t ghcr.io/shimataro/nomad-workshop/testserver:latest .
```

念のため動作確認・・・

```bash
docker run -p 3000:3000 --name=testcontainer ghcr.io/shimataro/nomad-workshop/testserver:1.0

# 別の端末からアクセス→地獄の言葉が聞こえたら成功
curl http://localhost:3000

# 確認できたら後片付け
docker stop testcontainer
docker rm testcontainer
```

作ったイメージをGitHub Container Registryにpushします。

```bash
docker push ghcr.io/shimataro/nomad-workshop/testserver:1.0
docker push ghcr.io/shimataro/nomad-workshop/testserver:latest
```

作成したイメージは<https://ghcr.io/shimataro/nomad-workshop/testserver>から参照・削除できます。
