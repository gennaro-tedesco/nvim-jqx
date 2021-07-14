<h1 align="center">
  <br>
  <img width="350" height="300" src="examples/logo.png">
  <br>
  nvim-jqx
  <br>
</h1>

<h2 align="center">
  <img alt="PR" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat"/>
  <img alt="Lua" src="https://img.shields.io/badge/lua-%232C2D72.svg?&style=flat&logo=lua&logoColor=white"/>
</h2>

<h4 align="center">Populate the quickfix with json entries</h4>

<h3 align="center">
  <a href="#Installation">Installation</a> •
  <a href="#Usage">Usage</a> •
  <a href="#Customisation">Customisation</a> •
  <a href="#Feedback">Feedback</a>
</h3>

If only one could easily browse and preview json files in neovim. Oh wait, `nvim-jqx` does just that!

## Installation
Install it using your favourite plugin manager; for instance if you are using vim-plug
```
Plug 'gennaro-tedesco/nvim-jqx'
```
Notice that `jq` is a prerequisite, as this plugin executes `jq` queries internally.

## Usage
`nvim-jqx` exposes two commands: `JqxList` and `JqxQuery`.
Open a json file and issue `JqxList`: the json is prettified and the quickfix window is populated with the first level keys. Press `X` on a key to query its values and show the results in a floating window; alternatively `<CR>` takes you to its location in the file.

![JqxListdemo](https://user-images.githubusercontent.com/15387611/113495463-4bd24500-94f2-11eb-88b5-64c1ee965886.gif)

`JqxList` also accepts an optional argument representing the json type you want to subselect: for example `JqxList number` populates the quickfix with entries of type number only, so do `JqxList string`, `JqxList boolean` and so forth, respectively: this is quite useful for big files where you want to have a quick peek at, say, some numerical values only or similar. For a full list of available types see `h: jqx-usage` or simply hit `<Tab>` to show the autocomplete for available types.

To execute more complicated and generic `jq` commands use `JqxQuery` instead; the prompt helps autocomplete with the file keys for easy typing. Open a json file `test.json` and issue `JqxQuery <my-query>`: this translates into `jq ".<my-query>" test.json` as shown below

```
# JqxQuery grammar
JqxQuery friends[2].name
"Michael Marquez"

# jq equivalent
jq '.friends[2].name' test.json
"Michael Marquez"
```
![JqxQuerydemo](https://user-images.githubusercontent.com/15387611/113495732-ab7d2000-94f3-11eb-8781-0497771b60a1.gif)

Default commands

| command            | description
|:------------------ |:-------------
|`JqxList`           | populate the quickfix window with json keys
|`JqxList string`    | populate the quickfix window with string values
|`JqxQuery`          | executes a generic `jq` query in the current file
|`<CR>`              | go to key location in file
|X                   | query values of key under cursor
|`<Esc>`             | close floating window

Try it out directly with `nvim examples/test.json -c JqxList`.

For more in-depth description and explanations check the documentation `:h nvim-jqx` and links therein.

### Yaml files
`nvim-jqx` works on `yaml` files too. It requires, however, to install [yq](https://github.com/mikefarah/yq). Try it out directly with `nvim examples/test.yaml -c JqxList`, or execute `JqxQuery` on a `yaml` file.

## Customisation
If you prefer key-mappings rather than commands simply bind
```
nmap ... <Plug>JqxList
```
The list of json keys is sorted alphabetically in the quickfix window: if instead you prefer having it in the same order as they appear in the original file, override the default configuration with (notice it requires `jq >= 1.5`)
```
lua require('nvim-jqx.config').sort = false
```
The default key to open a query in floating window is `X`: you can ovverride it with
```
lua require('nvim-jqx.config').query_key = ...
```

## Feedback
If you find this plugin useful consider awarding it a ⭐, it is a great way to give feedback! Otherwise, any additional suggestions or merge request is warmly welcome!

