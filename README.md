# docker-svn

SVN cut out into a container.

For who use SVN to download files from GitHub.
For who doesn't use SVN as CVS.

## Motivation

I need SVN just for downloading files. But every time SVN dums `~/.subversion` in my home.
I really hate it. So I wrote an Dockerfile.

## Usage

Add the one line to your `.zshrc`/`.bashrc`.

```sh
alias svn='docker run --rm -v "${PWD}:/mnt${PWD}" 0xTadash1/docker-svn "$PWD"'
```

OR run bellow one, and reload shell.

- If you use **zsh**,
  ```sh
  echo "alias svn='docker run --rm -v \"\${PWD}:/mnt\${PWD}\" 0xTadash1/docker-svn \"\$PWD\"'" >> ${ZDOTDIR:-$HOME}/.zshrc
  ```

- If you use **bash**,
  ```sh
  echo "alias svn='docker run --rm -v \"\${PWD}:/mnt\${PWD}\" 0xTadash1/docker-svn \"\$PWD\"'" >> ${HOME}/.bashrc
  ```

---

You can test via a bellow command. This should list files in [here](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono/Ligatures).

```sh
svn ls 'https://github.com/ryanoasis/nerd-fonts/trunk/patched-fonts/JetBrainsMono/Ligatures'
```

## Build

```sh
docker buildx b -t 0xTadash1/docker-svn:$BASE_IMAGE_V .
```

## License

[MIT](https://github.com/0xTadash1/docker-svn/blob/main/LICENSE)
