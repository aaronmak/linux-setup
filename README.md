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


## Create a gpg subkey from the master key


Import the master key from the thumbdrive

```
gpg --import <MASTER_KEY>
```

Generate new subkey

```
gpg --edit-key <MASTER_KEY>

...

gpg> addkey

...

Please select what kind of key you want:
   (3) DSA (sign only)
   (4) RSA (sign only)
   (5) Elgamal (encrypt only)
   (6) RSA (encrypt only)
Your selection? 4
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 4096
Requested keysize is 4096 bits

...

gpg> save
```

Export the subkey

```
gpg --export-secret-keys --armor <SUBKEY> > <SUBKEY>-private.gpg
```

Go into the remote machine and import the subkey

```
ssh aaronmak@<IP_ADDRESS>
touch <RANDOM_FILENAME>
vim <RANDOM_FILENAME> # write secret key to file
gpg --import <RANDOM_FILENAME>
shred --remove <RANDOM_FILENAME>
```

Remove generated subkey and masterkey from local computer

```
gpg --delete-secret-keys <SUBKEY>
gpg --delete-secret-keys <MASTER_KEY>
```
