## 简介
自动部署`jekyll`项目到`GitHub`相同仓库的`master`分支。

### 设置
1. 创建个人访问令牌,单击您的个人资料照片，然后单击`Settings`->左侧边栏中，单击`Developer settings`->
左侧边栏中，单击`Personal access tokens`->单击`Generate new token`->输入描述，如：jekyll自动部署->
选择令牌过期时间->设置参考的访问权限，建议都勾选上->单击`Generate token`，并且复制生成的`code`。
>[创建个人访问令牌参考资料](https://docs.github.com/cn/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
2. 为仓库设置加密密码，在仓库名称下，单击`Settings`->左侧边栏中，单击 `Secrets`->单击`New repository secret`->输入名称，如：jekyll自动部署，输入上一步拷贝的密码。
>[仓库设置加密密码参考资料](https://docs.github.com/cn/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository)
3. 在项目目录创建一个`.github/workflows`文件夹。
4. 在`workflows`创建一个`main.yml`文件，
内容如下:

```yaml
name: Jekyll Deploy

on:
  push:
    branches:
      - master

jobs:
  build_and_deploy:
    runs-on: ubuntu-latest
    steps:
      - name: GitHub Checkout
        uses: actions/checkout@v1
      - name: Bundler Cache
        uses: actions/cache@v1
        with:
          path: vendor/bundle
          key: ${{ runner.os }}-gems-${{ hashFiles('**/Gemfile.lock') }}
          restore-keys: |
            ${{ runner.os }}-gems-
      - name: Build & Deploy to GitHub Pages
        uses: tangyuewei/jekyll-auto-deploy@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GITHUB_REPOSITORY: ${{ secrets.GITHUB_REPOSITORY }}
          GITHUB_ACTOR: ${{ secrets.GITHUB_ACTOR }}
```
>更多信息请参阅[创建新文件](https://docs.github.com/cn/repositories/working-with-files/managing-files/creating-new-files)

