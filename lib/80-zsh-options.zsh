# Changing directories
opts=(
    AUTO_CD AUTO_PUSHD CDABLE_VARS PUSHD_IGNORE_DUPS # Change direcories
    # Completions
    BAD_PATTERN EXTENDED_GLOB # Expansion and globbing
    HIST_FIND_NO_DUPS # History
)
for e ($opts); do
    setopt $e
done

