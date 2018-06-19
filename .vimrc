" vim: foldmarker={,}: filetype=vim: foldmethod=marker: foldlevel=0: tabstop=4: shiftwidth=4:
" https://github.com/AInotamm/.dotfile
" Aexcm Irvin's neoVIM configuration
"

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugins')

" Environment {
	" Script scoped variables {
		" Let script know plugins was enabled
		let s:use_plugins =1
	"}
	
	" VI Improved, but in neoVIM, this can't set compatible
	set nocompatible

	" Write the viminfo file inside the Vim directory
	" neoVIM now support shade format not .viminfo
	if !has('nvim')
		set viminfo +=n~/.vim/viminfo
	endif

	" Collect history instead of having them in '.'
	" newVIM default point to $XDG_DATA_HOME/nvim/undo
	if !has('nvim')
		set undodir =~/.vim/undo
	endif

	" Vim expects a POSIX-compliant shell
	set shell =/bin/bash

	" Use unicode inside vim's registers, viminfo, buffers, etc
	set encoding =utf-8
"}

" Abbreviations {
	abbr teh the
	abbr cosnt const
	abbr fitler filter
	abbr funciton function
	abbr tempalte template
	abbr attribtue attribute
	abbr attribuet attribute
"

" General {
	" vim {
		if !has('nvim')
			" Detect file type
			filetype on

			" Detect file custom indent
			filetype indent on

			" Detect plugin and load it
			filetype plugin	on

			" Detect when a file is changed
			set autoread

			" Make backspace work like expected
			set backspace =indent,eol,start

			" Enable mouse
			if has('mouse')
				set mouse =a
			endif

			" Don't store global and local variables when saving sessions
			set sessionoptions -=options

			" Smoother changes
			set ttyfast

			" Improve shell
			if !has('gui_running')
				" Make arrow and other keys work
				if !has('win32') && !has('win64')
					set term =$TERM
				endif

				" Needed for mouse support inside GNU screen
				if &l:term =~ "screen.*"
					set ttymouse =xterm2
				endif
			endif
		endif
	" }

	" Syntax highlighting but keep current colors
	" If set on, will use default colors for syntax highlighting
	if exists("g:syntax_on")
		syntax off
	else
		syntax enable
	endif

	" Change effect of the :mkview command
	set viewoptions	=folds,cursor,curdir,slash,unix

	" Store some but not large history
	set history =1024

	" Languages to do spell checking for
	set spelllang =en_us

	" Limit spell suggestions
	set spellsuggest =best,10

	" show results of substition as they're happening
	" but don't open a split
	if has('nvim')
		set inccommand =nosplit
	endif

	" Use register '*' instead of unnamed register
	if has('unnamedplus')
		set clipboard +=unnamedplus
	else
		if has('gui_running')
			set clipboard +=unnamed
		endif
	endif 

	" Save undo to file in undodir
	set undofile

	" Increase levels of undo to keep in memory
	set undolevels =2048

	" Timeout for mapping and keycode
	set timeoutlen =1500
"}

" Belling {
	" No ring when display error message
	set noerrorbells

	" Use visual bell
	set visualbell
"}

" Complete {
	" Insert most common completion and show menu
	set completeopt :longest,menu,preview

	" Specifies a function to be used for Insert mode omni completion
	" with C-X/C-O
	" Plugin was included in vim
	if has('autocmd') && exists('+omnifunc')
		autocmd Filetype *
			\ if &omnifunc == "" |
			\     setlocal omnifunc :syntaxcomplete&Complete |
			\ endif
	endif
" }

" Searching {
	if !has('nvim')
		" Highlight search results
		set hlsearch

		" Incremental search like modern browsers
		set incsearch

		" Don't redraw while executing macros
		set nolazyredraw

		" Case insensitive search	
		set ignorecase

		" Special characters can be used in search patterns
		set magic
	endif

	" Case-sensitive if expresson contains a capital letter
	set smartcase

	" Don't wrap search around file						
	set nowrapscan

	" Highlight git merge conflict marker
	match ErrorMsg '^(\<|\=|\>){7}([^=].+)?$'
