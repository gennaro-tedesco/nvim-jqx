# nvim-jqix
If only one could easily browse and preview json files in neovim. Oh wait, `nvim-jqix` does just that!

## Installation
Install it using your favourite plugin manager; for instance if you are using vim-plug
```
Plug 'gennaro-tedesco/nvim-jqix'
```
We recommend to use the latest neovim [nightly build](https://github.com/neovim/neovim/releases/tag/nightly), as some lua options may not work otherwise.

`jq` is a prerequisite, as this plugin executes `jq` queries internally.

## Usage
Open a json file and issue `:JsonQf`: the json is prettified and the quickfix window is populated with the first level keys. Press `X` on a key to query its values and show the results in a floating window; alternatively `<CR>` takes you to its location in the file.

Default commands

| key      | description
|:-------- |:-------------
|:JsonQf   | populate the quickfix window with json keys
|`<CR>`    | go to key location in file
|X         | query values of key under cursor
|`<Esc>`   | close floating window

## Customisation
If you prefer key-mappings rather than commands simply bind
```
nmap ... <Plug>JsonQf
```

## Feedback
If you find this plugin useful consider awarding it a ⭐, it is a great way to give feedback! Otherwise, any additional suggestions or merge request is warmly welcome!

