# 1. config
```shell
git config --global https.proxy https://127.0.0.1:1080
git config --global user.name "xuwuruoshui"
git config --global user.email "1085252985@qq.com"
git config --global credential.helper store
```
# 2. change the orgin to other name
```shell
# add m78
git remote add m78 https://xxx.git
# rename
git remote rename xxx xxxx
# list remote repository's name
git remote
# delete origin
git remote rm origin
```
# 3. common commond
## 3.1 commit to local repository and syn remote repository
```shell
git add xxx

git commit xxx -m "description"

# del file 
rm xxx
git rm xxx

# make the file be untracked
git rm --cached xxxx

# rename file
git mv xxx xxxx

# log,-p to see diff
git log -p

#list Annotated Tags
git tag
# create Lightweight Tags
git tag -a version -m "descript"
# create
git tag version 

# back to last step(stage area)
# https://www.jianshu.com/p/199f584e5c50
git log
git reset --soft/mixed/hard id
# if you had pushed,you need
git revert id

# if you first push,you need to use it
git push -u m78 master

# otherwise,directly
git push
```
## 3.2 branch
```shell
# list all branch
git branch

# add a branch and switch to the new branch
git branch branch-name
git checkout branch-name

# you also can use the following command to replace
git checkout -b branch-name


# associate local branch with remote branch,to method:
git push -u origin branch-name
#if the remote branch is not exist,you coundn't use it
git branch -u origin/branch-name

# delete local branch and remote branch
git branch -d branch-name
git branch -r -d origin/branch-name  
git push origin :branch-name 


# rename branch
# If you are on the branch you want to rename
git branch -m new-name
# If you are on a different branch
git branch -m old-name new-name
# delete the old-name remote branch and push the new-name localbranch
git push origin :old-name new-name
# Reset the upstream branch for the new-name local branch.
# you need to switch to your new branch to run it
git push origin -u new-name

# merge the branch
# Now,if you are on the master branch, you want to merge the branch into the current branch
git merge branch-name
# If you want to merge a commit to master.First, get branch-name's log commitId,then switch to master,use "git cherry-pick commitId"
git checkout branch-name
git log
git checkout master
git git cherry-pick commitId
# fetch all remote branch to local branch
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all


```
# 4. other
```sh
# last commit before merging
git log --merges -n 1
```
