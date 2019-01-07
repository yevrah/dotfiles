# Show System Info - use neofect as it's aster
if hash neofetch 2>/dev/null; then
  neofetch
elif hash screenfetch 2>/dev/null; then
  screenfetch
fi
