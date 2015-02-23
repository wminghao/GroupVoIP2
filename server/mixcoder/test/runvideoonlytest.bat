cd ../../
scons type=debug
cd mixcoder/test
rm abc*.flv
g++ -ggdb -g3 -o singleflvtest singleflvtest.cpp flvrealtimeparser.cpp
./singleflvtest test_videoonly.flv| ../../build/Linux-x86_64/mixcoder/prog/mix_coder | ../../build/Linux-x86_64/mixcoder/prog/seg_output_parser abc
