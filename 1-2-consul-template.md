# Consul Templateでリバースプロキシー

## Consul Templateを登録

Nginxにリバースプロキシーの設定を入れます。
upstreamはテストサーバーのコンテナですが、コンテナのIPアドレスやポートは動的に変わるので、Consul Templateを使います。

これもフォアグラウンドで起動するので、これ以降の操作は別端末で。

```bash
# Nginxをリロードする必要があるのでroot権限で実行
# （Ubuntuではサイトごとの設定は `/etc/nginx/sites-enabled` あたりに入れるのが流儀だけど・・・）
sudo consul-template -template "consul-template/testserver.conf.ctmpl:/etc/nginx/conf.d/testserver.conf:service nginx reload"
```

設定内容を確認

```bash
$ cat /etc/nginx/conf.d/testserver.conf
upstream testserver {

    server 127.0.0.1:29435;

    server 127.0.0.1:23247;

}

server {
    listen 8080;
    server_name localhost;
    location / {
        proxy_pass http://testserver;
    }
}
```

## 動作確認

8080番ポートにアクセスしたら地獄の言葉が聞こえてくるはず。。。

```bash
$ curl http://192.168.56.101:8080/
Hell Word
```

## ちょっと説明

今回使ったConsul Templateのupstream動的変更部分はこんな感じです。

```nginx
upstream testserver {
{{ range service "testserver" }}
    server {{ .Address }}:{{ .Port }};
{{ end }}
}
```

2行目では「"testserver"という名前のサービス」を指定していますが、ここの名前は [`nomad/testserver.nomad`](./nomad/testserver.nomad)の "service" Stanzaに登録している名前を使います。

```
    service {
      name = "testserver"  # ←これ
      tags = ["global"]
      port = "web"

      check {
        name     = "alive"
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }
```
