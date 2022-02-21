# 新バージョンのデプロイ

ウェブサーバーの新バージョンをデプロイする方法の解説です。

## Dockerイメージを更新

ウェブサーバーに何か適当に変更を加えてみます。

```javascript
require('http')
  .createServer((req, res) => {
    res.writeHead(200, {
      "Content-Type": "text/plain",
    });

    // 地獄の言葉
    res.end("Hell Word v2\n"); // ←v2にしてみる
  })
  .listen(3000);
```

[Dockerイメージの作成](2-create-docker-image.md)と同様に、新しいイメージを作成します。
バージョンは2.0とします。

```bash
cd docker

# "2.0" と "latest" の2つのタグをつける
docker build -t ghcr.io/shimataro/nomad-workshop/testserver:2.0 -t ghcr.io/shimataro/nomad-workshop/testserver:latest .

# GitHub Container Registryにpush
docker push ghcr.io/shimataro/nomad-workshop/testserver:2.0
docker push ghcr.io/shimataro/nomad-workshop/testserver:latest
```

## ジョブの更新

ウェブサーバーを新しいイメージに差し替えます。
[Nomadにジョブを登録](3-nomad-job.md)と同様に、ジョブを登録するだけです。

```bash
cd nomad
nomad job run testserver.nomad
```

## 動作確認

Consul Templateが動いているのでNginx設定ファイルのupstreamが更新されているはずです。

```bash
$ cat /etc/nginx/conf.d/testserver.conf
upstream testserver {

    server 127.0.0.1:21076;

    server 127.0.0.1:31893;

}

server {
    listen 8080;
    server_name localhost;
    location / {
        proxy_pass http://testserver;
    }
}
```

地獄の言葉も新しくなっているはず。

```bash
$ curl http://192.168.56.101:8080/
Hell Word v2
```