" }

" UI {
	" Appearance {
		" Show current cursor position in the low right corner
		set ruler

		" Show title in console title bar
		set title

		" Show line numbers
		set number

		" Don't show unprintable characters
		set nolist

		" Show incomplete commands in the lower right corner
		set showcmd

		" Enable tab-completion menu
		" default: on
		set wildmenu

		" Show current mode in the last line
		set showmode

		" Shortly jump to a matching bracket when match
		set showmatch

		" Indicate wrapped lines
		set showbreak =↪

		" Set right background color
		set background =dark

		" Complete files like a shell
		set wildmode =list:longest

		" Characters to use for list
		set listchars =eol:¬,tab:→\ ,trail:⋅,extends:❯,precedes:❮,nbsp:+
	" }

	" Display {
		" Enable highlight the current line
		set cursorline

		" Enable display folding, default on
		set foldenable

		" Enable open horizontal split below
		set splitbelow

		" Enable open vertical split to the right
		set splitright

		" Disabled highlight the current column
		set nocursorcolumn

		" No line spacing, expect for win32
		set linespace =0

		" Minimum lines to keep above and below
		set scrolloff =3

		" Lines to scroll when cursor leaves screen
		set scrolljump =5

		" Always show the status line
		set laststatus =2

		" Upper limit on number of tabs
		set tabpagemax =64
	" }

	" Formatting {
		" Wrap long lines
		set wrap

		" Tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
		set smarttab

		" Set soft wrapping
		set linebreak

		" Expand tabs to spaces
		set expandtab

		" Round indent to a multiple of 'shiftwidth'
		set shiftround

		" Auto indent lines
		set autoindent

		" Indent smart on C-like files
		set smartindent

		" Copy indentstructure from existing lines
		set copyindent

		" Try to preserve indent structure on changes of current line
		set preserveindent

		" Allow match <> with %
		set matchpairs =(:),{:},[:],<:>

		" Let a tab be 4 spaces wide
		set tabstop =4

		" How many tenths of a second to blink
		set matchtime =2

		" Tab width for auto indent and >> shifting
		set shiftwidth =4

		" Number of spaces to count a tab for on ops like BS and tab
		set softtabstop =4

		" Abbreviate messages
		" f: (3 of 5) -> (file 3 of 5)
		" i: [noeol] -> [Incomplete last line]
		" l: 999L,888C -> 999 lines, 888 characters
		" m: [+] -> [Modified]
		" n: [New] -> [New File]
		" r: [RO] -> [Readonly]
		" x: [doc/unix/mac] -> [doc/unix/mac format]
		" o: 
		" O:
		" t: truncate too long file message
		" T: truncate too long other message
		" I: don't give intro message when starting vim
		set shortmess =filmnrxoOtTI

		" What to increment/decrement with ^A and ^X
		set nrformats =alpha,octal,hex

		" Formatting options
		" t: Auto-wrap text using text-width
		" c: Auto-wrap comments using text-width
		" r: Automatically insert the current comment leader after hitting <Enter> in Insert code
		" o: Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode
		" q: Allow formatting of comment with 'gq'
		" w: 
		" n: When formatting text, recognize numbered list
		" l: When a line was longer than 'textwidth', vim doesn't format it
		" 1: Don't break a line after a one-letter word
		" j: Remove a comment leader when joining lines
		set formatoptions =tcroqwnl1j
	" }

	" Folding {

		" Folds with higher level will be closed
		set foldlevel =1

		" Show a column which indicated open and closed folds
		set foldcolumn =2

		" Deepest fold is 10 levels
		set foldnestmax =10

		" Start out with everything unfolded
		set foldlevelstart =99

		" Specify for which type of commands fold will be opened
		set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
	" }

	" VIM support 256-color
	if !has('nvim') && !has('gui_running')
		" Explicitly tell vim that the terminal supports 256 colors
		set t_Co =256
	endif

	" Enable 24 bit color support if supported
	if has('mac') && has("termguicolors") && empty($TMUX)
		set termguicolors
	endif
