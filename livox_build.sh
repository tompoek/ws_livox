set -o

cd ~/ws_livox/
rm -rf build/ install/ log/

cd src/FAST_LIO
git submodule init
git submodule update --remote --recursive

cd ../..
colcon build --symlink-install
