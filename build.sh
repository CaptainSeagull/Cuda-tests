# @Author: jonathan
# @Date:   2017-01-13 17:03:42
# @Last Modified by:   jonathan
# @Last Modified time: 2017-01-13 17:15:23

RELEASE=false

pushd build
if [ "$RELEASE" = "true" ]; then
    nvcc -o "Demo0" ../code/demo0.cu
else
    nvcc -o "Demo0" -g -G ../code/demo0.cu
fi
popd
