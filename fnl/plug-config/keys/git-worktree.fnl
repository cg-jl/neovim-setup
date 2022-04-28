(import-macros mutils :fnl.utils-macros)

;; for telescope
(mutils.nvim-mapcmd :n :<leader>gw "Telescope git_worktree git_worktrees")
(mutils.nvim-mapcmd :n :<leader>gwn "Telescope git_worktree create_git_worktree")
