local old_path
old_path=($path)
path=()
for p in $old_path; do
    [[ $p != /mnt/c/* ]] && path+=$p
done
unset old_path
