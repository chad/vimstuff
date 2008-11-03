map <leader>t :FuzzyFinderTextMate<CR>
" ~/.vimrc
" Marcel Molina Jr. <marcel@vernix.org>

" Options
set expandtab
set nocompatible        " vim settings rather than vi settings
set bs=2                " always allow backspacing in insert mode
set sw=2                " number of spaces to use for auto indent
set textwidth=79        " maximum line width
set wrap
set scrolloff=1         " minimum lines between cursor and window edge
set ic                  " ignores case in searches
set incsearch           " searches as you type
set smartcase           " match 'word' case-insensitive / 'Word' case-sensitive
set showmatch           " shows matching parenthesis, bracket, or brace
set showcmd             " show commands while they're being typed
set ruler               " always display cursor
set background=dark     " essentially makes highlighting all bold
set pastetoggle=<F9>    " toggles between paste and nopaste mode
set ai                  " set autoindenting on
set laststatus=2        " Always display a status line at the bottom of the window 
set tabstop=2           " tabs is 4 spaces
"set softtabstop=4       " 4-space tabs
set nosmartindent
"only turn on cindent if it's a c file...
"set cindent
set showmode            " displays mode in status line
filetype on
filetype indent on
filetype plugin on

map <F3> ggg?G          " rot-13 for obfuscation
map <F12> <C-W>w

" 'Paste' from clipboard.
map <m-s-p> "*p

" 'Copy' to clipboard.
map <m-s-y> "*Y
vmap <m-s-y> "*y

" 'Cut' to clipboard.
map <m-s-x> "*x
vmap <m-s-x> "*x

" Tab completion!
function InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction 
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Timestamp in status-lin
"set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

" Toggle search result highlighting
map <F4> :set nohls!<CR>:set nohls?<CR>

" turn tabs into spaces
map <ESC>t :%! expand -t2<CR>
" run perltidy on entire file
map <ESC>p :%!perltidy -ce -t<CR>

" If the terminal has colors turn on syntax highlighting
" Highlight the most recent search pattern
if &t_Co > 2 || has("gui_running")
  syntax on
  " set hlsearch
endif

" This filetype plugin lets man pages open from within vim
" :Man <command> will now be opened inside of a window in vim
source $VIMRUNTIME/ftplugin/man.vim

" ri-ruby.vim
let ri_unfold_nonunique = 'on'

" tag list plugin
let Tlist_Ctags_Cmd = '/usr/bin/ctags-exuberant'

" tag explorer plugin
nnoremap <silent> <F8> :TagExplorer<CR>
let TE_Use_Right_Window = 0 " make 1 if you want it on the right 
let TE_WinWidth = 30 
" let TE_Exclude_File_Pattern = '^\.'
" let TE_Exclude_Dir_Pattern = '^\.'

" highlight the whitespace characters at end of line if not in insert mode
" highlight RedundantSpaces ctermbg=red guibg=red
" match RedundantSpaces /\s\+$\| \+\ze\t/

