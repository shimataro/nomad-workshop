# Nomadセットアップ

## パッケージのインストール

```bash
# HashiCorpの公式リポジトリーを追加
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update

# Nomad / Consul / Consul Templateをインストール
sudo apt install nomad consul consul-template

# 補完を有効化
nomad -autocomplete-install
consul -autocomplete-install
```

```bash
# 追加で今回のワークショップに必要なパッケージを入れる
sudo apt install nginx docker.io
```

## 設定

```bash
# グループ設定
sudo gpasswd -a nomad docker
sudo gpasswd -a ubuntu docker
sudo gpasswd -a ubuntu nomad
sudo gpasswd -a ubuntu consul
```

ここまで終わったら一旦リブートしてください。

## Nomad, Consulを起動

とりあえず開発モード（同一ホストでサーバーとクライアントを実行）で起動します。

いずれもフォアグランドで実行されるので、他の作業は別端末で行ってください。

### Nomad起動

```bash
sudo -u nomad nomad agent -dev -bind=0.0.0.0
```

Nomad起動後に<http://192.168.56.101:4646>にアクセスすると、NomadのWebUIが表示されます。

### Consul起動

```bash
sudo -u consul consul agent -dev
```
