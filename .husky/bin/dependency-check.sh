#!/bin/bash

# --- macOS PHP Loader (Homebrew) ---
# On macOS, GUI Git clients (Sourcetree, Tower) launch hooks with a stripped
# PATH that excludes PHP installed via Homebrew. This block restores
# Homebrew's bin directory so that the php binary is available to the hook.
# On Linux and Windows, neither branch will match and the block is skipped.

# Primary: if the brew command is itself in PATH (Intel macOS, or macOS where
# Homebrew is already partially visible), resolve the prefix dynamically.
if command -v brew >/dev/null 2>&1; then

	BREW_PREFIX="$(brew --prefix)"
	export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"

# Fallback: Apple Silicon macOS installs Homebrew at /opt/homebrew, which is
# not in the stripped PATH. Add it directly when brew cannot be found via PATH.
elif [ -d "/opt/homebrew/bin" ]; then

	export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

fi

# --- PHP Version Check ---
# Verify that PHP installed via Homebrew (macOS) or the system package manager
# (Linux) meets the minimum version declared in .php-version.

if [ -f ".php-version" ]; then

	# Define PHP_VERSION_REQUIRED
	# Read the minimum required PHP version from the project's .php-version file.
	PHP_VERSION_REQUIRED=$(cat .php-version)

	# Define PHP_VERSION_CURRENT
	# Get the full version string from the PHP runtime currently in PATH.
	PHP_VERSION_CURRENT=$(php -r "echo PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION . '.' . PHP_RELEASE_VERSION;")

	# Define PHP_VERSION_OK
	# Use PHP's built-in version_compare() to check if the current version
	# satisfies the minimum requirement.
	PHP_VERSION_OK=$(php -r "echo version_compare('$PHP_VERSION_CURRENT', '$PHP_VERSION_REQUIRED', '>=') ? 'yes' : 'no';")

	# Check if the PHP version is acceptable.
	# If the current version is below the minimum, print an error and exit.
	if [ "$PHP_VERSION_OK" != "yes" ]; then

		echo ""
		echo "ERROR: PHP $PHP_VERSION_REQUIRED or higher is required (found PHP $PHP_VERSION_CURRENT)."
		echo "On macOS, upgrade PHP installed via Homebrew: brew upgrade php"
		echo ""
		exit 1

	fi

fi

# --- NVM Loader ---
# Load nvm if it's installed (for GUI Git clients).

# Define NVM_DIR
# Set the path to the nvm directory.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Check if .nvmrc exists.
# Explicitly use the project's node version if .nvmrc exists.
if [ -f ".nvmrc" ]; then

	# Define NODE_VERSION_RC
	# Read the version string from the .nvmrc file.
	NODE_VERSION_RC=$(cat .nvmrc)

	# Define NODE_VERSION_TARGET
	# Resolve the .nvmrc version to a specific installed version.
	NODE_VERSION_TARGET=$(nvm version "$NODE_VERSION_RC")

	# Define NODE_VERSION_CURRENT
	# Get the currently active node version.
	NODE_VERSION_CURRENT=$(nvm current)

	# Check if the target version differs from the current version.
	# If they are different, switch to the target version.
	if [ "$NODE_VERSION_TARGET" != "$NODE_VERSION_CURRENT" ]; then

		nvm use

	fi

fi
