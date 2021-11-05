# 通过 alias 给命令起别名

**方法一**  

```bash
vim ~/.bashrc
alias relay="bash ~/relay.sh"
source ~/.bashrc
```

**方法二**  

如果终端安装了 ZSH，上面的步骤不一定生效，这是因为 ZSH 默认执行文件是 ~/.zshrc。  

```bash
vim ~/.zshrc
alias relay="bash ~/relay.sh"
source ~/.zshrc
```

mycli

```bash
alias mysqlconnect="mycli -hlocalhost -uroot"
```
