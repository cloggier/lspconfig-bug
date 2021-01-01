local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = "/tmp/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

execute "packadd packer.nvim"

vim.o.termguicolors = true

require("packer").startup(
  {
    function()
      use "neovim/nvim-lspconfig"
    end,
    config = {package_root = "/tmp/site/pack"}
  }
)

vim.lsp.set_log_level("debug")

require "lspconfig".sumneko_lua.setup {
  cmd = {"lua-language-server"},
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";")
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
        }
      }
    }
  }
}
