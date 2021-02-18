# LCTECH-STARTER

lctech - 安裝環境懶人包

## req

### mail@lctech.com.tw

## Mac host

Support:

+ MAC tool
  + homebrew
  + homebrew - cask
  + mas
+ browser
  + google chrome
  + google chrome - gRPC-Web Developer Tools
+ team plan & message tool  
  + slack
  + notion
  + line
  + vpn - outline
+ dev tool
  + docker
  + zeplin
  + gcp cloud sdk
  + vs code
  + tableplus
  + auto set config
  + HTTPBOT
  + XCODE 相關
+ config github
  + set github .netrc
  + set npm .npmrc
  + set host

## Docker workspace

+ back-end utll
  + database
    + postgresql@11  
+ front-end util
  + node 10/12
  + mvm

## TODO

mas need account

---

+ [ ]  docker workspace
+ [ ]  其他＆意外問題
  + [ ]  Apply for apple account
    + install mac App store need apple account
    + Xcode / HTTPBot / LINE / Trello
    + logout
  + [ ] mis  Account 自動化？
    + lctech mail
    + apple
    + github
  + [x]  VPN

## Install & Use

```sh
bash main.sh
```

## docker

``` sh
docker run -itd -v /Users/lctech-zeki/Documents/GitHub/lctech-starter/docker_root:/mac --name wksp wksp
docker exec -it wksp bash 
```
