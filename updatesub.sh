#! /bin/sh

# Uppdate submodule to latest master branch commit
updateSubmodules () {
    echo "Starting updateSubmodules function"
    git submodule update --remote
    return 0
    echo "updateSubmodules function completed"
}

# Push update chnages to working/parent tree
pushUpdates() {
    git add . 
    git commit -m "{DATE} Update submodules" #Would be nice if we get a list of updated submodules
    git push origin updateSubmodules:master
    echo "pushUpdates function completed"
}


git stash #to make sure there are no git changes in the git dir
git checkout -b updateSubmodules #create a new temp branch
updateSubmodules() #git submodule update --remote
echo The updateSubmodules function has a return value of $?
pushUpdates()
echo The pushUpdates function has a return value of $?
git branch -D updateSubmodules #delete temp branch
git stash pop #revert to previous git status

echo "Script Completed"
