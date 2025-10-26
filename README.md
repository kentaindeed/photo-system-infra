# S3 + CloudFront Terraform Infrastructure

このプロジェクトは、AWS S3とCloudFrontを使用した静的ウェブサイトホスティング環境をTerraformで構築します。

## 🏗️ アーキテクチャ

- **S3バケット**: 静的ファイルの保存
- **CloudFront**: CDNによる高速配信
- **OAC (Origin Access Control)**: S3への直接アクセスを制限
- **バケットポリシー**: CloudFrontからのみアクセス許可

## 📁 プロジェクト構造

```
├── env/
│   └── prod/                    # 本番環境設定
│       ├── main.tf             # メインの設定ファイル
│       ├── variable.tf         # 変数定義
│       ├── terraform.tfvars    # 変数値
│       ├── output.tf           # 出力値
│       └── backend.tf          # 状態管理設定
├── modules/
│   ├── s3/                     # S3モジュール
│   │   ├── main.tf
│   │   ├── variable.tf
│   │   └── output.tf
│   ├── cloudfront/             # CloudFrontモジュール
│   │   ├── main.tf
│   │   ├── variable.tf
│   │   └── output.tf
│   ├── backend/                # 状態管理用S3モジュール
│   ├── acm/                    # SSL証明書モジュール
│   └── functions/              # Lambda関数モジュール
└── README.md
```

## 🚀 デプロイ手順

### 前提条件

- AWS CLI設定済み
- Terraform v1.0以上
- 適切なAWS権限

### 1. 初期設定

```bash
# リポジトリをクローン
git clone <repository-url>
cd s3-cloudfront-terraform

# 作業ディレクトリに移動
cd env/prod
```

### 2. 変数設定

`terraform.tfvars`を確認・編集：

```hcl
env = "prod"
aws_region = "ap-northeast-1"
```

### 3. Terraformの実行

```bash
# 初期化
terraform init

# プランの確認
terraform plan

# デプロイ実行
terraform apply
```

## 📋 リソース詳細

### S3バケット

- **バケット名**: `{env}-photo-system-bucket`
- **暗号化**: AES256
- **バージョニング**: 無効
- **パブリックアクセス**: ブロック

### CloudFront

- **キャッシュポリシー**: CachingOptimized
- **オリジンリクエストポリシー**: CORS-S3Origin
- **レスポンスヘッダーポリシー**: SimpleCORS
- **プロトコル**: HTTPS強制

### セキュリティ

- OAC (Origin Access Control) でS3への直接アクセスを制限
- CloudFrontからのみS3にアクセス可能
- 全てのHTTPリクエストをHTTPSにリダイレクト

## 🔧 カスタマイズ

### 環境変数

主要な設定は`env/prod/variable.tf`で管理：

- `aws_region`: AWSリージョン
- `aws_profile`: AWSプロファイル
- `env`: 環境名

### モジュール設定

各モジュールは独立して設定可能：

- **S3モジュール**: バケット設定、暗号化、ポリシー
- **CloudFrontモジュール**: 配信設定、キャッシュポリシー
- **ACMモジュール**: SSL証明書管理

## 📤 出力値

デプロイ後に以下の情報が出力されます：

- S3バケット名とARN
- CloudFrontディストリビューションのドメイン名とARN
- その他のリソース情報

## 🔄 状態管理

Terraformの状態ファイルはS3バケットで管理：

- **バケット**: `prod-tfstate-photo-system-bucket`
- **キー**: `prod/terraform.tfstate`
- **暗号化**: 有効

## 🛠️ トラブルシューティング

### よくある問題

1. **循環依存エラー**
   - モジュール間の依存関係を確認
   - 必要に応じて段階的デプロイを実行

2. **S3バケット名の重複**
   - バケット名はグローバルでユニークである必要があります
   - `env`変数を変更してバケット名を調整

3. **権限エラー**
   - AWS CLIの設定を確認
   - 必要なIAM権限があることを確認

### ログの確認

```bash
# Terraformのデバッグログ
export TF_LOG=DEBUG
terraform apply

# AWSリソースの確認
aws s3 ls
aws cloudfront list-distributions
```

## 📝 ライセンス

このプロジェクトはMITライセンスの下で公開されています。

## 👥 貢献

プルリクエストや課題報告を歓迎します。

## module 

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution

---

**作成者**: kentaindeed  
**プロジェクト**: photo-system  
**作成日**: 2025-01-01