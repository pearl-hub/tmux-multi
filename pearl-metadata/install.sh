
function post_install(){
    link_to_path "${PEARL_PKGDIR}/bin/tmux-multi"
}

function post_update(){
    post_install
}

function pre_remove(){
    unlink_from_path "${PEARL_PKGDIR}/bin/tmux-multi"
}
