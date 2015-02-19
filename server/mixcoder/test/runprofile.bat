cd ../../
scons type=gprof
cd mixcoder/test
cat test.seg | ../../build/Linux-x86_64/mixcoder/prog/mix_coder > slow_output.seg
gprof ../../build/Linux-x86_64/mixcoder/prog/mix_coder /tmp/gmon.out > slow_profile.log

