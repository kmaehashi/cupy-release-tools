#!/bin/bash -uex

# This script is expected to be called from Jenkins.
# The following environment variables expected to be set:
# - CUDA (CUDA verseion; 7.0, 7.5, etc. or sdist)
# - PYTHON (python version; 2.7.6, 3.6.0, etc.)
# This script also expects that `cupy` source tree exists in the same directory.

###
### Prepare NCCL assets
###

rm -rf nccl
mkdir -p nccl

HAVE_NCCL="yes"

case ${CUDA} in
  sdist )
    wget -O "nccl/nccl_2.1.4-1+cuda9.0_x86_64.txz" "https://s3-ap-northeast-1.amazonaws.com/pfn-internal-public/cupy/nccl_2.1.4-1%2Bcuda9.0_x86_64.txz"
    ;;
  7.0 )
    HAVE_NCCL="no"
    ;;
  7.5 )
    wget -O "nccl/libnccl1_1.2.3-1.cuda7.5_amd64.deb" "https://github.com/NVIDIA/nccl/releases/download/v1.2.3-1%2Bcuda7.5/libnccl1_1.2.3-1.cuda7.5_amd64.deb"
    wget -O "nccl/libnccl-dev_1.2.3-1.cuda7.5_amd64.deb" "https://github.com/NVIDIA/nccl/releases/download/v1.2.3-1%2Bcuda7.5/libnccl-dev_1.2.3-1.cuda7.5_amd64.deb"
    ;;
  8.0 )
    wget -O "nccl/nccl_2.2.13-1+cuda8.0_x86_64.txz" "https://s3-ap-northeast-1.amazonaws.com/pfn-internal-public/cupy/nccl_2.2.13-1%2Bcuda8.0_x86_64.txz"
    ;;
  9.0 )
    wget -O "nccl/nccl_2.3.7-1+cuda9.0_x86_64.txz" "https://s3-ap-northeast-1.amazonaws.com/pfn-internal-public/cupy/nccl_2.3.7-1%2Bcuda9.0_x86_64.txz"
    ;;
  9.1 )
    wget -O "nccl/nccl_2.1.15-1+cuda9.1_x86_64.txz" "https://s3-ap-northeast-1.amazonaws.com/pfn-internal-public/cupy/nccl_2.1.15-1%2Bcuda9.1_x86_64.txz"
    ;;
  9.2 )
    wget -O "nccl/nccl_2.4.2-1+cuda9.2_x86_64.txz" "https://s3-ap-northeast-1.amazonaws.com/pfn-internal-public/cupy/nccl_2.4.2-1%2Bcuda9.2_x86_64.txz"
    ;;
  10.0 )
    wget -O "nccl/nccl_2.4.2-1+cuda10.0_x86_64.txz" "https://s3-ap-northeast-1.amazonaws.com/pfn-internal-public/cupy/nccl_2.4.2-1%2Bcuda10.0_x86_64.txz"
    ;;
  10.1 )
    wget -O "nccl/nccl_2.4.2-1+cuda10.1_x86_64.txz" "https://s3-ap-northeast-1.amazonaws.com/pfn-internal-public/cupy/nccl_2.4.2-1%2Bcuda10.1_x86_64.txz"
    ;;
  * )
    exit 1
    ;;
esac

###
### Build & Verify Distribution
###

./build.sh "${CUDA}" "${PYTHON}" "${HAVE_NCCL}"
