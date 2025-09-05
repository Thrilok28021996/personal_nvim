return {
  'nvim-orgmode/orgmode',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup {
      org_agenda_files = '/Users/thrilok/Documents/orgfiles/**/*',
      org_default_notes_file = '/Users/thrilok/Documents/orgfiles/refile.org',

      -- Enhanced productivity settings
      org_todo_keywords = { 'TODO(t)', 'NEXT(n)', 'IN-PROGRESS(p)', 'WAITING(w)', '|', 'DONE(d)', 'CANCELLED(c)' },
      org_todo_keyword_faces = {
        TODO = ':foreground red',
        NEXT = ':foreground orange',
        ['IN-PROGRESS'] = ':foreground yellow',
        WAITING = ':foreground blue',
        DONE = ':foreground green',
        CANCELLED = ':foreground gray',
      },

      -- Capture templates for different note types
      org_capture_templates = {
        t = {
          description = 'Task',
          template = '* TODO %?\n  SCHEDULED: %t\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n\n',
          target = '/Users/thrilok/Documents/orgfiles/tasks.org',
        },
        n = {
          description = 'Note',
          template = '* %?\n  :PROPERTIES:\n  :CREATED: %U\n  :SOURCE: %a\n  :END:\n\n',
          target = '/Users/thrilok/Documents/orgfiles/notes.org',
        },
        j = {
          description = 'Journal Entry',
          template = '* %U %?\n\n',
          target = '/Users/thrilok/Documents/orgfiles/journal.org',
        },
        p = {
          description = 'Project',
          template = '* PROJECT %?\n  :PROPERTIES:\n  :CREATED: %U\n  :STATUS: ACTIVE\n  :END:\n\n** Objectives\n- [ ] \n\n** Resources\n\n** Notes\n\n',
          target = '/Users/thrilok/Documents/orgfiles/projects.org',
        },
        m = {
          description = 'Meeting Notes',
          template = '* Meeting: %?\n  :PROPERTIES:\n  :DATE: %T\n  :ATTENDEES: \n  :END:\n\n** Agenda\n\n** Notes\n\n** Action Items\n- [ ] \n\n',
          target = '/Users/thrilok/Documents/orgfiles/meetings.org',
        },
        i = {
          description = 'Idea',
          template = '* IDEA %?\n  :PROPERTIES:\n  :CREATED: %U\n  :TAGS: idea\n  :END:\n\n',
          target = '/Users/thrilok/Documents/orgfiles/ideas.org',
        },
        r = {
          description = 'Reference',
          template = '* %?\n  :PROPERTIES:\n  :CREATED: %U\n  :URL: \n  :TYPE: reference\n  :END:\n\n',
          target = '/Users/thrilok/Documents/orgfiles/references.org',
        },
      },

      -- Calendar and agenda settings
      org_agenda_start_on_weekday = 1,
      org_agenda_span = 'week',
      org_agenda_skip_scheduled_if_done = true,
      org_agenda_skip_deadline_if_done = true,

      -- Archive settings
      org_archive_location = '/Users/thrilok/Documents/orgfiles/archive.org::* Archived Tasks',

      -- Log settings
      org_log_done = 'time',
      org_log_into_drawer = 'LOGBOOK',

      -- Tags
      org_tags_column = 80,

      -- Priorities
      org_priority_highest = 'A',
      org_priority_lowest = 'C',
      org_priority_default = 'B',
    }

    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    -- add ~org~ to ignore_install
    -- require('nvim-treesitter.configs').setup({
    --   ensure_installed = 'all',
    --   ignore_install = { 'org' },
    -- })
  end,
}
