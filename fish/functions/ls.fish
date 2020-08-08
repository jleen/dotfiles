function ls
    if ! which exa > /dev/null
        /bin/ls $argv
        return
    end

    switch $argv[1]
        case '-l'
            exa -l $argv[2..-1]
        case '-a'
            exa -a $argv[2..-1]
        case '-la'
            exa -la $argv[2..-1]
        case '-*'
            /bin/ls $argv
        case '*'
            exa $argv[2..-1]
    end
end
