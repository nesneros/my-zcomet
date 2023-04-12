ZSHZ_SOURCE=$(which zshz)

if [[ "$ZSHZ_SOURCE" == "zshz not found" ]];then
    unset ZSHZ_SOURCE
else 
    export ZSHZ_SOURCE
fi
