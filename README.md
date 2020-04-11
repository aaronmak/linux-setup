# Linux Setup

Steps to setup my remote development machine.

## Setting up a remote instance

Used DigitalOcean's droplet because it's the easiest to setup.

1. Create an Ubuntu instance
1. Add the necessary public ssh keys during setup and
   allow access only with ssh keys
1. Copy the public IP

## Creating a new non-root user

SSH into the machine

```bash
ssh root@<IP_ADDRESS>
```

Create a non root user, copy ssh keys over
and give permissions

```bash
adduser aaronmak
mkdir /home/aaronmak/.ssh && cat ~/.ssh/authorized_keys >> /home/aaronmak/.ssh/authorized_keys
chown -R aaronmak:aaronmak /home/aaronmak/.ssh
```

Check that password authentication is disabled

```bash
vim /etc/ssh/sshd_config
```

Add non root user to sudoers file

```bash
vim /etc/sudoers
```

`/etc/sudoers` should look something like this.

```
root   ALL(ALL:ALL) ALL
aaronmak  ALL(ALL:ALL) ALL
```

Finally, log out and login with the non root user. `ssh aaronmak@<IP_ADDRESS>`

## Install git to pull setup scripts and dotfiles

```bash
sudo apt-get install -y git
git clone https://github.com/aaronmak/linux-setup.git
./setup.sh
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
