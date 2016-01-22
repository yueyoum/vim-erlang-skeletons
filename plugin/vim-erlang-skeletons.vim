if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

let s:plugin_dir = expand('<sfile>:p:h')
if !exists("g:erl_tpl_dir")
    let g:erl_tpl_dir=s:plugin_dir . "/templates"
endif

function! LoadTemplate(tpl_file)

python << EOF

import vim
import os

tpl_dir = vim.eval("g:erl_tpl_dir")
tpl_file = vim.eval("a:tpl_file")
tpl = os.path.join(tpl_dir, tpl_file)
with open(tpl, "r") as f:
    output = f.read()

vim.current.buffer.append(output.split("\n"), 0)
vim.command("set filetype=erlang")

EOF

endfunction

command! -nargs=0 ErlServer      call LoadTemplate("gen_server")
command! -nargs=0 ErlFsm         call LoadTemplate("gen_fsm")
command! -nargs=0 ErlSupervisor  call LoadTemplate("supervisor")
command! -nargs=0 ErlEvent       call LoadTemplate("gen_event")
command! -nargs=0 ErlApplication call LoadTemplate("application")
command! -nargs=0 ErlCTSuite     call LoadTemplate("commontest")
command! -nargs=1 ErlTemplate    call LoadTemplate(<args>)

