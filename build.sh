set -ex
export COSMOCC_V=`cat cosmocc.ver`
export CVC5_SHA=`cat cvc5.sha`
export ARCH=`arch`
if [[ -d /proc/sys/fs/binfmt_misc/register ]]; then
  sudo wget -O /usr/bin/ape https://cosmo.zip/pub/cosmos/bin/ape-$(uname -m).elf
  sudo chmod +x /usr/bin/ape
  sudo sh -c "echo ':APE:M::MZqFpD::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register" || true
  sudo sh -c "echo ':APE-jart:M::jartsr::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register" || true
fi
rm -fR cosmocc cvc5 cosmocc-*.zip
curl -JLO https://github.com/jart/cosmopolitan/releases/download/$COSMOCC_V/cosmocc-$COSMOCC_V.zip
mkdir cosmocc
cd cosmocc
unzip -qq ../cosmocc-$COSMOCC_V.zip
cd ..
export PATH=`pwd`/cosmocc/bin:$PATH
export CXX=`pwd`/cosmocc/bin/$ARCH-unknown-cosmo-c++
export CC=`pwd`/cosmocc/bin/$ARCH-unknown-cosmo-cc
export AR=`pwd`/cosmocc/bin/$ARCH-unknown-cosmo-ar
git clone https://github.com/cvc5/cvc5
cd cvc5
git checkout $CVC5_SHA
./configure.sh competition --static --static-binary --kissat --no-poly --cocoa --no-editline --gpl --auto-download
cd build
make -j4
ldd bin/cvc5 || true
cp bin/cvc5 ../../cvc5-$ARCH
