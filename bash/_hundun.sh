alias sshdev='expect ~/scripts/sshdev.exp'
alias sshtest='expect ~/scripts/sshtest.exp'
alias sshtest1='expect ~/scripts/sshtest1.exp'
alias mysqlconn='mysql -h 127.0.0.1 -P 16033 -u dever -pdever course'
alias git-lastest-tag='git describe --tags `git rev-list --tags --max-count=1`'
alias cdprj='cd /Users/regod/Desktop/hundun/project'
alias rsync-dev='sh ~/scripts/rsync_dev.sh'

function hdenv(){
    if [ "x$1" == "x" ]; then
        cd ~/Desktop/hundun/envs
        return
    fi
    source ~/Desktop/hundun/envs/$1/bin/activate
    if [ "x$2" != "xnocd" ];then
        hdcd $1
    fi
}
function hdcd(){
    cd /Users/regod/project/hundun/$1
}

function testcd(){
    builtin cd $1
}
function act(){
    if [ "x$1" == "x" ];then
        prj_path=`pwd`
        prj_name=`basename $prj_path`
    else
        prj_name=$1
    fi
    source ~/Desktop/hundun/envs/$prj_name/bin/activate
}
