function cd
    if count $argv >/dev/null
        builtin cd "$argv"; and l
    else
        builtin cd ~; and l
    end
end
