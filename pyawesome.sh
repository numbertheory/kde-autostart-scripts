#!/usr/bin/env bash
#
#  Wrapper of virtualenvwrapper to work nicely with pyenv
#
#  Put this script in the path, and simply run. You will be prompted
#  to choose your python version from a dynamically generated menu of
#  python versions installed by pyenv.
#
#  After creation, the script exits. The user does have to then Activate
#  the environment with the `workon` command, as it won't be available to
#  the current session.


source virtualenvwrapper.sh

# Function to check if a command is available
check_command() {
    command -v "$1" >/dev/null 2>&1 || { 
        echo "$1 is not installed. Exiting."
        exit 1
    }
}

check_command "pyenv"
check_command "fzf"

# Get the list of installed Python versions using pyenv
versions=$(pyenv versions --bare)

# Check if there are any versions available
if [ -z "$versions" ]; then
    echo "No Python versions found. Please install a version using pyenv."
    exit 1
fi

# Add a Cancel option to the list
options=()
while IFS= read -r version; do
    options+=("$version")
done <<< "$versions"
options+=("Cancel")


# Use fzf to select a version
selected_version=$(printf "%s\n" "${options[@]}" | fzf --height 20% --reverse --no-border --no-input --header "Select a Python Version (Use arrow keys to navigate, Enter to select)")

# Check if a version was selected
if [[ "$selected_version" == "Cancel" ]]; then
    echo "Goodbye."
    exit 0
elif [[ -n "$selected_version" ]]; then
    echo "Creating Python Virtual Environment with $selected_version"
    echo "Name the new environment:"
    read venv_name
    mkvirtualenv --python="$HOME/.pyenv/versions/${selected_version}/bin/python" $venv_name
    echo "Successfully created new environment, $venv_name (Python $selected_version)"
    echo "========"
    echo "Activate with this command: \`workon $venv_name\`"
    echo "========"
else
    echo "No version selected."
fi
