# Azure-Image-Builder-Japanese-Image
## 目的
このリポジトリでは Azure Image Builder を利用した日本語化イメージの構築に必要な要素をまとめています。

## 作成可能イメージ
- Windows 10 Enterprise 2004
- WIndows 10 Enterprise for Virtual Desktop 2004
- WIndows Server 2019

## 事前準備
### 機能の追加
Azure Image Builder を利用可能できるようにリソースプロバイダーへ機能を追加します。この操作はサブスクリプションごとに1回実行する必要があります。

```
# Azure へ接続
Connect-AzAccount

# Azure サブスクリプションの選択
## サブスクリプション一覧の取得
Get-AzSubscription
## 操作対象のサブスクリプション切り替え
#Select-AzSubscription -SubscriptionId <Subscription_Id>

# Azure Image Builder の機能追加
## 機能の追加
Register-AzProviderFeature -FeatureName VirtualMachineTemplatePreview -ProviderNamespace Microsoft.VirtualMachineImages

## 追加の確認
Get-AzProviderFeature -FeatureName VirtualMachineTemplatePreview -ProviderNamespace Microsoft.VirtualMachineImages
```

## 免責事項
本リポジトリの内容は個人での制作物のため、Microsoft や所属組織は一切関係のないものです。また、本リポジトリの内容を用いて起きた事故や不具合に関して一切責任を持つことはしません。
