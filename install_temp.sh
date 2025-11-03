cd /scratch/anderss

module load compilers/gcc/12.3.0

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
. "${HOME}/.nvm/nvm.sh"
nvm install 23
corepack enable yarn
yarn init -2
yarn -v
yarn add corepack

wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
tar -xvf apache-maven-3.9.9-bin.tar.gz
export PATH="/scratch/anderss/apache-maven-3.9.9/bin:${PATH}"

git clone https://github.com/dbeaver/cloudbeaver.git
cd cloudbeaver/deploy
./build.sh

mkdir -p /deac/opt/rocky9-noarch/cloudbeaver
cp -r /scratch/anderss/cloudbeaver /deac/opt/rocky9-noarch/cloudbeaver/25.0.4


mkdir -p /deac/opt/modulefiles/rocky9-noarch/apps/cloudbeaver/
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/cloudbeaver/25.0.4
#%Module
##

proc ModulesHelp { } {
    puts stderr "\tSets up environment for using CloudBeaver."
}

module-whatis   "Sets up environment for using CloudBeaver"

module load compilers/gcc/12.3.0

set version  "25.0.4"
set basedir  "/deac/opt/rocky9-noarch/cloudbeaver/25.0.4"

################################################################################
################################################################################

setenv  CLOUDBEAVERHOME   \$basedir/deploy/cloudbeaver
EOF