" }

" Plugin {
	" UI {
		" https://github.com/itchyny/lightline.vim
		" A light and configurable statusline/tabline plugin for Vim
		Plug 'itchyny/lightline.vim'

		" https://github.com/ryanoasis/vim-devicons
		" Add icons to your plugin
		Plug 'ryanoasis/vim-devicons'

		" https://github.com/mhinz/vim-startify
		" Provide a start screen for Vim and Neovim
		Plug 'mhinz/vim-startify'

		" https://github.com/mhinz/vim-signify
		" Show a diff using Vim its sign column
		Plug 'mhinz/vim-signify'

		" https://github.com/nathanaelkane/vim-indent-guides
		" For visually displaying indent levels in code
		Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }

		" https://github.com/scrooloose/nerdtree
		" The NERDTree is a file system explorer for the Vim editor
		" NERD tree will be loaded on the first invocation of NERDTreeToggle command
		Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	" }

	" Theme {
		" https://github.com/arcticicestudio/nord-vim
		" Nord Vim is a 16 colorspace theme build to run in GUI- and terminal mode with support for many third-party plugins and styles for lightline.vim and vim-airline.
		Plug 'arcticicestudio/nord-vim'
	"}

	" Misc {
		" https://github.com/yonchu/accelerated-smooth-scroll
		" Accelerated smooth scroll 
		Plug 'yonchu/accelerated-smooth-scroll'
	"}

	" NERDTree Extra {
		" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
		" This adds syntax for nerdtree on most common file extensions
		Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

		" https://github.com/Xuyuanp/nerdtree-git-plugin
		" A plugin of NERDTree showing git status flags
		Plug 'Xuyuanp/nerdtree-git-plugin'

		" https://github.com/jistr/vim-nerdtree-tabs
		" NERDTree and tabs together in Vim, painlessly
		Plug 'jistr/vim-nerdtree-tabs'
	"}
"}

