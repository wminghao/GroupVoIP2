cd ../../
scons type=debug
cd mixcoder/test
rm abc*.flv
g++ -o nineflvtest nineflvtest.cpp flvrealtimeparser.cpp
date
./nineflvtest test.flv test2.flv test.flv test3.flv test2.flv test3.flv test4.flv test3.flv test2.flv | ../../build/Linux-x86_64/mixcoder/prog/mix_coder | ../../build/Linux-x86_64/mixcoder/prog/seg_output_parser abc
date