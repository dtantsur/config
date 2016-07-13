function apy
    ag --py $argv
end

if test -f /usr/bin/vimx
    function vim
       /usr/bin/vimx $argv
    end
end

function fish_right_prompt
    if git status > /dev/null 2> /dev/null
        if test (git status --short -uno | wc -l) = 0
            echo -n (set_color green)
        else
            echo -n (set_color yellow)
        end

        if git show HEAD > /dev/null 2>&1
            git rev-parse --abbrev-ref HEAD
        else
            echo "---"
        end
    end
end

function fish_prompt
    set last_st $status

    set root_dir ~
    set curr_dir (pwd)
    set prog "import os.path; print os.path.relpath('$curr_dir', '$root_dir') if '$root_dir' in '$curr_dir' else '$curr_dir'"
    echo -n (set_color green)
    echo -n '['
    echo -n (python -c "$prog")
    echo -n ']'

    if test $last_st = 0
        echo -n (set_color green)
    else
        echo -n (set_color red)
    end
    echo '$ '
end