" If vim is compiled with autocommands add some bells and whistles
if has("autocmd")

    augroup filetypedetect
      au! BufRead,BufNewFile *.rhtml      setfiletype eruby
    augroup END

    au Filetype html,xml,xsl,pml source ~/.vim/scripts/closetag.vim
    au Filetype pml source ~/.vim/scripts/recipes.vim

    " add all ruby goodness
    "au FileType ruby source ~/.vim/ruby/ruby.vim
    "au FileType ruby source ~/.vim/ruby/ruby-menu.vim
    "au FileType ruby source ~/.vim/ruby/ruby-macros.vim
    "au FileType ruby source ~/.vim/ruby/ri.vim
    "au FileType ruby source ~/.vim/ruby/ruby-block-conv.vim

    " set K (documentation) to perldoc -f for perl files
    au FileType perl set kp=perldoc\ -f

    " set K (documentation) to pydoc for python files
    " take care of tab spaces issue
    au FileType python set kp=pydoc
    au FileType python set tabstop=4|set shiftwidth=4|set expandtab
    
    " set K (documetation) to ri for ruby files
    au FileType ruby set kp=ri
    au FileType ruby set tabstop=2|set shiftwidth=2|set expandtab
    
    " set K (documentation) to php.net page via links
    au FileType php set kp=phpdoc

    " YAML doesn't like tabs so let's not let them happen
    au BufEnter *.yaml set tabstop=2|set shiftwidth=2|set expandtab
    au BufEnter *.yml set tabstop=2|set shiftwidth=2|set expandtab

    au BufEnter *.rhtml source ~/.vim/ruby/ruby-macros.vim

    " Misc script header function
    fun! <SID>ScriptHeader(lang)
        call setline(1, "#!/usr/bin/" . a:lang)
        call append(1, "")
    endfun

    " Call header function on listed file types
    " XXX: could use BufNewFile if BufEnter is too inclusive
    au BufEnter *.py if getline(1) == "" | call s:ScriptHeader("python") | endif
    au BufEnter *.pl if getline(1) == "" | call s:ScriptHeader("perl")   | endif
    au BufEnter *.rb if getline(1) == "" | call s:ScriptHeader("ruby")   | endif

    " Shell header
    fun! <SID>ShellHeader()
        call setline(1, "#!/bin/sh")
        call append(1, "")
    endfun

    au BufEnter *.sh if getline(1) == "" | call s:ShellHeader() | endif

    " automatically give executable permissions based on file extension
    " au BufWritePost *.\(?:sh\|py\|pl\|rb\) :silent !chmod a+x <afile>

    " automatically give executable permissions if file begins with shebang
    " causes weirdness when saving with :w
    " au BufWritePost * if getline(1) =~ '^#!/\(usr/\)\?bin/\(\(.\{1,2}\)\?sh\|python\|perl\|ruby\)' | silent !chmod a+x <afile> | endif

endif " has("autocmd")

" Abbreviations
ab ubpy #!/usr/bin/python
ab ubpl #!/usr/bin/perl
ab bsh #!/bin/sh
ab ubr #!/usr/bin/ruby

ab comline #-----------------------------------------------------------------------------#
ab shortcomline #---------------------------------------

