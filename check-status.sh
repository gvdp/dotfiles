#! /bin/zsh
#

now=$(date '+%s')
previous=$([[ -e $DOTFILES/repo-status ]] && head -1 $DOTFILES/repo-status || echo 0)
elapsed=`expr $now - $previous`
interval=10
# interval=3600


if [[ $elapsed -gt $interval ]] then 

echo $(date '+%s') > $DOTFILES/repo-status
echo $(date) >> $DOTFILES/repo-status

uncommitted=$(cd $DOTFILES && git status --short | grep -c "M\|A\|D\|R\|C")
# uncommitted=0

echo $uncommitted

if [[ $uncommitted -gt 0 ]] then
		echo "there are uncommitted changes in the dotfiles repo"
		echo "needs-commit" >> $DOTFILES/repo-status
else
		notPulledChanges=$(cd $DOTFILES && git status | grep -ce "is behind" -ce "different")
		
		if [[ $notPulledChanges -gt 0 ]] then
				# todo: also prompt for immediately pulling
				echo "there are unpulled changes in the dotfiles repo"i
				read "pull?Pull changes?(Y/n)"
				echo $pull
				if [[ "$pull" =~ ^[Yy]$ ]] then
						$(cd $DOTFILES && git pull)
				fi
		fi
fi


fi
