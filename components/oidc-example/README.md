OIDC example
====================

AWSとGitHub ActionsおよびTerraform CloudをOIDCで接続したときの利用方法サンプル。


## GitHub Actions

### IAMロールの作成
GitHub ActionsからOIDCで接続して利用するIAMロールを作成する。
詳細は [oidc](../oidc) を参照。

### GitHub Actions への登録
作成したIAMロールARNをGitHub Actionsに登録する。
secretsまたはvariableのどちらでもよい(AWSアカウントIDも表示されるのでsecretsの方がよい？)。

### GitHub Actionsでの利用
[aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials#assuming-a-role)に記載の通り、 `role-to-assume` に利用するIAMロールを指定して利用する。


```yaml
- name: configure aws credentials
  uses: aws-actions/configure-aws-credentials@v2
  with:
    role-to-assume: ${{ vars.AWS_DEPLOY_ROLE }}
    aws-region: "ap-northeast-1"
```
