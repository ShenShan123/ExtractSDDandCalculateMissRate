#ifndef __MEM_TRACE_SIMPLE_H__
#define __MEM_TRACE_SIMPLE_H__

#include <iostream>
#include <fstream>
#include <unordered_set>
#include <vector>
#include <map>
#include <random>
#include <unordered_map>
#include <assert.h>
#include <stdlib.h> 
#include <time.h> 
#include <iomanip>
#include "pin.H"


static uint64_t Truncation = 0;
static uint64_t Counter = 0;
static uint64_t NumMemAccs = 0;
static uint64_t NumIntervals = 0;
static uint64_t IntervalSize = 0;
static uint32_t SddDiff = 0;
std::ofstream fout;
//std::vector<double> manhattanDist;

/* parse the command line arguments */
KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE, "pintool", "o", "SDD.txt", "specify output file name");
KNOB<UINT64> KnobTruncDist(KNOB_MODE_WRITEONCE, "pintool", "m", "4096", "the truncation distance of SD");
KNOB<UINT64> KnobIntervalSize(KNOB_MODE_WRITEONCE, "pintool", "i", "10000000", "the interval size");
KNOB<UINT64> KnobSampleRate(KNOB_MODE_WRITEONCE, "pintool", "s", "20000", "the sample rate");
KNOB<UINT32> KnobSddDiff(KNOB_MODE_WRITEONCE, "pintool", "d", "30", "the maximum difference value of two SDD vector");

#define LOG2
#define SAMPLE

/* calculate log2(s) + 1 */
template<class T>
inline T log2p1(T s)
{
	T result = 0;
	while (s) {
		s >>= 1;
		++result;
	}

	return result;
}

/* fast to calculate log2(x)+1 */
#ifdef LOG2
#define DOLOG(x) log2p1(x)
#else
#define DOLOG(x) x
#endif

struct Arguments
{
	void * first;
	void * second;
	void * third;
};

/* for recording distribution into a Histogram, 
   Accur is the accuracy of transforming calculation */
template <class B = int64_t>
class Histogram
{
	B * bins;
	B samples;
	int _size;

public:
	Histogram() : bins(nullptr), samples(0), _size(0) {};

	Histogram(int s);

	Histogram(const Histogram<B> & rhs);

	~Histogram();

	void setSize(int s);

	const int size() const;

	void clear();

	void normalize();

	int manhattanDist(const Histogram<B> & rhs);

	B & operator[](const int idx);

	Histogram<B> & operator=(const Histogram<B> & rhs);

	Histogram<B> & operator+=(const Histogram<B> & rhs);

	void sample(int x);

	const B getSamples() const; 

	void print(std::ofstream & file);
};

std::vector<Histogram<> *> phaseTable;

/* stack distance staticstics with sampling */
class SampleStack
{
	typedef std::unordered_set<uint64_t> AddrSet;
	/* each watchpoint has a set to keep the unique mem refs */
	std::unordered_map<uint64_t, AddrSet> addrTable;
	/* hibernating interval size */
	int hibernInter;
	/* sampling interval size */
	int sampleInter;
	/* the counter starts a sampling or hibernating interval */
	uint64_t statusCounter;
	/* the counter chooses the random sample to record SD */
	uint64_t sampleCounter;
	enum State {sampling, hibernating};
	State state;
	double sampleRate;
	/* the residue of sampleRate and randNum, keep the fixed number of samples */
	int residue;

public:
	SampleStack(int sSize, int hSize, double sRate);

	SampleStack(double sRate);

	SampleStack();

	void setSampleRate(double s);

	void clear();

	/* to generate a random number */
	int genRandom();

	void calStackDist(uint64_t addr, Histogram<> * & hist);
};

VOID PIN_FAST_ANALYSIS_CALL
RecordMemRefs(VOID * loca, VOID * a);

// This function is called before every instruction is executed
VOID PIN_FAST_ANALYSIS_CALL 
doDump(VOID * a);

/*
 * Insert code to write data to a thread-specific buffer for instructions
 * that access memory.
 */
VOID Trace(TRACE trace, VOID * a);

/* output the results, and free the poiters */
VOID Fini(INT32 code, VOID * a);

/* ===================================================================== */
/* Print Help Message                                                    */
/* ===================================================================== */
INT32 Usage();

#endif
