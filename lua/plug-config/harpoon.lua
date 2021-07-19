local harpoon = require("harpoon")
return harpoon.setup({global_settings = {save_on_change = true, save_on_toggle = false}, projects = {["$HOME/qwacc"] = {mark = {marks = {}}, term = {cmds = {"cargo test", "cargo run"}}}}})
