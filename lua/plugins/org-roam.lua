return {
  'chipsenkbeil/org-roam.nvim',
  tag = '0.1.1',
  ft = { 'org' },
  dependencies = {
    {
      'nvim-orgmode/orgmode',
      tag = '0.3.7',
    },
  },
  config = function()
    require('org-roam').setup {
      directory = '/Users/thrilok/Documents/org_roam_files',
      
      -- Capture templates for different types of knowledge nodes
      templates = {
        -- Default note template
        n = {
          description = 'Note',
          template = '#+TITLE: %?\n#+DATE: %U\n#+FILETAGS: \n\n* Overview\n\n* Details\n\n* References\n\n* Related\n\n'
        },
        -- Concept template for learning
        c = {
          description = 'Concept',
          template = '#+TITLE: %?\n#+DATE: %U\n#+FILETAGS: :concept:\n\n* Definition\n\n* Key Points\n- \n\n* Examples\n\n* Applications\n\n* Related Concepts\n\n* References\n\n'
        },
        -- Person template for networking
        p = {
          description = 'Person',
          template = '#+TITLE: %?\n#+DATE: %U\n#+FILETAGS: :person:\n\n* Contact Info\n- Email: \n- Phone: \n- LinkedIn: \n\n* Background\n\n* Interactions\n\n* Notes\n\n'
        },
        -- Book/Resource template
        b = {
          description = 'Book/Resource',
          template = '#+TITLE: %?\n#+DATE: %U\n#+FILETAGS: :resource:book:\n\n* Metadata\n- Author: \n- Published: \n- Pages: \n- Rating: /5\n\n* Summary\n\n* Key Takeaways\n- \n\n* Quotes\n\n* Related Resources\n\n'
        },
        -- Project template
        pr = {
          description = 'Project',
          template = '#+TITLE: %?\n#+DATE: %U\n#+FILETAGS: :project:\n\n* Project Overview\n\n* Goals\n- [ ] \n\n* Timeline\n\n* Resources Needed\n\n* Stakeholders\n\n* Progress Log\n\n'
        },
        -- Area of Interest template
        a = {
          description = 'Area of Interest',
          template = '#+TITLE: %?\n#+DATE: %U\n#+FILETAGS: :area:\n\n* Description\n\n* Why Important\n\n* Current Status\n\n* Learning Resources\n- [ ] \n\n* Projects\n\n* People\n\n'
        },
        -- Daily Note template
        d = {
          description = 'Daily Note',
          template = '#+TITLE: %<%Y-%m-%d>\n#+DATE: %U\n#+FILETAGS: :daily:\n\n* Weather: \n\n* Mood: \n\n* Priorities\n- [ ] \n\n* What Happened\n\n* Lessons Learned\n\n* Tomorrow\n- [ ] \n\n'
        }
      },
      
      -- Enhanced org files integration
      org_files = {
        '/Users/thrilok/Documents/orgfiles/**/*.org',
        '/Users/thrilok/Documents/org_roam_files/**/*.org',
      },
      
      -- Database location for faster searches
      database = {
        path = '/Users/thrilok/Documents/org_roam_files/org-roam.db'
      },
      
      -- Enhanced completion
      completion = {
        nvim_cmp = true
      }
    }
  end,
}
