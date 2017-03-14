# DON'T WRITE ANYTHING ABOVE THESE LINES!!
HISTSIZE=10000000
HISTFILESIZE=10000000000

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
    PATH=git-1.8.3/bin:$PATH
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

alias dothegert="export ERT_SHARE_PATH=~/ert/ert/share && cd ~/ert/ert/ && gert -v python ~/ert/snake_oil/snake_oil.ert"

alias rh6cxx="/opt/rh/devtoolset-3/root/usr/bin/g++"

# git aliases

alias st='git st'
alias gb='git branch'
alias co='git checkout'
alias ci='git commit'
alias m8='make -j8'


mate () {
    echo && echo checkmate && echo "$JOBS cores activated" && \
        pwd && echo && echo && \
        make -j$JOBS && \
        ctest3 -j$JOBS --output-on-failure
}

cmate() {
    cmake3 . && mate
}

warnsource () {
    echo "source SDP_bashrc"
    echo ""
    source SDP_bashrc
    echo ""
    sleep 0.3
}


export PATH=~/bin:~/usr/bin:$PATH

# LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/opm/opm-parser/build/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/opm/opm-output/build/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/statoil/SegyIO/build
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/ert/ert/build/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/private/pgdr/lib

# PYTHONPATH
PP=~/lib/python
PP=$PP:~/ert/ert-statoil/lib/python
PP=$PP:~/ert/ert/build/python
PP=$PP:~/ert/ert/build/lib/python
PP=$PP:~/ert/ert/build/lib/python2.7/site-packages
PP=$PP:~/opm/sunbeam/build/python
PP=$PP:~/statoil/fusd/build/python

if [ "$PYTHONPATH" != "" ] ; then
    export PYTHONPATH=$PP:$PYTHONPATH
else
    export PYTHONPATH=$PP
fi

export PYTHONSTARTUP=~/.pythonrc

export ERT_SHARE_PATH=~/ert/ert/share

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
    ssh rgsn10$xxx
}

alias c8='ctest -j8'
