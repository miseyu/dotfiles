Brewfileがオワコンになってしまったので、
brewのスクリプトを晒します。

```
# Make sure using latest Homebrew
update || true
 
# Update already-installed formula
upgrade || true
 
 
# Packages
 
## Shell
brew install zsh   || true
brew install zsh-completions || true
brew install mobile-shell || true
 
## Git
brew install git   || true
brew install tig   || true
 
## Utils
brew install wget      || true
brew install curl      || true
brew install tmux      || true
brew install autoconf  || true
brew install openssl   || true
brew install readline  || true
brew install libyaml   || true
brew install rmtrash   || true
brew install font-forge || true
brew install gcc || true
brew install ricty || true
brew install tags || true
brew install make || true
 
## Database
brew install mysql     || true
brew install redis || true
brew install memcached || true
 
## Languages
brew install rbenv            || true
brew install ruby-build       || true
brew install go               || true
 
## DevOps
brew install docker      || true
brew install boot2docker || true
brew install packer      || true
 
## Image
brew install imagemagick || true
 
# Casks

brew install caskroom/cask/brew-cask
brew cask install google-chrome || true
brew cask install iterm2        || true
brew cask install dropbox       || true
brew cask install alfred        || true
brew cask install kobito        || true
brew cask install atom  || true
brew cask install virtualbox
brew cask install vagrant
brew cask install caffeine
brew cask install xtrafinder
brew cask install omnifocus
brew cask install pckeyboardhack
brew cask install Karabiner
brew cask install skitch
brew cask install sequel-pro
brew cask install totals

# Remove outdated versions
cleanup
```
