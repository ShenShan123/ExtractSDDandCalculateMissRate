#ifndef __MEM_TRACE_SIMPLE_H__
#define __MEM_TRACE_SIMPLE_H__

#include <iostream>
#include <fstream>
#include <map>
#include <random>
#include <assert.h>
#include <iomanip>
#include <list>
#include <float.h>
#include "pin.H"

static uint64_t Truncation = 0;
static uint64_t InterCount = 0;
static uint64_t NumMemAccs = 0;
static uint64_t NumIntervals = 0;
static uint64_t IntervalSize = 0;
/* block size is 64 byte, so the block offset bits is lower 6 bits */
static uint64_t BlkBits = 6;

/* parse the command line arguments */
KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE, "pintool", "o", "RDV.txt", "specify output file name");
KNOB<UINT64> KnobTruncDist(KNOB_MODE_WRITEONCE, "pintool", "m", "16384", "the truncation distance of SD");
KNOB<UINT64> KnobIntervalSize(KNOB_MODE_WRITEONCE, "pintool", "i", "10000000", "the interval size");
KNOB<UINT32> KnobSample(KNOB_MODE_WRITEONCE, "pintool", "s", "0", "the sample interval size");
KNOB<UINT32> KnobRdvThreshold(KNOB_MODE_WRITEONCE, "pintool", "t", "5", "the maximum normalized manhattan distance of two RD vector");
KNOB<UINT32> KnobPhaseTableSize(KNOB_MODE_WRITEONCE, "pintool", "p", "256", "phase table size");

#define LOG2
//#define SAMPLE
#define PREDIC

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

template<class I>
I genRandNum(I range)
{
    // construct a trivial random generator engine from a time-based seed:
    std::random_device seed;
    static std::mt19937 engine(seed());
    static std::uniform_int_distribution<I> unif(1, range);
    return unif(engine);
}

/* fast to calculate log2(x)+1 */
#ifdef LOG2
#define DOLOG(x) log2p1(x)
#else
#define DOLOG(x) x
#endif

/* for recording distribution into a Histogram, 
   Accur is the accuracy of transforming calculation */
template <class B = int64_t>
class Histogram
{
protected:
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

	B & operator[] (const int idx) const;

	Histogram<B> & operator=(const Histogram<B> & rhs);

	Histogram<B> & operator+=(const Histogram<B> & rhs);

	/* recompute the centroid */
	void average(const Histogram<B> & rhs);

	void sample(int x);

	const B getSamples() const; 

	void print(std::ofstream & file);
};

/* do reuse distance statistics */
class ReuseDist
{
	std::map<uint64_t, uint64_t> addrMap;
	uint64_t index;
	uint32_t sampleInterval;
	uint32_t sampleCounter;
	uint32_t sampleResidual;

public:
	ReuseDist() : index(0), sampleInterval(0), sampleCounter(0), sampleResidual(0) {};

	~ReuseDist() {};

	void setSampleInterval(uint32_t s);

	void calReuseDist(uint64_t addr, Histogram<> & rdv);

	void fullReuseDist(uint64_t addr, Histogram<> & rdv);

	void sampleReuseDist(uint64_t addr, Histogram<> & rdv);

	uint32_t mapSize() { return addrMap.size(); }
};

class PhaseTable
{
public:
	class Entry : public Histogram<>
	{
	private:
		friend class PhaseTable;
		uint32_t id;
		uint32_t occur;
		uint16_t reuse;
	
	public:
		Entry(const Histogram<> & rdv, const uint32_t _id);
	
		~Entry() {};

		void merge(Entry & rhs);

		double manhattanDist(const Histogram<> & rhs);
		
		double manhattanDist(const Entry & rhs);

		void clearReuse();

		const uint32_t getId() const { return id; }

		const uint16_t getReuse() const { return reuse; }
	};

private:
	/* list for LRU replacement policy */
	std::list<Entry *> pt;
	std::list<Entry *> victs;
	double threshold;
	uint32_t newId;
	uint32_t ptSize;

public:
	PhaseTable() : threshold(0.0), newId(0), ptSize(0) {};

	~PhaseTable();

	void init(double t, uint32_t s);

	void mergeClusts();

	/* do LRU replacement */
	void lruRepl(Entry * ent, std::list<Entry *>::iterator & p, bool inVicts);

	PhaseTable::Entry * find(const Histogram<> & rdv);

	const int size() const { return pt.size(); }
};


VOID PIN_FAST_ANALYSIS_CALL
RecordMemRefs(ADDRINT ea);

/*
 * Insert code to write data to a thread-specific buffer for instructions
 * that access memory.
 */
VOID Trace(TRACE trace, VOID *v);

/* output the results, and free the poiters */
VOID Fini(INT32 code, VOID *v = NULL);

/* ===================================================================== */
/* Print Help Message                                                    */
/* ===================================================================== */
INT32 Usage();


/* global variates */
std::ofstream fout;
Histogram<> currRDD;
ReuseDist reuseDist;
PhaseTable phaseTable;

#endif
