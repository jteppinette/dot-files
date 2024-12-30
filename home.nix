{ pkgs, nixpkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.borgbackup
    pkgs.dust
    pkgs.google-cloud-sdk
    pkgs.procs
    pkgs.rclone
    pkgs.reattach-to-user-namespace
    pkgs.ripgrep
    pkgs.sd
    pkgs.tlrc
  ];

  home.sessionVariables = {
    NIX_PATH = "nixpkgs=${nixpkgs}";
    GITHUB_TOKEN = "";
  };

  programs.home-manager.enable = true;
  programs.eza.enable = true;
  programs.fd.enable = true;
  programs.bat.enable = true;
  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./nvim.lua;
    extraPackages = [ pkgs.cargo pkgs.yarn ];
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    shellIntegration = {
      enableZshIntegration = true;
    };
    settings = {
      macos_option_as_alt = "yes";
    };
  };

  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    defaultOptions = [ "--preview" "'bat --color=always --style=numbers --line-range=:250 {}'" ];
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      vimf = ''nvim - o "$(fzf)"'';
      fda = "fd --hidden --exclude .git --exclude .direnv --exclude __pycache__ --type f";
      du = "du -A";
    };
    initExtra = ''
      # keybindings
      bindkey '^A' beginning-of-line
      bindkey '^E' end-of-line
      bindkey '^[[1;3C' forward-word
      bindkey '^[[1;3D' backward-word
      bindkey '^P' history-beginning-search-backward
      bindkey '^N' history-beginning-search-forward

      # zsh-prompt
      autoload -Uz vcs_info
      precmd() { vcs_info }
      zstyle ':vcs_info:git:*' formats '%b '
      setopt PROMPT_SUBST
      PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}''${vcs_info_msg_0_}%f$ '

      # git
      function git-open() { (
          set -e
          git remote >>/dev/null
          remote=''${1:-origin}
          url=$(git config remote.$remote.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")
          echo "git: opening $remote $url"
          open $url
      ); }
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "josheppinette@gmail.com";
    userName = "Joshua Taylor Eppinette";
    aliases = {
      conflicts = "diff --name-only --diff-filter=U --relative";
    };
    extraConfig = {
      merge = { conflictstyle = "zdiff3"; };
      init = { defaultBranch = "main"; };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
      tmuxPlugins.yank
      tmuxPlugins.sensible
      tmuxPlugins.open
      tmuxPlugins.resurrect
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];
    extraConfig = ''
      set-option -g default-command "reattach-to-user-namespace -l ${pkgs.zsh}/bin/zsh"
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}
