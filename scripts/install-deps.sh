tmpdir=`mktemp -d`

scriptdir=$(cd $(dirname $0); pwd -P)
sourcedir=$(cd $scriptdir/..; pwd -P)
. $scriptdir/shlibs/os.sh

# TODO: This directory should be OS specific
if [ ! -d /usr/local/include/mcl ]; then
(
    cd $tmpdir
    git clone https://github.com/srishtfateh/mcl.git
    cd mcl/
    #git checkout a811618a194beb8e56c6fd8a45a698baf55492ef #herumi/mcl v1.35
    cmake -S . -B build -DCMAKE_BUILD_TYPE=Release #-MCL_USE_OMP=1
    cmake --build build
    sudo cmake --build build --target install
    if [ "$OS" == "Linux" ]; then
        sudo ldconfig
    fi
)
fi

#(
#    cd $sourcedir/
#    GOPATH=$sourcedir go get github.com/stretchr/testify/assert
#    GOPATH=$sourcedir go get github.com/Sirupsen/logrus
#    GOPATH=$sourcedir go get github.com/dustin/go-humanize
#)
