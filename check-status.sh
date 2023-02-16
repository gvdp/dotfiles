#! /bin/zsh
#

now=$(date '+%s')
previous=$([[ -e $DOTFILES/repo-status ]] && head -1 $DOTFILES/repo-status || echo 0)
elapsed=`expr $now - $previous`
# interval=10
interval=3600


if [[ $elapsed -gt $interval ]] then 

echo $(date '+%s') > repo-status
echo $(date) >> repo-status

uncommitted=$(cd $DOTFILES && git status --short | grep -c "M\|A\|D\|R\|C")
# uncommitted=0

echo $uncommitted

if [[ $uncommitted -gt 0 ]] then
		echo "there are uncommitted changes in the dotfiles repo"
		echo "needs-commit" >> repo-status
else
		notPulledChanges=$(cd $DOTFILES && git status | grep -c "is behind")
		
		if [[ $notPulledChanges -gt 0 ]] then
				# todo: also prompt for immediately pulling
				echo "there are unpulled changes in the dotfiles repo"
		fi
fi


fi
