local utils = require("utils")
utils["map-command"]("n", "<leader>.", "HopWord")
utils["map-command"]("n", "<leader>m", "HopLine")
return utils["map-command"]("n", "<leader>p", "HopPattern")
