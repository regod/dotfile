
alias cdprj='cd /Users/regod/projects/gengmei'
function act(){
    if [ "x$1" == "x" ];then
        prj_path=`pwd`
        prj_name=`basename $prj_path`
    else
        prj_name=$1
    fi
    act_bin=~/envs/gengmei/$prj_name/bin/activate
    [ -f $act_bin ] && source $act_bin
}

function make_env() {
    if [ "x$1" == "x" ];then
        prj_path=`pwd`
        prj_name=`basename $prj_path`
    else
        prj_name=$1
    fi

    env_path=~/envs/gengmei/$prj_name
    virtualenv $env_path
    act
}

function make_env_py3() {
    if [ "x$1" == "x" ];then
        prj_path=`pwd`
        prj_name=`basename $prj_path`
    else
        prj_name=$1
    fi

    env_path=~/envs/gengmei/$prj_name
    pyvenv $env_path
    act
}

function cd() {
    builtin cd $1
    prj_path=`pwd`
    prj_name=`basename $prj_path`
    prj_dir=`dirname $prj_path`
    if [ ${prj_dir:0-16} == "projects/gengmei" ];then
        deactivate >/dev/null 2>&1
        act
    fi
}
