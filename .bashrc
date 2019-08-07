# DON'T WRITE ANYTHING ABOVE THESE LINES!!
HISTSIZE=10000000
HISTFILESIZE=10000000000
HISTCONTROL="ignorespace"
export LC_TIME="nb_NO.utf8"
DATA=/private/pgdr/opm/opm-data
# .bashrc
HISTLINES=`wc -l .bash_history | cut -f 1 -d " "`
echo "$HISTLINES lines"
if [ $HISTLINES -lt 3000 ]; then
    echo "WARNING!  HISTORY SHRINKAGE DETECTED!"
fi

# use all but 1 cores
JOBS=$((`nproc`-1))
echo "You have $JOBS CPUs activated for HQ compilation hyperspeed"


# This script takes daily backup (uniq) of .bash_history and warns if the
# history file has shrunk below my personal preferred threshold, 3000 lines
~/bin/backup_history.sh


# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


## [[ "$name" =~ ^"$HOME"(/|$) ]] && name="~${name#$HOME}"

# export PS1='$(whoami)@$(hostname):$(pwd)$ '
export PS1='\[\e[1;32m\][\u@\h \w]\$\[\e[0m\] '


# proper git version
GIT_VERSION_RH7="1.8.3.1"
GIT_VERSION=`git --version | cut -f3 -d" "`
if [ $GIT_VERSION != $GIT_VERSION_RH7 ]; then
    PATH=/prog/sdpsoft/git-1.8.3/bin:$PATH
fi


# User specific aliases and functions
#alias lint='python -m pylint -E --extension-pkg-whitelist=numpy'

alias lrt="ls -lrt"
alias lrta="ls -lrta"
alias la="ls -lah"
alias cmake=cmake3
alias ccmake=ccmake3
alias ctest="ctest3 --output-on-failure --timeout 600"

alias cgrep="grep -rn --include=*.c   --include=*.cc    --include=*.cpp \
                      --include=*.hpp --include=*.h     --include=*.hh \
                      --exclude=*.o   --exclude=*.cmake --exclude=*.html \
                      --exclude-dir=build"

alias pygrep="grep -rn --include=*.py --exclude-dir=build"
alias cmakegrep="grep -rn --include=CMakeLists.txt --include=*.cmake --exclude-dir=build"


alias m8='make -j8'

# opm making

alias cdcommon='cd ~/opm/opm-common/build'
alias cdparser='cd ~/opm/opm-parser/build'
alias cdoutput='cd ~/opm/opm-output/build'
alias cdgrid='cd ~/opm/opm-grid/build'
alias cdmaterial='cd ~/opm/opm-material/build'
alias cdcore='cd ~/opm/opm-core/build'
alias cdsimulators='cd ~/opm/opm-simulators/build'
alias cdupscaling='cd ~/opm/opm-upscaling/build'

mate () {
    echo && echo checkmate && echo "$JOBS cores activated" && \
        pwd && echo && echo && \
        make -j$JOBS && \
        ctest3 -j$JOBS --output-on-failure
}

cmate() {
    cmake3 . && mate
}

buildall () {
    #warnsource
    PREALL_PWD=`pwd`
    cdcommon         && mate && \
        cdparser     && mate && \
        cdoutput     && mate && \
        cdgrid       && mate && \
        cdmaterial   && mate && \
        cdcore       && mate && \
        cdsimulators && mate && \
        cdupscaling  && mate && \
        cd $PREALL_PWD
}

alias cdewoms='cd ~/opm/ewoms/build'

alias cdecl='pushd ~/statoil/libecl/build'
alias cdres='pushd ~/statoil/libres/build'
alias cdert='pushd ~/statoil/ert/build'
alias cdertstatoil='pushd ~/ert/ert-statoil/build'
alias cdest='pushd ~/everest/everest'
alias cdcaro='pushd ~/everest/carolina'
alias cddako='pushd ~/everest/dakota'

masterall () {
    PREALL_PWD=`pwd`
    cdcommon         && git checkout master && \
        cdparser     && git checkout master && \
        cdoutput     && git checkout master && \
        cdgrid       && git checkout master && \
        cdmaterial   && git checkout master && \
        cdcore       && git checkout master && \
        cdsimulators && git checkout master && \
        cdupscaling  && git checkout master && \
        cd $PREALL_PWD
}

pullall () {
    PREALL_PWD=`pwd`
    cdcommon && git checkout master && git pull upstream master && \
        cdparser && git checkout master && git pull upstream master && \
        cdoutput && git checkout master && git pull upstream master && \
        cdgrid && git checkout master && git pull upstream master && \
        cdmaterial && git checkout master && git pull upstream master && \
        cdcore && git checkout master && git pull upstream master && \
        cdsimulators && git checkout master && git pull upstream master && \
        cdupscaling && git checkout master && git pull upstream master
    cd $PREALL_PWD
}


export PATH=~/bin:~/usr/bin:$PATH

# LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/opm/opm-parser/build/lib64
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/opm/opm-output/build/lib
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/statoil/SegyIO/build
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/statoil/libecl/build/install/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/statoil/libres/build/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/lib


