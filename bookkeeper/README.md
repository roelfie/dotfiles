[◄ dotfiles](../README.md)

# Bookkeeper

Bookkeeper is a [script](./bookkeeper.zsh) that:

* Keeps the system up-to-date (upgrade outdated brew, python & NPM packages)
* Keeps the .dotfiles project up-to-date (backup lists of (un)installed brew, python & NPM packages)
* Commits & pushes simple changes to the .dotfiles project automatically
* Notifies the user of uncommitted changes to the .dotfiles project

_NB: bookkeeper automatically upgrades your macOS applications, but only if they were installed as a `cask`. Applications installed from the App Store (`mas`) can not be automatically upgraded with Homebrew (but most applications can be configured to auto-upgrade themselves)._


## Background job

If you schedule the bookkeeper as a periodic background job, you don't have to worry about keeping
your system & your .dotfiles project up-to-date. Bookkeeper will do it for you and notify you 
when you need to take action.

The recommended way of scheduling a job on macOS is using [launchd](https://en.wikipedia.org/wiki/Launchd).


## Configuring bookkeeper in LaunchControl

I use [LaunchControl](https://www.soma-zone.com/LaunchControl) to configure the bookkeeper job and load it into launchd:

* Select `User Agents`
* Create a new User Agent (`+` button)
* Configure the `bookkeeper` job and click on the `load` button:

![User Agent configuration](images/LaunchControl-UserAgent.png)

The job is now loaded into launchd and will run every X hours. 
Missed job invocations (when the computer is asleep) will be started the next time the computer wakes up. 
Multiple missed events will be coalesced into one.

## Configuring bookkeeper in QuickLaunch

QuickLaunch is a menu bar app that comes with LaunchControl.

* Open LaunchControl Preferences
* Go to 'Utilities' and check 'Enable QuickLaunch'

The QuickLaunch icon (joystick) will appear in the menu bar

* Open QuickLaunch Preferences
* Add the bookkeeper job

You can now access the bookkeeper job from the menu bar:

![QuickLaunch start](images/QuickLaunch-Start.png)

For instance to run it 'on demand' or unload it from launchd.