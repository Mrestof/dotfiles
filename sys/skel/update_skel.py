#!/bin/env python3.12
from pathlib import PosixPath


HOME = PosixPath.home()
SKEL = PosixPath('/etc/skel')
CONF = SKEL / PosixPath('.config')
LOCAL = SKEL / PosixPath('.local')

BASH_FILES = '.bashrc', '.bash_profile', '.bash_logout'

UD_FILE = CONF / 'user-dirs.dirs'
USER_DIRS = {
    'XDG_MUSIC_DIR': 'musi',
    'XDG_VIDEOS_DIR': 'vids',
    'XDG_PICTURES_DIR': 'pics',
    'XDG_DOWNLOAD_DIR': 'dwns',
    'XDG_DOCUMENTS_DIR': 'docs',
    'XDG_DESKTOP_DIR': 'docs/trash/xdg-defs/desktop',
    'XDG_TEMPLATES_DIR': 'docs/trash/xdg-defs/templates',
    'XDG_PUBLICSHARE_DIR': 'docs/trash/xdg-defs/publicshare',
}

LOG_DIR = LOCAL / 'log'


def cut_bash() -> None:
    for bf in BASH_FILES:
        absolute_bf = SKEL / bf
        absolute_bf.unlink(missing_ok=True)


def mk_userdirs() -> None:
    for dir in USER_DIRS.values():
        skel_dir = SKEL / dir
        skel_dir.mkdir(parents=True, exist_ok=True)
    UD_FILE.parent.mkdir(parents=True, exist_ok=True)
    with UD_FILE.open('w') as udf:
        for key_name, path in USER_DIRS.items():
            line = f'{key_name}="$HOME/{path}"\n'
            udf.write(line)


def main() -> int:
    print(f'delete bash files from skel {BASH_FILES}')
    cut_bash()
    print(f'create user dirs and the appropriate file: {UD_FILE}')
    mk_userdirs()
    print(f'create log dir: {LOG_DIR}')
    LOG_DIR.mkdir(parents=True, exist_ok=True)  # too simple to be a function
    return 0


if __name__ == '__main__':
    exit(main())
