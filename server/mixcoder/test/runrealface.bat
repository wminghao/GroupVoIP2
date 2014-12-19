cd ../../
scons type=debug
cd mixcoder/test
rm abc*.flv
export LD_LIBRARY_PATH=/usr/local/lib
cat realface.seg | ../../build/Linux-x86_64/mixcoder/prog/mix_coder | ../../build/Linux-x86_64/mixcoder/prog/seg_output_parser abc

