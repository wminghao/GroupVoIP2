#ifndef __OUTPUT__
#define __OUTPUT__

#ifdef DEBUG
#define OUTPUT(...) printf(__VA_ARGS__)
#define ASSERT(x) assert(x)
#else 
#define OUTPUT(...) 
#define ASSERT(x) 
#endif

#endif
