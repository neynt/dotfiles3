local api = vim.api
local curl = require('plenary.curl')

local M = {}

M.send_to_ai = function()
  local api_key = vim.g.ai_api_key -- Set this in your init.lua or .vimrc
  local api_url = vim.g.ai_api_url -- Set this to the appropriate API endpoint

  -- Get the contents of the current buffer
  local lines = api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, '\n')

  -- Prepare the request payload
  local payload = {
    model = "gpt-3.5-turbo", -- Adjust as needed
    messages = {
      {role = "user", content = content}
    }
  }

  -- Send the request to the AI API
  local response = curl.post(api_url, {
    headers = {
      ["Content-Type"] = "application/json",
      ["Authorization"] = "Bearer " .. api_key
    },
    body = vim.fn.json_encode(payload)
  })

  if response.status == 200 then
    -- Parse the response
    local result = vim.fn.json_decode(response.body)
    local ai_response = result.choices[1].message.content

    -- Append the AI's response to the buffer
    api.nvim_buf_set_lines(0, -1, -1, false, vim.split(ai_response, '\n'))
  else
    print("Error: " .. response.status .. " " .. response.body)
  end
end

-- Set up the command
vim.cmd([[command! AIComplete lua require('ai_plugin').send_to_ai()]])

return M
