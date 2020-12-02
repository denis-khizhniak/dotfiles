#!/bin/python

# ===== Settings ===== {{{
# Load autoconfig.yml for changes via :set and :bind to persist between restarts
config.load_autoconfig()
# ===== Settings ===== }}}
# ===== KEYS ===== {{{
config.bind(",m", "spawn umpv {url}")
config.bind(";M", "hint --rapid links spawn umpv {hint-url}")
config.bind("<Ctrl-y>", "prompt-yes", mode="prompt")
config.bind("K", "tab-next")
config.bind("J", "tab-prev")
config.bind("<Ctrl-Shift-j>", "tab-move -")
config.bind("<Ctrl-Shift-k>", "tab-move +")
config.bind("<Ctrl-2>", "spawn data_picker")
config.bind("<Ctrl-2>", "spawn data_picker", mode="insert")
config.bind("xq", "quickmark-del")
config.bind("xb", "bookmark-del")
config.unbind("d")
config.bind("dd", "tab-close")
config.bind("dk", "tab-only --prev")
config.bind("dj", "tab-only --next")
config.bind(',p', 'spawn --userscript qute-pass --dmenu-invocation dmenu')
config.bind(',P', 'spawn --userscript qute-pass --dmenu-invocation dmenu --password-only')
config.bind('gP', 'back -t')
# ===== KEYS ===== }}}
# ===== key mappings ===== {{{
c.bindings.key_mappings = {
    "<Ctrl-6>": "<Ctrl-^>",
    "<Ctrl-Enter>": "<Ctrl-Return>",
    "<Ctrl-J>": "<Return>",
    "<Ctrl-M>": "<Return>",
    "<Ctrl-[>": "<Escape>",
    "<Enter>": "<Return>",
    "<Shift-Enter>": "<Return>",
    "<Shift-Return>": "<Return>",
    "Й": "Q",
    "й": "q",
    "Ц": "W",
    "ц": "w",
    "У": "E",
    "у": "e",
    "К": "R",
    "к": "r",
    "Е": "T",
    "е": "t",
    "Н": "Y",
    "н": "y",
    "Г": "U",
    "г": "u",
    "Ш": "I",
    "ш": "i",
    "Щ": "O",
    "щ": "o",
    "З": "P",
    "з": "p",
    "Х": "{",
    "х": "[",
    "Ъ": "}",
    "ъ": "]",
    "Ф": "A",
    "ф": "a",
    "Ы": "S",
    "ы": "s",
    "В": "D",
    "в": "d",
    "А": "F",
    "а": "f",
    "П": "G",
    "п": "g",
    "Р": "H",
    "р": "h",
    "О": "J",
    "о": "j",
    "Л": "K",
    "л": "k",
    "Д": "L",
    "д": "l",
    "Ж": ":",
    "ж": ";",
    "Э": '"',
    "э": "'",
    "Я": "Z",
    "я": "z",
    "Ч": "X",
    "ч": "x",
    "С": "C",
    "с": "c",
    "М": "V",
    "м": "v",
    "И": "B",
    "и": "b",
    "Т": "N",
    "т": "n",
    "Ь": "M",
    "ь": "m",
    "Б": "<",
    "б": ",",
    "Ю": ">",
    "ю": ".",
    ",": "?",
    ".": "/",
}
# ===== key mappings ===== }}}
