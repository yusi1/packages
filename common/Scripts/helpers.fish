#!/usr/bin/env fish
function __solus_package_dir
    realpath (dirname (readlink (status -f)))/../..
end

function __solus_toplevel
    git rev-parse --show-toplevel
end

function gotosoluspkgs -d "Go to the root of the Solus packages repository"
    cd (__solus_package_dir)
end

function goroot -d "Go to the root of the current Git repository"
    cd (__solus_toplevel)
end

function gotopkg -a package -d "Go to a package directory"
    cd (__solus_toplevel)/packages/*/$package
end

function localrepo_reindex -d "Re-index the local repo and update eopkg's cache"
    sudo eopkg index --skip-signing /var/lib/solbuild/local/ --output /var/lib/solbuild/local/eopkg-index.xml && \
    sudo eopkg update-repo
end

function whatprovides -a library -d "Show packages that provide a certain library"
    path basename (path dirname (grep $library (__solus_toplevel)/packages/*/*/abi_libs))
end

function whatuses -a library -d "Show packages that use a certain library"
    path basename (path dirname (grep $library (__solus_toplevel)/packages/*/*/abi_used_libs))
end

complete -c gotosoluspkgs -f
complete -c goroot -f
complete -c gotopkg -f
complete -c gotopkg -a "(path basename (__solus_toplevel)/packages/*/*)"
complete -c whatprovides -f
complete -c whatuses -f
