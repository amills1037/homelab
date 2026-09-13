# homelab
Files to bring up and maintain a homelab

## git identity

```console
git config --global user.name "Your name"
git config --global user.email "email@example.com"
```

## Setup git commit signing

```console
git config --global gpg.format ssh
git config --global user.signingkey $HOME/.ssh/id_ed25519.pub
git config --global commit.gpgsign true

mkdir -p ~/.config/git
cat $HOME/.ssh/id_ed25519.pub > $HOME/.config/git/allowed-signers
git config --global gpg.ssh.allowedSignersFile $HOME/.config/git/allowed-signers

git show HEAD --show-signature
```
