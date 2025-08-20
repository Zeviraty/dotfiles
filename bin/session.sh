sessions="$(tmux list-sessions -F '#S')"
session_output=""
current_session="$(tmux display-message -p '#S')"

for s in $sessions; do
    if [ "$s" = "$current_session" ]; then
        session_output="$session_output#[bg=#262626,fg=#608B4E]#[fg=#262626,bg=#608B4E] $s #[bg=#608B4E,fg=#262626]#[default]"
    else
        session_output="$session_output#[bg=#262626,fg=#3a3a3a]#[fg=#608B4E,bg=#3a3a3a] $s #[bg=#3a3a3a,fg=#262626]#[default]"
    fi
done

echo "$session_output"
