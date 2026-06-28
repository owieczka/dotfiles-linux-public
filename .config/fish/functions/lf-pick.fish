function lf-pick
    set -l tmp (mktemp)
    lf -selection-path=$tmp
    if test -s $tmp
        cat $tmp
    end
    rm -f $tmp
end
