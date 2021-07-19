local kommentary_config = require("kommentary.config")
kommentary_config.use_extended_mappings()
kommentary_config.configure_language("default", {prefer_single_line_comments = true})
return kommentary_config.configure_language("rust", {multi_line_comment_strings = {"/*", "*/"}, single_line_comment_string = "//"})
