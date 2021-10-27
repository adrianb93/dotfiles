# Before nuking the previous machine

- Check before burning the hard drive for unsynced content, including:
    - Home directory files
    - Unpushed changes / branches / repos
    - Any files or photos

# Setting up the new machine

1. Apple:
   - Sign into iCloud
   - Swap Music and App Store account to other Apple ID
2. Setup Xcode:
   - [Install](https://apps.apple.com/au/app/xcode/id497799835?mt=12)
   - Open Xcode
   - Run `xcode-select --install`
3. Install and setup 1Password
4. Run the installation script...
```sh
mkdir $HOME/Code && cd $HOME/Code
git clone https://github.com/adrianb93/dotfiles.git && cd dotfiles
bash install
compaudit | xargs chmod g-w
```
5. Drop SSH keys into ~/.ssh
6. Add SSH key to agent
```
ssh-add -K ~/.ssh/id_ed25519
```
7. Install browser plugins:
   - [1Password](https://1password.com/browsers/firefox/)
   - [Vue.js devtools](https://addons.mozilla.org/en-US/firefox/addon/vue-js-devtools/)

# Updating

Re-run the installation script
