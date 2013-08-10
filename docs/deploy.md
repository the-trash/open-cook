### Deploy

### SSH without password

Local machine:

```
ssh-keygen -t rsa -C "zykin-ilya@ya.ru"
```

```
Enter file in which to save the key (/home/USER/.ssh/id_rsa): zykin_ilya

Enter passphrase (empty for no passphrase): ENTER
```

```
scp ~/.ssh/zykin_ilya.pub open_cook_web@185.4.85.70:~/zykin_ilya.pub
```

```
ssh open_cook_web@185.4.85.70
mkdir -p ~/.ssh && cat ~/zykin_ilya.pub >> ~/.ssh/authorized_keys && rm ~/zykin_ilya.pub
chmod 711 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
```