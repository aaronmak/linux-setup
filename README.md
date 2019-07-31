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
adduser aaron
mkdir /home/aaron/.ssh && cat ~/.ssh/authorized_keys >> /home/aaron/.ssh/authorized_keys
chown -R aaron:aaron /home/aaron/.ssh
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
aaron  ALL(ALL:ALL) ALL
```

Finally, log out and login with the non root user. `ssh aaron@<IP_ADDRESS>`

## Install git to pull setup scripts and dotfiles

```bash
sudo apt-get install -y git
git clone https://github.com/aaronmak/linux-setup.git
./setup.sh
```


