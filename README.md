# MrJK custom oh-my-bash

This is a custom oh-my-bash installation. It provides a generic way
to load and configure oh-my-bash. This project is not meant to b forked since
it should provide a generic configuration layer to extend oh-my-bash features way belong it was initially designed for.

Features:
- Auto-installer: Install this project, and original oh-my-bash if not already present. Auto-patch .bashrc by including only a minimalistic shim.
- Configuration is moved in `~/.config/oh-my-bash.sh` or  `~/.config/oh-my-bash/config.sh` and plugin logic is moved into `~/.config/oh-my-bash/loader.sh`. Use you personal dotfile to manage them.
- Default sane config: this project should be enough to provide a generic (aka unbranded) environement for all your use cases
- Not intrusive, by default everything lives in `~/.local/share/oh-my-bash`. Support system installation.
- Provide support for inshell applications, such as direnv or mise, but also provide a way to inject new paths to enable other tools.
- Reuse omb base shell hook system and plugins

## Installation

Automatic installation is recommended

### Automated

This will automatically update as well:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/mrjk/omb-custom/main/tools/install.sh)"
```

### Manual

Quick install:
```
git clone https://github.com/mrjk/omb-custom ~/.local/share/oh-my-bash/custom
~/.local/share/oh-my-bash/custom/tools/install.sh
```

## Usage

Cheat sheet:
```
# Change and load new theme
_omb_module_require_theme envy

# Live enable a plugin
_omb_module_require_plugin git debug
_omb_module_require_alias mrjk_user_dev
_omb_module_require_completion "${completions[@]}"

```

Favorite themes:
Optimal:
* slick
* font
* garo
* pete
* pure
* roderik: nice git support
* sexy: a bit long ...
* tonotdo
* mairan (multi-line)
* modern (multi-line)
* nwinkler (multi-line)
* rjorgenson (multi-line)

Cool but slow:
* candy (utf8)
* dulcie (slow)

Acceptable:
* vscode
* binaryanomaly
* moris
* minimal
* rainbowbrite


Too look closer:
* iterate: Path management on change, smart idea for minimal shell
* mairan: lisible
* nwinkler_random_colors: all in title ?
* powerbash10k: interesting lines seps
* powerline: so what is it ?


## Todo

* provide helpers scripts
* provide a way to update code
* provide a way to load more generic/user profiles
* add support for xxh

