# sample-terraform-cloud
sample code for terraform cloud for AWS


## Steps
* create organization
* create workspace
  * workspace は複数の小さな設定に分割した方がよい: [Planning and Organizing Workspaces ](https://www.terraform.io/docs/cloud/workspaces/index.html#planning-and-organizing-workspaces)
  * workspace 名は `<COMPONENT>-<ENVIRONMENT>-<REGION>` を推奨，必要に応じて追加で workspace の特徴(クラウドなど)を名前に追加する
* manage access

## workspace のカスタマイズ
workspace の General Settings から変更可能

* Execution Mode: どこで terraform を実行して設定を管理するか
  * Remote: planファイルはTerraform Cloud上で管理する
  * Local: planファイルはローカルに持ち，Terraform Cloudは同一ファイルを格納するのみ
* Apply Method
  * Auto apply: planの作成に成功したら自動的にapplyする．VCSと連携している場合はplanのみ実行しapplyは確認待ちになる
  * Manual apply: planの作成に成功した後に承認を待ってapplyする．VCSと連携している場合はplanのみ実行しapplyは確認待ちになる
* Terraform Version: 利用する terraform バージョン. latestを選択した場合のみ自動的に最新のバージョンを利用する
* Terraform Working Directory: terraformコマンドを実行するサブディレクトリ

## Users, Teams, Organizations
* user

* team
  * owner: 各organizationに1つある特権を持つチーム．全workspaceに対するフル権限とteamの操作権限等を持つ
  * その他
* アクセス権限
  * user role
    * organization owner
    * workspace admin
    * 
  * team role
    * admin
    * write
    * read
