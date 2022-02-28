# Nomadにジョブを登録

## 準備

[`nomad/testserver.nomad`](./nomad/testserver.nomad)の以下の行をそれぞれGitHubのユーザー名とパーソナルアクセストークンで置き換える

```nomad
        auth {
          username = "<GitHub username>"
          password = "<personal access token>"
        }
```

## ジョブを登録＆起動

```bash
cd nomad
nomad job run testserver.nomad
```

テスト用ウェブサーバーのコンテナが2つ作成される

## ジョブに関するコマンドいろいろ

```bash
nomad job stop -purge <job>
```