" fix spelling retardation
ab accesories accessories
ab accomodate accommodate
ab acheive achieve
ab acheiving achieving
ab acn can
ab acommodate accommodate
ab acomodate accommodate
ab adn and
ab agian again
ab ahppen happen
ab ahve have
ab allready already
ab almsot almost
ab alot a lot
ab alreayd already
ab alwasy always
ab amke make
ab anbd and
ab andthe and the
ab appeares appears
ab aplyed applied
ab artical article
ab audeince audience
ab audiance audience
ab awya away
ab bakc back
ab balence balance
ab baout about
ab bcak back
ab beacuse because
ab becasue because
ab becomeing becoming
ab becuase because
ab becuse because
ab befoer before
ab begining beginning
ab behaviour behavior
ab beleive believe
ab boxs boxes
ab bve be
ab changeing changing
ab charachter character
ab charecter character
ab charector character
ab cheif chief
ab circut circuit
ab claer clear
ab claerly clearly
ab cna can
ab colection collection
ab comany company
ab comapny company
ab comittee committee
ab commitee committee
ab committe committee
ab committy committee
ab compair compare
ab compleated completed
ab completly completely
ab comunicate communicate
ab comunity community
ab conected connected
ab cotten cotton
ab coudl could
ab cpoy copy
ab cxan can
ab danceing dancing
ab definately definitely
ab develope develop
ab developement development
ab differant different
ab differnt different
ab diffrent different
ab disatisfied dissatisfied
ab doese does
ab doign doing
ab doller dollars
ab donig doing
ab driveing driving
ab drnik drink
ab ehr her
ab embarass embarrass
ab equippment equipment
ab esle else
ab excitment excitement
ab eyt yet
ab familar familiar
ab feild field
ab fianlly finally
ab fidn find
ab firts first
ab follwo follow
ab follwoing following
ab foriegn foreign
ab fro for
ab foudn found
ab foward forward
ab freind friend
ab frmo from
ab fwe few
ab gerat great
ab geting getting
ab giveing giving
ab goign going
ab gonig going
ab govenment government
ab gruop group
ab grwo grow
ab haev have
ab happend happened
ab haveing having
ab hda had
ab helpfull helpful
ab herat heart
ab hge he
ab hismelf himself
ab hsa has
ab hsi his
ab hte the
ab htere there
ab htey they
ab hting thing
ab htink think
ab htis this
ab hvae have
ab hvaing having
ab idae idea
ab idaes ideas
ab ihs his
ab immediatly immediately
ab indecate indicate
ab insted intead
ab inthe in the
ab iwll will
ab iwth with
ab jsut just
ab knwo know
ab knwos knows
ab konw know
ab konws knows
ab levle level
ab libary library
ab librarry library
ab librery library
ab librarry library
ab liek like
ab liekd liked
ab liev live
ab likly likely
ab littel little
ab liuke like
ab liveing living
ab loev love
ab lonly lonely
ab makeing making
ab mkae make
ab mkaes makes
ab mkaing making
ab moeny money
ab mroe more
ab mysefl myself
ab myu my
ab neccessary necessary
ab necesary necessary
ab nkow know
ab nwe new
ab nwo now
ab ocasion occasion
ab occassion occasion
ab occurence occurrence
ab occurrance occurrence
ab ocur occur
ab occuring occurring
ab oging going
ab ohter other
ab omre more
ab onyl only
ab optoin option
ab optoins options
ab opperation operation
ab orginized organized
ab otehr other
ab otu out
ab owrk work
ab peopel people
ab perhasp perhaps
ab perhpas perhaps
ab pleasent pleasant
ab poeple people
ab porblem problem
ab probelm problem
ab protoge protege
ab puting putting
ab pwoer power
ab quater quarter
ab questoin question
ab reccomend recommend
ab reccommend recommend
ab receieve receive
ab recieve receive
ab recieved received
ab recipie recipe
ab recipies recipes
ab recomend recommend
ab reconize recognize
ab recrod record
ab religous religious
ab rwite write
ab rythm rhythm
ab seh she
ab selectoin selection
ab sentance sentence
ab seperate separate
ab shineing shining
ab shiped shipped
ab shoudl should
ab similiar similar
ab smae same
ab smoe some
ab soem some
ab sohw show
ab soudn sound
ab soudns sounds
ab statment statement
ab stnad stand
ab stopry story
ab stoyr story
ab stpo stop
ab strentgh strength
ab struggel struggle
ab sucess success
ab swiming swimming
ab tahn than
ab taht that
ab talekd talked
ab tath that
ab teh the
ab tehy they
ab tghe the
ab thansk thanks
ab themselfs themselves
ab theri their
ab thgat that
ab thge the
ab thier their
ab thme them
ab thna than
ab thne then
ab thnig thing
ab thnigs things
ab thsi this
ab thsoe those
ab thta that
ab tihs this
ab timne time
ab tje the
ab tjhe the
ab tkae take
ab tkaes takes
ab tkaing taking
ab tlaking talking
ab todya today
ab tongiht tonight
ab tonihgt tonight
ab towrad toward
ab truely truly
ab tyhat that
ab tyhe the
ab useing using
ab veyr very
ab vrey very
ab waht what
ab watn want
ab wehn when
ab whcih which
ab whic which
ab whihc which
ab whta what
ab wief wife
ab wierd weird
ab wihch which
ab wiht with
ab windoes windows
ab withe with
ab wiull will
ab wnat want
ab wnated wanted
ab wnats wants
ab woh who
ab wohle whole
ab wokr work
ab woudl would
ab wriet write
ab wrod word
ab wroking working
ab wtih with
ab wya way
ab yera year
ab yeras years
ab ytou you
ab yuo you
ab yuor your
" days of weeks
ab monday Monday
ab tuesday Tuesday
ab wednesday Wednesday
ab thursday Thursday
ab friday Friday
ab saturday Saturday
ab sunday Sunday
