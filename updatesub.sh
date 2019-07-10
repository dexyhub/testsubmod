#! /bin/sh

# Uppdate submodule to latest master branch commit
updateSubmodules () {
    echo "Entering updateSubmodules function"
    git submodule update --remote
    #return 0
    echo "Exiting updateSubmodules function"
}

# Push updated changes to working/parent tree
pushUpdates() {
    echo "Entering pushUpdates function"
    git add . 
    git commit -m "$(date): Update submodules"
    git push origin updateSubmodules:master
    echo "Exiting pushUpdates function"
}

# #Check if submodule has changes
checkSubmodulesChanges() {
   echo "Entering checkSubmodulesChanges function"
   touch tmp.txt
   sed 1d tmp.txt > tmp.txt
   git submodule status > tmp.txt
   count=`grep -o -i "+" tmp.txt| wc -l`
   #return count
   rm tmp.txt
   echo "Exiting checkSubmodulesChanges function"
}


git stash
git checkout -b updateSubmodules
updateSubmodules()
#echo The updateSubmodules function has a return value of $?
#Check if submodule has changes
checkSubmodulesChanges()
echo $count
if [ $count != 0 ];
  then
    pushUpdates()
    git checkout master
    git reset --hard
    git branch -D updateSubmodules
    git stash pop

 else
    echo "Submodules does not have any changes"
    git checkout master
    git branch -D updateSubmodules
    git stash pop
fi

echo "Script Completed"

