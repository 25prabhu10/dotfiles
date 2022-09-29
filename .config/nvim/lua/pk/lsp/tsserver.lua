return {
  enable_import_on_completion = true,

  -- import all
  import_all_timeout = 5000, -- ms
  import_all_priorities = {
    buffers = 4, -- loaded buffer names
    buffer_content = 3, -- loaded buffer content
    local_files = 2, -- git files or files with relative path markers
    same_file = 1, -- add to existing import statement
  },
  import_all_scan_buffers = 100,
  import_all_select_source = false,
}
