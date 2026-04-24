return {
  'milanglacier/minuet-ai.nvim',
  event = 'InsertEnter',
  opts = {
    provider = 'openai_fim_compatible',
    n_completions = 1,
    context_window = 512,
    throttle = 1200,
    debounce = 400,

    provider_options = {
      openai_fim_compatible = {
        api_key = 'lm-studio',
        name = 'LMStudio',
        end_point = 'http://localhost:1234/v1/completions',
        model = 'qwen2.5-coder',
        optional = {
          max_tokens = 56,
          top_p = 0.9,
        },
      },
    },

    virtualtext = {
      auto_trigger_ft = { '*' },
      auto_trigger_ignore_ft = { 'TelescopePrompt', 'fzf', 'oil', 'lazy', 'mason', 'help', 'markdown' },
      keymap = {
        accept       = '<A-a>',
        accept_line  = '<A-l>',
        accept_n_lines = '<A-n>',
        next         = '<A-]>',
        prev         = '<A-[>',
        dismiss      = '<A-e>',
      },
    },
  },
}
