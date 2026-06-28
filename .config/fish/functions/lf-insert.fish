function lf-insert
    set -l tmp (mktemp)
    lf -selection-path=$tmp
    if test -s $tmp
        commandline -i (cat $tmp)
    end
    rm -f $tmp
    commandline -f repaint
end
