#! /bin/sh

# Uppdate submodule to latest master branch commit
function updateSubmodules () {
    echo "Entering updateSubmodules function"
    git submodule update --remote
    #return 0
    echo "Exiting updateSubmodules function"
}

# Push updated changes to working/parent tree
function pushUpdates() {
    echo "Entering pushUpdates function"
    git add . 
    git commit -m "$(date): Update submodules"
    git push origin updateSubmodules:master
    echo "Exiting pushUpdates function"
}

# #Check if submodule has changes
function checkSubmodulesChanges() {
   echo "Entering checkSubmodulesChanges function"
   touch tmp.txt
   #sed 1d tmp.txt > tmp.txt
   git submodule status > tmp.txt
   count=`grep -o -i "+" tmp.txt| wc -l`
   #return count
   rm tmp.txt
   echo "Exiting checkSubmodulesChanges function"
}

# Temp branch for checkout instead of using master branch
function tempBranch() {
   echo "Entering tempBranch function"
   exists=`git show-ref refs/heads/temp`
   if [ -n "$exists" ]; then
      echo 'branch exists!'
      git checkout temp
      git add .
      git commit -m "necessary"
   else
      git checkout -b temp
      git add .
      git commit -m "necessary"
    fi
   echo "Exiting tempBranch function"
}

# Temp branch for checkout instead of using master branch
function updateSubmodules() {
   echo "Entering updateSubmodules function"
   exists=`git show-ref refs/heads/updateSubmodules`
   if [ -n "$exists" ]; then
      echo 'branch exists!'
      git checkout updateSubmodules
   else
      git checkout -b updateSubmodules
   fi
   echo "Exiting updateSubmodules function"
}


git stash
git submodule init
updateSubmodules
#git checkout -b updateSubmodules
updateSubmodules
#echo The updateSubmodules function has a return value of $?
checkSubmodulesChanges
echo $count
if [ $count != 0 ];
  then
    pushUpdates
    #git reset --hard
    tempBranch
    git branch -D updateSubmodules
    #git submodule update
    #git push origin --delete updateSubmodules
    git stash pop

 else
    echo "Submodules does not have any changes"
    #git reset --hard HEAD^
    #git reset --hard
    tempBranch
    git branch -D updateSubmodules
    #git submodule update
    #git push origin --delete updateSubmodules
    git stash pop
fi

echo "Script Completed"