# PYTHONPATH
PP=~/lib/python
PP=$PP:~/everest/seba/build/lib
PP=$PP:~/ert/ert-statoil/lib/python
PP=$PP:~/usr/local/lib/python2.7/site-packages
PP=$PP:~/everest/everest
PP=$PP:~/everest/carolina/build/lib.linux-x86_64-2.7
PP=$PP:~/statoil/fusd/build/python

if [ "$PYTHONPATH" != "" ] ; then
    export PYTHONPATH=$PP:$PYTHONPATH
else
    export PYTHONPATH=$PP
fi

export PYTHONSTARTUP=~/.pythonrc

export ERT_SHARE_PATH=~/ert/ert/share


### dakota & carolina
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/everest/dakota/build/install/lib:~/everest/dakota/build/install/bin
export PATH=$PATH:~/everest/dakota/build/install/bin


ntest () {
    ctest3 -V -R $1 --output-on-failure
}

makentest () {
    make -j$JOBS $1 && \
    ctest3 -R $1 -V --output-on-failure
}

linefrom () {
    filename=$1
    lineno=$2
    head -n $lineno $filename | tail -n 1
}

patience () {
    until timeout 3s $@
    do
    echo "stop trying to hit me and hit me"
    done
}

rgs() {
    xxx=`shuf -i1-9 -n1`
    ssh be-linrgsn10$xxx -X
}

alias c8='ctest -j8'

function calc() {
    python -c "from math import *;print(eval('$1'))"
}

function scicalc() {
    python -c "from math import *;import numpy as np;import pandas as pd;import scipy as sci;print(eval('$1'))"
}




alias cmakeecl="cmake -DCMAKE_INSTALL_PREFIX=~/usr/local \
-DCMAKE_PREFIX_PATH=~/usr/local \
-DCMAKE_C_FLAGS='-Werror=all' \
-DBUILD_TESTS=ON -DBUILD_PYTHON=ON -DINSTALL_ERT_LEGACY=ON \
-DBUILD_APPLICATIONS=ON -DSTATOIL_TESTDATA_ROOT=/d/proj/bg/enkf/ErtTestData .."

alias cmakeres="cmake -DCMAKE_INSTALL_PREFIX=~/usr/local \
-DCMAKE_PREFIX_PATH=~/usr/local \
-DCMAKE_MODULE_PATH=~/usr/local/share/cmake/Modules -DBUILD_SHARED_LIBS=ON \
-DBUILD_TESTS=ON -DBUILD_PYTHON=ON -DINSTALL_ERT_LEGACY=ON \
-DBUILD_APPLICATIONS=ON -DSTATOIL_TESTDATA_ROOT=/d/proj/bg/enkf/ErtTestData .."

alias cmakeert="cmake -DCMAKE_INSTALL_PREFIX=~/usr/local \
-DCMAKE_PREFIX_PATH=~/usr/local \
-DCMAKE_MODULE_PATH=~/usr/local/share/cmake/Modules -DBUILD_SHARED_LIBS=ON \
-DBUILD_TESTS=ON \
-DSTATOIL_TESTDATA_ROOT=/d/proj/bg/enkf/ErtTestData .."


function noproxy() {
    export http_proxy=""
    export https_proxy=""
    export ftp_proxy=""
    export socks_proxy=""
    export no_proxy=""
    echo "Nullify proxy settings"
}

function setproxy() {
    local statoil_proxy=http://www-proxy.statoil.no:80
    export http_proxy=$statoil_proxy
    export https_proxy=$statoil_proxy
    export ftp_proxy=$statoil_proxy
    export socks_proxy=$statoil_proxy
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
}

y () {
    echo "You're done ..."
}

function lastdiff() {
    git log $@ | tail -n 5
}

/project/res/bin/wlog pgdr-bashrc launch HISTLINES=$HISTLINES

function komodo() {
    export KOMODO=/project/res/si_dev/root
    export LD_LIBRARY_PATH=$KOMODO/lib:$KOMODO/lib64:$LD_LIBRARY_PATH
    export PATH=$KOMODO/bin:$PATH
    export BOOST_ROOT=$KOMODO
    echo "BOOST_ROOT=$KOMODO"
}




ENV_ROOT=/data/envs
function activate() {
    if [ ${1} = "--list" ]
    then
        ls $ENV_ROOT
        return 0
    else
        ENV=${ENV_ROOT}/${1}
        if [[ -d $ENV ]]
        then
            echo "Activating env" $ENV
            source ${ENV}/bin/activate
        else
            echo "No such env \"${1}\", use --list"
            return 1
        fi
    fi
    return 0
}

function venv() {
    ENV=${ENV_ROOT}/$2

    if [ $1 = "2" ]
    then
        CMD="virtualenv $ENV"
    elif [ $1 = "3" ]
    then
        CMD="python3 -m venv $ENV"
    else
        printf "Usage: venv 2|3 name"
        return 1
    fi
    if [[ -d $ENV ]]
    then
        printf "Environment exists, delete first\n"
        return 1
    fi
    $CMD || (printf "\nError constructing env ${ENV}" && return 1)
    printf "Created ${2}, activating ...\n"
    activate ${2}
    printf "Activated ${2}, upgrading ...\n"
    pip install --upgrade pip
    pip install --upgrade ipython numpy pandas matplotlib
    printf "\nDone upgrading\n\n\n"
    python --version
    printf "\n"
    pip freeze
}
