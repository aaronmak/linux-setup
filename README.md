# Linux Setup

Steps to setup my remote development machine.

## Setting up a remote instance

1. Create an Ubuntu instance
1. Add the necessary public ssh keys during setup and
   allow access only with ssh keys
1. Copy the public IP

## Creating a new non-root user

SSH into the machine

```bash
ssh root@<IP_ADDRESS>
```

Create a non root user

```bash
adduser aaronmak
```

Add non root user to sudoers file

```bash
sudo vim /etc/sudoers
```

`/etc/sudoers` should look something like this.

```
root   ALL(ALL:ALL) ALL
aaronmak  ALL(ALL:ALL) ALL
```

Go back to your local machine and copy the public key over

```bash
ssh-copy-id aaronmak@<IP_ADDRESS>
```


Log in using the non root user and disable password
authentication and root login.

```bash
sudo vim /etc/ssh/sshd_config
```

You should end up with something like

```
PermitRootLogin no
PasswordAuthentication no
```

Finally, log out and login with the non root user. `ssh aaronmak@<IP_ADDRESS>`

## Install git to pull setup scripts and dotfiles

```bash
sudo apt-get install -y git
git clone https://github.com/aaronmak/linux-setup.git
./linux-setup/setup.sh
```

## Create a public ssh key and add it to Github

```bash
ssh-keygen -t rsa -b 4096 -C "aaronmakks@gmail.com"
```

```bash
cat ~/.ssh/id_rsa.pub
```

Go to github.com > personal settings > SSH and GPG keys.
Add the public key to Github.

If that doesn't work, refer to
[Github Docs](https://help.github.com/en/articles/connecting-to-github-with-ssh).
