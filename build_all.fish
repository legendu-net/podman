#!/usr/bin/env fish

argparse 'no-pull' 'no-push' 'no-cache' -- $argv
or exit

set script_dir (dirname (status filename))

for image in (grep -v '^\s*$' $script_dir/images.md)
    echo "==> Building $image"
    cd $script_dir/$image
    fish build.fish $_flag_no_pull $_flag_no_push $_flag_no_cache
    or exit
end
