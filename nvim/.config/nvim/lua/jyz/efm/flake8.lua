return {
  lintCommand = "flake8 --stdin-display-name ${INPUT} -",
  lintStdin = true,
  -- lintIgnoreExitCode = true,
  lintFormats = {"%f:%l:%c: %m"},
  -- lintFormats = {"%f=%l:%c: %m"},
}
