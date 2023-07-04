local M = {}

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
  local format = function()
    require("user.plugins.lsp.format").format({ force = true })
  end
  if not M._keys then
  ---@class PluginLspKeys
    -- stylua: ignore
    M._keys = {
      { "<leader>cd", vim.diagnostic.open_float, desc = "Lsp: Line [d]iagnostics" },
      { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp: [L]sp Info" },
      { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Lsp: [G]oto [d]efinition", has = "definition" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "Lsp: [r]eferences" },
      { "gD", vim.lsp.buf.declaration, desc = "Lsp: Goto [D]eclaration" },
      { "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Lsp: Goto [I]mplementation" },
      { "gy", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Lsp: Goto t[y]pe definition" },
      { "K", vim.lsp.buf.hover, desc = "Lsp: Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Lsp: Signature Help", has = "signatureHelp" },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Lsp: Signature Help", has = "signatureHelp" },
      { "]d", M.diagnostic_goto(true), desc = "Lsp: Next [d]iagnostic" },
      { "[d", M.diagnostic_goto(false), desc = "Lsp: Prev [d]iagnostic" },
      { "]e", M.diagnostic_goto(true, "ERROR"), desc = "Lsp: Next [e]rror" },
      { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Lsp: Prev [e]rror" },
      { "]w", M.diagnostic_goto(true, "WARN"), desc = "Lsp: Next [w]arning" },
      { "[w", M.diagnostic_goto(false, "WARN"), desc = "Lsp: Prev [w]arning" },
      { "<leader>cf", format, desc = "Lsp: [F]ormat Document", has = "formatting" },
      { "<leader>cf", format, desc = "Lsp: [F]ormat Range", mode = "v", has = "rangeFormatting" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Lsp: [c]ode [a]ction", mode = { "n", "v" }, has = "codeAction" },
      {
        "<leader>cA",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end,
        desc = "Source Action",
        has = "codeAction",
      }
    }
    if require("user.util").has("inc-rename.nvim") then
      M._keys[#M._keys + 1] = {
        "<leader>cr",
        function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Lsp: [R]ename",
        has = "rename",
      }
    else
      M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Lsp: [R]ename", has = "rename" }
    end
  end
  return M._keys
end

---@param method string
function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_active_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

  local function add(keymap)
    local keys = Keys.parse(keymap)
    if keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end
  for _, keymap in ipairs(M.get()) do
    add(keymap)
  end

  local opts = require("user.util").opts("nvim-lspconfig")
  local clients = vim.lsp.get_active_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    for _, keymap in ipairs(maps) do
      add(keymap)
    end
  end
  return keymaps
end

function M.on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: no-unknown
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return M
