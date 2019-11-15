CloudTrail 基盤
====================

CloudTrailの証跡保存と可視化

## 概要
CloudTrailの証跡保存オプションを有効化して
S3に証跡ログファイルを保存する。
また、証跡ログを可視化することができます。


## 使い方
### パラメータの設定
terraformの初期化パラメータとして
`backend.tfvars.template` を `backend.tfvars` にリネームし、
tfstateファイルを保存するS3に関するパラメータを反映する。

また、terraform実行時パラメータとして
`variables.auto.tfvars.template` を `variables.auto.tfvars` にリネームし、
パラメータを修正する。
修正する内容は変数定義ファイルの `variables.tf` または
雛形となる `variables.auto.tfvars.template` を参照。

### 実行
`$ make plan` および `$ make apply` コマンドを実行する。
