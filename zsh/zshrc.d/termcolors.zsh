function termcolor_rgb () {
    echo -ne '%{\033[38;2;22;44;99m%}'
}

function termcolor_default () {
    echo -ne '%{\033(B\033[m%}'
}
