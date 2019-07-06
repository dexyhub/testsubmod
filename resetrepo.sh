#! /bin/sh
  
APP_PATH=$1
shift

if [ -z $APP_PATH ]; then
  echo "1st argument is missing: it should be path to TED_Portal folder of a git repo";
  exit 1;
fi

echo "Working in: $APP_PATH"
cd $APP_PATH

#is_branch_master=`ls -la | grep -q 'branch = master' '.gitmodules' && echo $?`
count=`grep -o -i "branch = master" .gitmodules | wc -l`

if [ $count = 3 ];
 then
    echo "Branch for validators already exist in .gitmodules file, proceeding to submodule update"
    git submodule update --remote
    echo "submodule update completed"
 else
    echo "Branch may not exist in .gitmodules file, adding master branch before submodule update"
    git config -f .gitmodules submodule.SubMod1.branch master
    git config -f .gitmodules submodule.SubMods/SubMod2.branch master
    git config -f .gitmodules submodule.SubMods/SubMod3.branch master
    echo "Performing submodule update..."
    git submodule update --remote
    echo ".gitmodule file and submodule update completed"
fi

echo "Script Completed"
