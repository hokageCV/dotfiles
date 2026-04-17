local function get_stats()
  local stats = vim.fn.wordcount()
  local is_visual = vim.fn.mode():find("[vV\22]") -- \22 handles visual block mode

  if is_visual then
    return {
      words = stats.visual_words or 0,
      chars = stats.visual_chars or 0,
      is_visual = true,
    }
  else
    return {
      words = stats.words or 0,
      chars = stats.chars or 0,
      is_visual = false,
    }
  end
end

local function wordcount()
  local stats = get_stats()
  local word_label = stats.words == 1 and "word" or "words"
  local char_label = stats.chars == 1 and "char" or "chars"

  -- If in visual mode, show both words and characters
  if stats.is_visual then
    return string.format("%d %s, %d %s", stats.words, word_label, stats.chars, char_label)
  end

  -- Default view for normal mode
  return stats.words .. " " .. word_label
end

local function is_prose()
  -- Common prose types: markdown, text, plaintex, org, etc.
  return vim.bo.filetype == "markdown" or vim.bo.filetype == "text"
end

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_b = {}

      opts.sections.lualine_y = {
        { "progress", padding = { left = 1, right = 1 } },
      }

      opts.sections.lualine_z = {
        { wordcount, cond = is_prose },
      }
    end,
  },
}
