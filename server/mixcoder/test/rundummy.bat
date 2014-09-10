cd ../../
scons type=debug
cd mixcoder/test
rm abc*.flv
gcc -o singleflvtest singleflvtest.cpp
./singleflvtest test.flv| dummy | ../../build/Linux-x86_64/mixcoder/prog/seg_output_parser abc

