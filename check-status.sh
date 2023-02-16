#! /bin/zsh
#



now=$(date '+%s')
previous=$(head -1 $DOTFILES/repo-status)
elapsed=`expr $now - $previous`
hour=10
# hour=3600

echo "time since check $now - $previous = $elapsed"

if [[ $elapsed -gt $hour ]] then 

echo $(date '+%s') > repo-status
echo $(date) >> repo-status

uncommitted=$(cd $DOTFILES && git status --short | grep -c "M\|A\|D\|R\|C")

echo $uncommitted

if [[ $uncommitted -gt 0 ]] then
		echo "uncommitted changes"
		echo "needs-commit" >> repo-status
else
		echo "clean"
fi


fi
