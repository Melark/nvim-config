local Job = require("plenary.job")

local cmp_ollama = {}
cmp_ollama.debug = true
cmp_ollama.endpoint = "http://localhost:11434/api/generate"
cmp_ollama.model = "qwen2.5-coder:3b"

-- helper for logging
local function log(msg, level)
  if cmp_ollama.debug then
    vim.notify("[cmp-ollama] " .. msg, level or vim.log.levels.INFO)
  end
end

-- async request to Ollama
function cmp_ollama.request(prompt, callback)
  log("Starting Ollama request for prompt length " .. #prompt)

  local stdout = {}
  local stderr = {}

  Job:new({
    command = "curl",
    args = {
      "-s",
      "-N",
      "-X",
      "POST",
      cmp_ollama.endpoint,
      "-H",
      "Content-Type: application/json",
      "-d",
      vim.fn.json_encode({
        model = cmp_ollama.model,
        prompt = prompt,
        stream = false,
      }),
    },
    on_stdout = function(_, data)
      if data ~= "" then
        table.insert(stdout, data)
      end
    end,
    on_stderr = function(_, data)
      if data ~= "" then
        table.insert(stderr, data)
      end
    end,
    on_exit = function(_, return_val)
      if return_val ~= 0 then
        log("Ollama job failed: " .. table.concat(stderr, "\n"), vim.log.levels.ERROR)
        callback(nil)
        return
      end

      local joined = table.concat(stdout, "")
      log("Raw response: " .. joined:sub(1, 200) .. "...")

      local ok, decoded = pcall(vim.json.decode, joined)
      if not ok or not decoded then
        log("Failed to decode Ollama response: " .. tostring(joined), vim.log.levels.ERROR)
        callback(nil)
        return
      end

      local text = decoded.response or decoded.message or ""
      log("Received completion text: " .. text:sub(1, 100))
      callback(text)
    end,
  }):start()
end

-- cmp source implementation
local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

function source:is_available()
  return true
end

function source:get_debug_name()
  return "ollama"
end

function source:complete(_, callback)
  local line = vim.api.nvim_get_current_line()
  local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
  local prefix = line:sub(1, cursor_col)

  log("Triggering completion for prefix: " .. prefix)

  cmp_ollama.request(prefix, function(response)
    if not response or response == "" then
      log("No response from Ollama")
      callback({})
      return
    end

    callback({
      {
        label = response,
        insertText = response,
        kind = require("cmp").lsp.CompletionItemKind.Text,
      },
    })
  end)
end

cmp_ollama.source = source
cmp_ollama.new = source.new

return cmp_ollama
