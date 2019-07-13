#! /bin/sh

# Uppdate submodule to latest master branch commit
function updateSubmodules () {
    echo "Entering updateSubmodules function"
    git submodule update --remote
    echo "Exiting updateSubmodules function"
}

# Create and/or checkout updateSubmodules branch
function subModulesBranch() {
   echo "Entering subModulesBranch function"
   exists=`git show-ref refs/heads/updateSubmodules`
   if [ -n "$exists" ]; then
      echo 'updateSubmodules branch exists!'
      git checkout updateSubmodules
   else
      git checkout -b updateSubmodules
   fi
   echo "Exiting subModulesBranch function"
}

# #Check if submodule has changes
function checkSubmodulesChanges() {
   echo "Entering checkSubmodulesChanges function"
   touch tmp.txt
   git submodule status > tmp.txt
   modifiedSub=`grep -o -i "+" tmp.txt| wc -l`
   rm tmp.txt
   echo "Exiting checkSubmodulesChanges function"
}

# Push updated changes to working/parent tree
function pushUpdates() {
    echo "Entering pushUpdates function"
    git pull origin master
    git add .
    git commit -m "$(date): Update submodules"
    #git push origin updateSubmodules:master
    git push origin updateSubmodules
    echo "Exiting pushUpdates function"
}

# Workaround to use Temp branch for checkout instead of using master branch
function tempBranch() {
   echo "Entering tempBranch function"
   exists=`git show-ref refs/heads/temp`
   if [ -n "$exists" ]; then
      echo 'temp branch exists!'
      git checkout temp
   else
      git checkout -b temp
   fi
   git add .
   git commit -m "$(date)"
   echo "Exiting tempBranch function"
}

git stash
git submodule init
updateSubmodules
subModulesBranch
checkSubmodulesChanges
echo $modifiedSub
if [ $modifiedSub != 0 ];
  then
    pushUpdates
fi
tempBranch
git stash pop
git branch -D updateSubmodules
echo "Script Completed"
