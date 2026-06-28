#!/bin/bash
# Skrypt integracyjny lf z Tmux Popup

# 1. Pobierz target pane z pierwszego argumentu lub zmiennej środowiskowej
TARGET_PANE="${1:-$TMUX_PANE}"

# 2. Jeśli puste, zapytaj serwer tmux bezpośrednio o aktywny panel
if [ -z "$TARGET_PANE" ]; then
    TARGET_PANE=$(tmux display-message -p '#{pane_id}' 2>/dev/null)
fi

# 3. Jeśli nadal nie wykryto panelu docelowego, wyjdź
if [ -z "$TARGET_PANE" ]; then
    echo "Błąd: Nie można wykryć docelowego panelu Tmux." >&2
    exit 1
fi

tmp=$(mktemp)

# Uruchomienie lf i zapisanie wyboru do pliku tymczasowego
lf -selection-path="$tmp"

if [ -s "$tmp" ]; then
    escaped_files=""
    # Pętla obsługująca linie również w przypadku braku znaku nowej linii na końcu pliku (EOF)
    while IFS= read -r line || [ -n "$line" ]; do
        # Zabezpiecz spacje i znaki specjalne w ścieżce (shell escape)
        escaped_line=$(printf "%q" "$line")
        escaped_files="$escaped_files $escaped_line"
    done < "$tmp"
    
    # Wyślij sformatowane ścieżki do pierwotnego panelu tmux
    tmux send-keys -t "$TARGET_PANE" "${escaped_files# }"
fi

rm -f "$tmp"
