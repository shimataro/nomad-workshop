# GitHub Container Registryの利用準備

## パーソナルアクセストークンの取得

[ここ](https://github.com/settings/tokens)からアクセストークンを作成してください。
スコープには `write:packages` を指定してください。

アクセストークンを `token.txt` というファイル名で保存してください。

## GitHub Container Registryへログイン

以下のコマンドでログインします。

```bash
docker login ghcr.io -u shimataro --password-stdin <token.txt
```

何かメッセージが出て、最後に `Login Succeeded` と表示されればログイン成功です。
