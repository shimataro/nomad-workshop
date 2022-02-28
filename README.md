# nomad-workshop

## 始める前に

* このリポジトリーを各自のアカウント上にフォークしてください
* 移行の手順で出てくるユーザー名 `shimataro` は、各自のユーザー名に置き換えてください

## 前提

* サーバーOS: Ubuntu Server 20.04
* IPアドレス: `192.168.56.101`
* ユーザー名: `ubuntu` （ `sudo` 権限あり）

VirtualBoxで仮想マシンを作成するとやり直しができて簡単です。

## 手順

### 準備

1. [GitHub Container Registryの利用準備](0-1-prepare-ghcr.md)
1. [Dockerイメージの作成](0-2-create-docker-image.md)

### とりあえず雰囲気を掴んでみる

1. [Nomadセットアップ](1-1-setup-nomad.md)
1. [Nomadセットアップ](1-2-nomad-job.md)
1. [Consul Templateでリバースプロキシー](1-3-consul-template.md)
1. [新バージョンのデプロイ](1-4-update-image.md)
