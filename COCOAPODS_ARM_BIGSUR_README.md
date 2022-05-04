## <a name="install">Install CocoaPods on ARM based Macs</a>

The Mopinion Mobile SDK Framework can be installed by using the popular dependency manager [Cocoapods](https://cocoapods.org).
Early versions of CocoaPods for macOS Big Sur needed some extra set-up to successfully install the SDK on the new ARM based Macs.

### Install CocoaPods native on ARM based Macs

For macOS Monterey 12.1 installation of cocoapods 1.11.2 works out of the box:

```sh
sudo gem install cocoapods
```
If you had applied the below patch on macOS Big Sur 11, remove it before installation.

### Patch to install earlier CocoaPods native on ARM based Macs 

Macs with an ARM processor need a newer Ruby toolchain to use CocoaPods via a network. Not needed for cocoapods 1.11.2 and macOS Monterey, but for macOS Big Sur you can try this procedure.

To prevent ffi errors `LoadError - dlopen(/Library/Ruby/Gems/2.6.0/gems/ffi-1.14.2/lib/ffi_c.bundle, 0x0009)` causing build failures:

1. Install the Xcode 12.5 (or later) *Command Line* tools (even if you already installed the full Xcode IDE version)
2. Install [macports](https://macports.org)
3. In terminal, execute 

```sh
sudo port install ruby27
sudo port select --set ruby ruby27
source .zprofile # or .profile, whereever you defined your $PATH
sudo gem update
sudo gem install ffi
sudo gem install cocoapods
```
Tested to work with M1 on macOS Big Sur 11.4, Xcode 12.5, macports 2.7.1, ruby 2.7.3p183, cocoapods 1.10.1

#### Reported native cocoapods install for homebrew users
For homebrew users the procedure is a bit different, [according to github](https://github.com/CocoaPods/CocoaPods/issues/9907#issuecomment-835385306):

1. Update to at least macOS Big Sur 11.3.1
2. Install homebrew
3. Update ruby to at least 2.7.3

```sh
brew install rbenv
rbenv init
rbenv install 2.7.3
export RBENV_VERSION=2.7.3 # or however you set your ruby version
```
4. Install cocoapods 

```sh
brew install cocoapods
```

