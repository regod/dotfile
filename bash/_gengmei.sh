
alias cdprj='cd /Users/regod/projects/gengmei'
function act(){
    if [ "x$1" == "x" ];then
        prj_path=`pwd`
        prj_name=`basename $prj_path`
    else
        prj_name=$1
    fi
    source ~/envs/gengmei/$prj_name/bin/activate
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
