Terraform Cloud リソースインポート検証
========================================

Terraform Cloudでリソースインポート操作に関する検証を行う。

## エラー再現
1. リソースを構築(terraform apply)する
2. リソースをstateファイルから削除する
3. Terraformをリモート実行モードに切り替える
4. Terraform Cloud上で未定義の変数(例: `undefined_variable = "test"`)を設定する
5. Terraformをローカル実行モードに切り替える
6. 2で削除したリソースをインポートする

以上の手順で実行したとき、リソースが正常通りインポートされることを期待するが、
実際には以下の通りエラーになる。

```
$ terraform import aws_s3_bucket.sample sample-import-tf
Acquiring state lock. This may take a few moments...
╷
│ Error: Value for undeclared variable
│ 
│ A variable named "undefined_variable" was assigned a value, but the root module does not declare a variable of that name. To use this value, add a "variable" block to
│ the configuration.
╵
```
