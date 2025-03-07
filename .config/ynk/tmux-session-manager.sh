#!/bin/zsh

if [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then
    SESSIONS=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)

    BORDER_COLOR=$(tput setaf 4) 
    TITLE_COLOR=$(tput setaf 6)
    TEXT_COLOR=$(tput setaf 2)
    RESET=$(tput sgr0)
    BOLD=$(tput bold)
    #spaces should align, in theory.

echo ""
echo "${BOLD}${BORDER_COLOR}╭───────────────────────────────────────────╮${RESET}"
echo "${BOLD}${BORDER_COLOR}│ ${TITLE_COLOR}   Tmux Session Manager                   ${BORDER_COLOR}│${RESET}"
echo "${BOLD}${BORDER_COLOR}╰───────────────────────────────────────────╯${RESET}"
echo "${BOLD}${BORDER_COLOR}╭─────────────────────────────────────────────────╮${RESET}"
echo "${BOLD}${BORDER_COLOR}│ ${TEXT_COLOR}[1] Attach to an existing session              ${BORDER_COLOR} │${RESET}"
echo "${BOLD}${BORDER_COLOR}│ ${TEXT_COLOR}[2] Start a new session                        ${BORDER_COLOR} │${RESET}"
echo "${BOLD}${BORDER_COLOR}│ ${TEXT_COLOR}[3] Exit                                       ${BORDER_COLOR} │${RESET}"
echo "${BOLD}${BORDER_COLOR}╰─────────────────────────────────────────────────╯${RESET}"
echo ""

echo -n "${BOLD}Choose an option [1-3]: ${RESET}"
read OPTION
    case "$OPTION" in
        1)
            #check for an active session
            if [[ -n "$SESSIONS" ]]; then
            #check if fzf is installed, else use simpler version
                if command -v fzf >/dev/null 2>&1; then
                    SELECTED_SESSION=$(echo "$SESSIONS" | fzf --prompt="Select a Tmux session: " --height=10 --reverse)
                else
                    echo "Active sessions:"
                    echo "$SESSIONS"
                    echo -n "Enter session name to attach: "
                    read SELECTED_SESSION
                fi

                if [[ -n "$SELECTED_SESSION" ]]; then
                    tmux attach-session -t "$SELECTED_SESSION"
                else
                    echo "No session selected. Returning to shell."
                fi
            else
                echo "No active tmux sessions found."
            fi
            ;;
        2)
            echo -n "Enter new session name (or press Enter for default): "
            read NEW_SESSION
            tmux new-session -s "${NEW_SESSION:-default}"
            ;;
        3)
            echo "Returning to shell."
            return 0 
            ;;
        *)
            echo "Invalid option. Returning to shell."
            return 0
            ;;
    esac
fi
