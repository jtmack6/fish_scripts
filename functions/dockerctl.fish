function dockerctl --description "Manage Docker Desktop on macOS"
    # We want subcommands start, status, stop
    set subcommand $argv[1]

    switch $subcommand
        case start
            # Check if Docker is installed by trying to locate it
            if not open -Ra "Docker"
                echo "Docker.app is not installed or not found."
                return 1
            end

            # If Docker is already running, pgrep should find the Docker process
            if pgrep -x Docker >/dev/null
                echo "Docker Desktop is already running."
            else
                echo "Starting Docker Desktop..."
                open -a Docker
            end

        case status
            if pgrep -x Docker >/dev/null
                echo "Docker Desktop is running."
            else
                echo "Docker Desktop is NOT running."
            end

        case stop
            # Use AppleScript to gracefully quit Docker Desktop
            if pgrep -x Docker >/dev/null
                echo "Stopping Docker Desktop..."
                osascript -e 'quit app "Docker"'
            else
                echo "Docker Desktop is not running."
            end

        case '*'
            echo "Usage: dockerctl <start|status|stop>"
            return 1
    end
end