" Lightline {
	" Global empty setting
	let g:lightline ={}

	" Colorscheme
	let g:lightline.colorscheme ='nord'

	" Active the statusline/tabline components
	let g:lightline.active ={
	\		'left': [ [ 'mode', 'paste' ],
	\				[ 'gitbranch' ],
	\				[ 'readonly', 'filetype', 'filename' ]],
	\		'right': [ [ 'percent' ], [ 'lineinfo' ],
	\				[ 'fileformat', 'fileencoding' ],
	\				[ 'linter_errors', 'linter_warnings' ]]}

	" Sub separators
	let g:lightline.subseparator ={ 'left': '', 'right': '' }

	" Expand custom components
	let g:lightline.component_expand ={
	\		'linter': 'LightlineLinter',
	\		'linter_warnings': 'LightlineLinterWarnings',
	\		'linter_errors': 'LightlineLinterErrors',
	\		'linter_ok': 'LightlineLinterOk'}

	" Specify the type for expand components
	let g:lightline.component_type ={
	\		'readonly': 'error',
	\		'linter_warnings': 'warning',
	\		'linter_errors': 'error'}

	" Custom function components
	let g:lightline.component_function ={
	\		'fileencoding': 'LightlineFileEncoding',
	\		'filename': 'LightlineFileName',
	\		'fileformat': 'LightlineFileFormat',
	\		'filetype': 'LightlineFileType',
	\		'gitbranch': 'LightlineGitBranch'}

	function! LightlineFileName() abort
		let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
		if filename =~ 'NERD_tree'
			return ''
		endif
		let modified = &modified ? ' +' : ''
		return fnamemodify(filename, ":~:.") . modified
	endfunction

	function! LightlineFileEncoding()
		" only show the file encoding if it's not 'utf-8'
		return &fileencoding == 'utf-8' ? '' : &fileencoding
	endfunction

	function! LightlineFileFormat()
		" only show the file format if it's not 'unix'
		let format = &fileformat == 'unix' ? '' : &fileformat
		return winwidth(0) > 70 ? format . ' ' . WebDevIconsGetFileFormatSymbol() : ''
	endfunction

	function! LightlineFileType()
		return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
	endfunction

	function! LightlineLinter() abort
		let l:counts = ale#statusline#Count(bufnr(''))
		return l:counts.total == 0 ? '' : printf('×%d', l:counts.total)
	endfunction

	function! LightlineLinterWarnings() abort
		let l:counts = ale#statusline#Count(bufnr(''))
		let l:all_errors = l:counts.error + l:counts.style_error
		let l:all_non_errors = l:counts.total - l:all_errors
		return l:counts.total == 0 ? '' : '⚠ ' . printf('%d', all_non_errors)
	endfunction

	function! LightlineLinterErrors() abort
		let l:counts = ale#statusline#Count(bufnr(''))
		let l:all_errors = l:counts.error + l:counts.style_error
		return l:counts.total == 0 ? '' : '✖ ' . printf('%d', all_errors)
	endfunction

	function! LightlineLinterOk() abort
		let l:counts = ale#statusline#Count(bufnr(''))
		return l:counts.total == 0 ? 'OK' : ''
	endfunction

	function! LightlineGitBranch()
		return '' . (exists('*fugitive#head') ? fugitive#head() : '')
	endfunction

	augroup alestatus
		autocmd User ALELint call lightline#update()
	augroup end
"}

" NERDTree settings {
	" Use a single click to fold/unfold directories and a double click to open files
	let g:NERDTreeMouseMode =2

	" Show hidden files
	let g:NERDTreeShowHidden =1

	" Show the bookmarks table on startup
	let g:NERDTreeShowBookmarks =1

	" Quit on opening files from the tree
	let g:NERDTreeQuitOnOpen =1

	" Disable uncommon file extensions highlighting
	let g:NERDTreeLimitedSyntax =1

	" Custom git status symbol
	let g:NERDTreeIndicatorMapCustom ={
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"}
"}

" Indent Guide settings {
	" To create skinny indent guides
	let g:indent_guides_guide_size =1

	" Auto colorscheme
	if &g:background ==# "dark"
		augroup indent_guide_highlight
			autocmd!
			autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black
			autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
		augroup end
	else
		augroup indent_guide_highlight
			autocmd!
			autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=white
			autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=lightgrey
		augroup end
	endif
"}

" Signify settings {
	" Determine what VCS to check for
	let g:signify_vcs_list =[ 'git' ]	
"}

" Initialize plugin system
call plug#end()

" Mapping {
	" Change the mapleader from \ to ,
	let mapleader=","
	let maplocalleader="\\"

	" Thanks to Steve Losh for this liberating tip
	" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
	" Fix Vim’s horribly broken default regex “handling” by automatically inserting a \v before any string you search for
	nnoremap / /\v
	vnoremap / /\v
"}

" Colorscheme and final setup {
	" This call must happen after the plug#end() call to ensure
	" that the colorschemes have been loaded
	colorscheme nord

	" Colorscheme extra settings {
		" Can be enabled to support italic text
		let g:nord_italic =1

		" Enable to italicize all comments
		let g:nord_italic_comments =1

		" Increase comment contrast
		let g:nord_comment_brightness =12

		" Enables uniform activate- and inactive status lines
		let g:nord_uniform_status_lines =1

		" Uniform vim-diff background
		let g:nord_uniform_diff_background =1
	"}

	" Startup settings {
		" To run NERDTreeTabs on console vim startup
    	let g:nerdtree_tabs_open_on_console_startup =1

    	" To enable Indent Guide on startup by default
    	let g:indent_guides_enable_on_vim_startup =1
	"}
"}