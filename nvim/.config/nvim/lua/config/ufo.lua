local ftMap = {
  vim = 'indent',
  python = { 'indent' },
  git = '',
}

require('ufo').setup {
  provider_selector = function(bufnr, filetype)
    -- return a string type use internal providers
    -- return a string in a table like a string type
    -- return empty string '' will disable any providers
    -- return `nil` will use default value {'lsp', 'indent'}
    return ftMap[filetype]
  end,
}
