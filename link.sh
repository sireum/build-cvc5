set -e
ls -lah
sudo wget -O /usr/bin/ape https://cosmo.zip/pub/cosmos/bin/ape-$(uname -m).elf
sudo chmod +x /usr/bin/ape
sudo sh -c "echo ':APE:M::MZqFpD::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register" || true
sudo sh -c "echo ':APE-jart:M::jartsr::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register" || true
rm -fR cosmocc*
curl -JLOs https://github.com/jart/cosmopolitan/releases/download/$COSMOCC_V/cosmocc-$COSMOCC_V.zip
mkdir cosmocc
cd cosmocc
unzip -qq ../cosmocc-$COSMOCC_V.zip
cd ..
cosmocc/bin/apelink -s -l cosmocc/bin/ape-x86_64.elf -l cosmocc/bin/ape-aarch64.elf -o cvc5.com cvc5-amd64/cvc5-x86_64 cvc5-arm64/cvc5-aarch64