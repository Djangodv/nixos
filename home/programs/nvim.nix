{ inputs, pkgs, ... }:
let
  neovim-nightly = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
in
{
  programs.neovim = {
    enable = true;
    package = neovim-nightly;
    # package = inputs.nvim.packages.${pkgs.system}.default;
    plugins = with pkgs.vimPlugins; [
      # LSP server configurations
      # nvim-lspconfig
      # Bridge between mason and nvim-lspconfig
      # mason-lspconfig-nvim
      # mason-nvim
      # markdown-preview-nvim
      # gitsigns-nvim
      # kanagawa-nvim
    ];
  };
}
