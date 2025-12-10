return {
  'David-Kunz/gen.nvim',
  opts = {
    model = 'qwen2.5-coder:14b',
    quit_map = 'q',
    retry_map = '<c-r>',
    accept_map = '<c-cr>',
    host = 'localhost',
    port = '11434',
    display_mode = 'float',
    show_prompt = false,
    show_model = false,
    no_auto_close = false,
    hidden = false,
    init = function(options)
      pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
    end,
    command = function(options)
      local body = { model = options.model, stream = true }
      return 'curl --silent --no-buffer -X POST http://'
        .. options.host
        .. ':'
        .. options.port
        .. '/api/chat -d $body'
    end,
    debug = false,
  },
  config = function(_, opts)
    require('gen').setup(opts)

    -- Custom prompts for code tasks
    require('gen').prompts['Complete_Code'] = {
      prompt = 'Complete the following code. Only provide the completion:\n\n```$filetype\n$text\n```',
      replace = false,
    }

    require('gen').prompts['Explain_Code'] = {
      prompt = 'Explain the following code:\n\n```$filetype\n$text\n```',
      replace = false,
    }

    require('gen').prompts['Fix_Code'] = {
      prompt = 'Fix any bugs in the following code:\n\n```$filetype\n$text\n```',
      replace = false,
    }

    require('gen').prompts['Optimize_Code'] = {
      prompt = 'Optimize the following code for performance:\n\n```$filetype\n$text\n```',
      replace = false,
    }

    require('gen').prompts['Add_Comments'] = {
      prompt = 'Add helpful comments to the following code:\n\n```$filetype\n$text\n```',
      replace = false,
    }

    require('gen').prompts['Generate_Tests'] = {
      prompt = 'Generate comprehensive unit tests for the following code:\n\n```$filetype\n$text\n```',
      replace = false,
    }

    require('gen').prompts['Refactor_Code'] = {
      prompt = 'Refactor the following code to improve quality:\n\n```$filetype\n$text\n```',
      replace = false,
    }

    require('gen').prompts['Find_Bugs'] = {
      prompt = 'Find potential bugs in the following code:\n\n```$filetype\n$text\n```',
      replace = false,
    }

    require('gen').prompts['Generate_Docs'] = {
      prompt = 'Generate documentation for the following code:\n\n```$filetype\n$text\n```',
      replace = false,
    }

    require('gen').prompts['Review_Code'] = {
      prompt = 'Review the following code and suggest improvements:\n\n```$filetype\n$text\n```',
      replace = false,
    }
  end,
}
