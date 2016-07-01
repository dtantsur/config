function apy
    ag --py $argv
end

if test -f /usr/bin/vimx
    function vim
       /usr/bin/vimx $argv
    end
end

fish_vi_key_bindings
