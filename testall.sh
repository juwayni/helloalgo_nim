
# Find all .nim files in chapter directories
SRC_PATHS=$(ls chapter_*/*.nim 2>/dev/null | sort)
ERRORS=()
SUCCESS_COUNT=0
TOTAL_COUNT=0

for SRC_PATH in $SRC_PATHS; do
    ((TOTAL_COUNT++))
    
    # Get that directory and filename
    DIR_NAME=$(dirname "$SRC_PATH")
    FILE_NAME=$(basename "$SRC_PATH")

    echo "Testing: $SRC_PATH"

    # Move to the child directory, run nim to test if they compile, then move back (cd ..)
    if (cd "$DIR_NAME" && nim c -r --hints:off "$FILE_NAME" > /dev/null 2>&1); then
        ((SUCCESS_COUNT++))
    else
        echo "FAILED: $SRC_PATH"
        ERRORS+=("Error in $SRC_PATH")
    fi
done

echo "------------------------------------"
echo "Tested $TOTAL_COUNT files"
echo "Found exceptions in ${#ERRORS[@]} files"

if [ ${#ERRORS[@]} -ne 0 ]; then
    exit 1
fi
