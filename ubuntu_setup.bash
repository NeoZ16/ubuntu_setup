#!/bin/bash

BASE_DIR="$(dirname "${BASH_SOURCE[0]}")"
SCRIPTS_DIR="$BASE_DIR/scripts"

# Print logo
cat << 'EOF'
==============================================
      ____      _               
    / ___|  ___| |_ _   _ _ __  
    \___ \ / _ \ __| | | | '_ \ 
     ___) |  __/ |_| |_| | |_) |
    |____/ \___|\__|\__,_| .__/ 
                         |_|    
==============================================
EOF


# Function for user confirmation
confirm() {
    # Call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]|[cC][oO][nN][fF][iI][rR][mM]|[oO][kK]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

echo
echo ">> This setup performs automatic installation tasks that modify the Ubuntu system."
confirm ">> Please confirm to continue: " || exit

### Remove old log files
rm -f setup_output.log
rm -f setup_errors.log

### Supress apt output
sudo apt -y update >> setup_output.log 2>> setup_errors.log
sudo apt -y upgrade >> setup_output.log 2>> setup_errors.log

echo ">> Running custom installation routines..."
# Run for all bash scripts in subdirectories
for f in "$SCRIPTS_DIR"/*.bash; do
    
    # Search in script for a line "# SUMMARY This is a summary" and extract the first match
    SCRIPT_SUMMARY=$(grep "SUMMARY" "$f" | head -n 1 | sed -n -e "s/ *# *SUMMARY *\(.*\)/\1/p")
    
    echo
    
    # Check if there is a summary
    if [[ "$SCRIPT_SUMMARY" ]]; then
        if [[ "$f" =~ "install" ]]; then
            PROMPT_STRING="Install $SCRIPT_SUMMARY"
        else
            PROMPT_STRING="$SCRIPT_SUMMARY"
        fi
    else
        PROMPT_STRING="Executing script '$(basename $f)'"
    fi
    
    # Ask for user confirmation before running the script
    echo ">> [Setup] $SCRIPT_SUMMARY"
    echo ">> [Setup] $SCRIPT_SUMMARY" >> setup_output.log
    echo ">> [Setup] $SCRIPT_SUMMARY" >> setup_errors.log
    bash "$f" "$(realpath $(dirname "$f"))" >> setup_output.log 2>> setup_errors.log
done
