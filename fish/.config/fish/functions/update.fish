function update -d "update brew, fish, fisher and OS"
    echo 'start updating ...'

    echo 'updating homebrew'
    brew update
    brew upgrade
    brew cleanup

    echo 'updating fish shell'
    fisher
    fish_update_completions

    switch (uname) 
    case Darwin
      echo 'checking Apple Updates'
      /usr/sbin/softwareupdate -ia
    case Linux
      echo 'no Linux updated configured'
    end

    exit 0
end
