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
    git pull origin master
<<<<<<< HEAD
    git add . 
=======
    git add .
>>>>>>> c0c3b93dd19923b7ad52e92c0d18467756fa7c53
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
<<<<<<< HEAD
      git commit -m "necessary"
   else
      git checkout -b temp
      git add .
      git commit -m "necessary"
=======
      git commit -m "$(date)"

   else
      git checkout -b temp
      git add .
      git commit -m "$(date)"
>>>>>>> c0c3b93dd19923b7ad52e92c0d18467756fa7c53
    fi
   echo "Exiting tempBranch function"
}

# Temp branch for checkout instead of using master branch
function subModulesBranch() {
   echo "Entering subModulesBranch function"
   exists=`git show-ref refs/heads/updateSubmodules`
   if [ -n "$exists" ]; then
      echo 'branch exists!'
      git checkout updateSubmodules
   else
      git checkout -b updateSubmodules
   fi
   echo "Exiting subModulesBranch function"
}


git stash
git submodule init
updateSubmodules
#git checkout -b updateSubmodules
subModulesBranch
#echo The updateSubmodules function has a return value of $?
checkSubmodulesChanges
echo $count
if [ $count != 0 ];
  then
    pushUpdates
    #git reset --hard
    tempBranch
<<<<<<< HEAD
    git branch -D updateSubmodules
=======
    #git branch -D updateSubmodules
>>>>>>> c0c3b93dd19923b7ad52e92c0d18467756fa7c53
    #git submodule update
    #git push origin --delete updateSubmodules
    git stash pop

 else
    echo "Submodules does not have any changes"
    #git reset --hard HEAD^
    #git reset --hard
    tempBranch
<<<<<<< HEAD
    git branch -D updateSubmodules
=======
    #git branch -D updateSubmodules
>>>>>>> c0c3b93dd19923b7ad52e92c0d18467756fa7c53
    #git submodule update
    #git push origin --delete updateSubmodules
    git stash pop
fi
<<<<<<< HEAD

=======
git branch -D updateSubmodules
>>>>>>> c0c3b93dd19923b7ad52e92c0d18467756fa7c53
echo "Script Completed"

