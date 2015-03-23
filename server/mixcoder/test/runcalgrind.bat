cd ../../
scons type=debug
cd mixcoder/test
mkfifo foo
cat test.seg > foo &
valgrind --tool=callgrind ../../build/Linux-x86_64/mixcoder/prog/mix_coder < foo > slow_output.seg
