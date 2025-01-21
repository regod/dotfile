
alias cdprj='cd /Users/regod/projects/gengmei'
function act(){
    if [ "x$1" == "x" ];then
        prj_path=`pwd`
        prj_name=`basename $prj_path`
    else
        prj_name=$1
    fi
    act_bin=~/envs/gengmei/$prj_name/bin/activate
    if [ ! -f $act_bin ];then
        act_bin=`poetry env info --path`/bin/activate
    fi
    [ -f "$act_bin" ] && source $act_bin
}

function make_env() {
    if [ "x$1" == "x" ];then
        prj_path=`pwd`
        prj_name=`basename $prj_path`
    else
        prj_name=$1
    fi
    virtualenv_bin=~/.pyenv/versions/2.7.18/bin/virtualenv

    env_path=~/envs/gengmei/$prj_name
    $virtualenv_bin $env_path
    act
}

function make_env_py3() {
    if [ "x$1" == "x" ];then
        prj_path=`pwd`
        prj_name=`basename $prj_path`
    else
        prj_name=$1
    fi
    python3_bin=~/.pyenv/versions/3.6.10/bin/python3

    env_path=~/envs/gengmei/$prj_name
    $python3_bin -m venv $env_path
    act
}

function cd() {
    builtin cd "$1"
    prj_path=`pwd`
    prj_name=`basename "$prj_path"`
    prj_dir=`dirname "$prj_path"`
    if [ "${prj_dir:0-16}""x" == "projects/gengmeix" ];then
        deactivate >/dev/null 2>&1
        act
    fi
}
