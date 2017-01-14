# @Author: jonathan
# @Date:   2017-01-13 17:03:42
# @Last Modified by:   Jonathan Livingstone
# @Last Modified time: 2017-01-14 19:06:31

RELEASE=false

VERSION=1

pushd build
if [ "$RELEASE" = "true" ]; then
    nvcc -o "Demo""$VERSION" "../code/demo""$VERSION"".cu"
else
    nvcc -o "Demo""$VERSION" -g -G "../code/demo""$VERSION"".cu"
fi
popd
