_This repo contains the Nix configuration for my MacOS and Linux machines. Follow the documentation below to get started._

# Getting Started

1. Add ssh keys

2. [Install Nix](https://zero-to-nix.com/start/install/)

3. Sync

   ```
   $ ./sync.sh
   ```

4. Set zsh as default shell

# Development

Once you have the environment setup, you can use the `devShells` support via direnv to manage the development environment for this project.

**Setup**

```sh
$ direnv allow
$ pre-commit install
```

**Precommit**

```sh
$ pre-commit run --all
```

# References

- [https://github.com/mrkuz/macos-config](https://github.com/mrkuz/macos-config)
- [https://github.com/dustinlyons/nixos-config](https://github.com/dustinlyons/nixos-config)
