cd ../../
scons type=debug
cd mixcoder/test
rm abc*.flv
gcc -o singleflvtest singleflvtest.cpp
./singleflvtest Picasso.flv| ../../build/Linux-x86_64/mixcoder/prog/mix_coder | ../../build/Linux-x86_64/mixcoder/prog/seg_output_parser abc
#./singleflvtest test2.flv| ../../build/Linux-x86_64/mixcoder/prog/mix_coder | ../../build/Linux-x86_64/mixcoder/prog/seg_output_parser abc

