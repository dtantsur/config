set GOPATH "$HOME/.gopath"
set EDITOR "vim"

function apy
    ag --py $argv
end

if test -f /usr/bin/vimx
    function vim
       /usr/bin/vimx $argv
    end
end

function fish_prompt
    set last_st $status

    echo -n (set_color green)
    printf '%s' (prompt_pwd)

    if git status > /dev/null 2> /dev/null
        if test (git status --short -uno | wc -l) = 0
            echo -n (set_color blue)
        else
            echo -n (set_color yellow)
        end

        if git show HEAD > /dev/null 2>&1
            printf ' (%s)' (git rev-parse --abbrev-ref HEAD)
        end
    end

    if jobs -q
        echo -n (set_color brblack)
        printf ' %%%d' (jobs | tail -n +1 | wc -l)
    end

    if test $last_st = 0
        echo -n (set_color green)
    else
        echo -n (set_color red)
    end
    echo ' $ '
end
