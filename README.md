# nvim-jqx
If only one could easily browse and preview json files in neovim. Oh wait, `nvim-jqx` does just that!

## Installation
Install it using your favourite plugin manager; for instance if you are using vim-plug
```
Plug 'gennaro-tedesco/nvim-jqx'
```
We recommend to use the latest neovim [nightly build](https://github.com/neovim/neovim/releases/tag/nightly), as some lua options may not work otherwise.

`jq` is a prerequisite, as this plugin executes `jq` queries internally.

## Usage
Open a json file and issue `:JqxList`: the json is prettified and the quickfix window is populated with the first level keys. Press `X` on a key to query its values and show the results in a floating window; alternatively `<CR>` takes you to its location in the file.

![](examples/demo.gif)

Default commands

| command     | description
|:----------- |:-------------
|`:JqxList`   | populate the quickfix window with json keys
|`<CR>`       | go to key location in file
|X            | query values of key under cursor
|`<Esc>`      | close floating window

Try it out directly with `nvim examples/test.json -c JqxList`.

## Customisation
If you prefer key-mappings rather than commands simply bind
```
nmap ... <Plug>JqxList
```
The default key to open a query in floating window is `X`: you can ovverride it with
```
lua require('nvim-jqx.config').query_key = ...
```

## Feedback
If you find this plugin useful consider awarding it a ⭐, it is a great way to give feedback! Otherwise, any additional suggestions or merge request is warmly welcome!

