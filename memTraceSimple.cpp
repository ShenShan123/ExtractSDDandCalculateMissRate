/*
 *  This file contains an ISA-portable PIN tool for tracing memory accesses.
 */

#include "memTraceSimple.h"

template <class B>
Histogram<B>::Histogram(int s) : samples(0), _size(s)
{
    bins = new B[_size];
    /* init bins to 0 */
    for (int i = 0; i < _size; ++i)
        bins[i] = 0;
}

template <class B>
Histogram<B>::Histogram(const Histogram<B> & rhs) : samples(rhs.samples), _size(rhs._size)
{
    bins = new B[_size];
    for (int i = 0; i < _size; ++i)
        bins[i] = rhs.bins[i];
}

template <class B>
Histogram<B>::~Histogram() { delete [] bins; }

template <class B>
void Histogram<B>::setSize(int s)
{
    if (bins != nullptr)
        delete [] bins;

    _size = s;
    bins = new B[_size];

    /* init bins to 0 */
    for (int i = 0; i < _size; ++i)
        bins[i] = 0;

    //std::cout << "size of bins " << _size << std::endl;
}


template <class B>
const int Histogram<B>::size() const { return _size; }

template <class B>
void Histogram<B>::clear()
{
    samples = 0;
    /* when clear bins, the size keeps unchanged */
    for (int i = 0; i < _size; ++i)
        bins[i] = 0;
}

template <class B>
void Histogram<B>::normalize()
{
    for (int i = 0; i < _size; ++i)
        bins[i] /= samples;
}

template <class B>
int Histogram<B>::manhattanDist(const Histogram<B> & rhs)
{
    assert(_size == rhs._size);

    int dist = 0;
    for (int i = 0; i < _size; ++i)
        dist += std::abs(bins[i] - rhs.bins[i]);

    return dist;
}


template <class B>
B & Histogram<B>::operator[](const int idx)
{
    assert(idx >= 0 && idx < _size);
    return bins[idx];
}

template <class B>
Histogram<B> & Histogram<B>::operator=(const Histogram<B> & rhs)
{
    assert(_size == rhs.size());

    for (int i = 0; i < _size; ++i)
        bins[i] = rhs.bins[i];

    samples = rhs.samples;
    return *this;
}

template <class B>
Histogram<B> & Histogram<B>::operator+=(const Histogram<B> & rhs)
{
    assert(_size == rhs.size());

    for (int i = 0; i < _size; ++i)
        bins[i] += rhs.bins[i];

    samples += rhs.samples;
    return *this;
}

template <class B>
void Histogram<B>::sample(int x)
{
    /* the sample number must less than max size of bins */
    assert(x < _size && x >= 0);

    if (!bins[x])
        bins[x] = 1;
    else
        ++bins[x];
    /* calculate the total num of sampling */
    ++samples;
}

template <class B>
void Histogram<B>::print(std::ofstream & file)
{
    file.write((char *)bins, sizeof(B) * _size);
    //for (int i = 0; i < _size; ++i)
        //file << bins[i] << " ";
    //file  << "\n";
}

SampleStack::SampleStack(int sSize, int hSize, double sRate) : hibernInter(hSize), \
sampleInter(sSize), statusCounter(0), sampleCounter(0), \
state(State::hibernating), sampleRate(sRate) {};

SampleStack::SampleStack(double sRate) : hibernInter(0), sampleInter(0), statusCounter(0), \
sampleCounter(0), state(State::sampling), sampleRate(sRate), residue(0) {};

SampleStack::SampleStack() : hibernInter(0), sampleInter(0), statusCounter(0), \
sampleCounter(0), state(State::sampling), sampleRate(0.0) {};

void SampleStack::setSampleRate(double s) { sampleRate = s; }

void SampleStack::clear()
{
    addrTable.clear();
    sampleCounter = 0;
}

int SampleStack::genRandom()
{
    // construct a trivial random generator engine from a time-based seed:
    std::random_device seed;
    static std::mt19937 engine(seed());
    //static std::geometric_distribution<int> geom(sampleRate);
    static std::uniform_int_distribution<int> unif(1, (int) 1 / sampleRate);
    
    //int randNum = 0;
    //while (!randNum)
        //randNum = geom(engine);

    int randNum = unif(engine);
    residue = (int) 1 / sampleRate - randNum;
    return randNum;
}

/* the argument hist uses reference is safe, because when calStackDist is return,
   totalSDD in RecordMemRefs is destroy */
void SampleStack::calStackDist(uint64_t addr, Histogram<> * & hist)
{
#ifdef HIBER
    /* start a new sampling interval */
    if (state == State::hibernating && !statusCounter) {
        statusCounter = sampleInter;
        sampleCounter = genRandom();
        state = State::sampling;
    }
    /* start hibernation interval */
    else if (state == State::sampling && !statusCounter) {
        statusCounter = hibernInter;
        state = State::hibernating;
    }
#endif

    /* if we find a same address x in addrTable,
    record its stack distance and the sampling of x is finished */
    auto pos = addrTable.find(addr);
    if (pos != addrTable.end()) {
		hist->sample(DOLOG(pos->second.size() - 1));
        addrTable.erase(addr);
    }

    auto it = addrTable.begin();

    /* make sure the max size of addrTable */
    //if (addrTable.size() > sampleRate * sampleInter * 2) {
        //hist->sample(log2p1(truncation));
        //addrTable.erase(it->first);
    //}

    /* record unique mem references between the sampled address x */
    for (it = addrTable.begin(); it != addrTable.end(); ) {
        it->second.insert(addr);
        /* if the set of sampled address x is too large,
        erase it from  the table and record as truncation */
        if (it->second.size() > Truncation) {
            auto eraseIt = it;
            ++it;
            hist->sample(DOLOG(Truncation));
            addrTable.erase(eraseIt->first);
        }
        else
            ++it;
    }

    /* if it is time to do sampling */
    if (state == State::sampling && !sampleCounter) {
        /* it is a new sampled address */
        assert(!addrTable[addr].size());
        addrTable[addr].insert(0);
        /* reset the sampleCounter and randNum to prepare next sample */
        sampleCounter = residue;
        sampleCounter += genRandom();
    }
#ifdef HIBER
    --statusCounter;
#endif
    if (state == State::sampling)
        --sampleCounter;
}


Histogram<> SetDistr(MAXSETNUM);

VOID PIN_FAST_ANALYSIS_CALL
RecordMemRefs(VOID * loca, VOID * a)
{
    ++NumMemAccs;
    ++Counter;
    /* cast void poiters */
    uint64_t addr = reinterpret_cast<uint64_t> (loca);
    Arguments * args = static_cast<Arguments *> (a);
    //SampleStack * sampleStack = static_cast<SampleStack *> (args->first);
    Histogram<> * currSDD = static_cast<Histogram<> *> (args->second);
    
	//sampleStack->calStackDist(addr >> blkBits, currSDD);
    avlTreeStack.calStackDist(addr >> blkBits, *currSDD);
    SetDistr.sample((addr >> blkBits) & (MAXSETNUM - 1));
}

// This function is called before every instruction is executed
VOID PIN_FAST_ANALYSIS_CALL
doDump(VOID * a)
{
    if (Counter >= IntervalSize) {
        Counter = 0;
        ++NumIntervals;
        Arguments * args = static_cast<Arguments *> (a);
        //SampleStack * sampleStack = static_cast<SampleStack *> (args->first);
        Histogram<> * currSDD = static_cast<Histogram<> *> (args->second);
        Histogram<> * totalSDD = static_cast<Histogram<> *> (args->third);
        /* sum the current SDD to total SDD */
        *totalSDD += *currSDD;

#ifdef PREDIC
        uint32_t distMin = INT_MAX;
        //uint32_t idxMin;
        /* search for a similar SDD of a phase */
        for (uint32_t i = 0; i < phaseTable.size(); ++i) {
            uint32_t dist = phaseTable[i]->manhattanDist(*currSDD);
            if (dist < distMin) {
                distMin = dist;
                //idxMin = i;
            }
        }
        if (distMin > SddDiff) {
            Histogram<> * item = new Histogram<>(*currSDD);
            phaseTable.push_back(item);
        }
        else 
#endif

        //currSDD->print(fout);
        //sampleStack->clear();
        avlTreeStack.clear();
        currSDD->clear();
        std::cout << "==== " << NumIntervals << "th interval ====" << std::endl;
    }

    /* if we got a maximum memory references, just exit this program */
    if (NumMemAccs >= 50000000000) {
        Fini(0, a);
        exit (0);
    }
}

/*
 * Insert code to write data to a thread-specific buffer for instructions
 * that access memory.
 */
VOID Trace(TRACE trace, VOID * a)
//VOID PIN_FAST_ANALYSIS_CALL Instruction(INS ins, VOID *v)
{   
    //Arguments * args = static_cast<Arguments *> (a);
    // Insert a call to record the effective address.
    for(BBL bbl = TRACE_BblHead(trace); BBL_Valid(bbl); bbl=BBL_Next(bbl))
    {
        for(INS ins = BBL_InsHead(bbl); INS_Valid(ins); ins=INS_Next(ins))
        {
            //if(INS_IsMemoryRead(ins) && INS_IsStandardMemop(ins))
            if(INS_IsMemoryRead(ins)) // include vector load/store, by shen
            {
                INS_InsertCall(
                ins, IPOINT_BEFORE, 
                (AFUNPTR)RecordMemRefs, IARG_FAST_ANALYSIS_CALL, 
                IARG_MEMORYREAD_EA,
                IARG_PTR, a,
                IARG_END);
            }

            //if (INS_HasMemoryRead2(ins) && INS_IsStandardMemop(ins))
            if(INS_HasMemoryRead2(ins)) // include vector load/store, by shen
            {   
                INS_InsertCall(
                ins, IPOINT_BEFORE, 
                (AFUNPTR)RecordMemRefs, IARG_FAST_ANALYSIS_CALL, 
                IARG_MEMORYREAD2_EA,
                IARG_PTR, a,
                IARG_END);
            }

            //if(INS_IsMemoryWrite(ins) && INS_IsStandardMemop(ins))
            if(INS_IsMemoryWrite(ins)) // include vector load/store, by shen
            {
                INS_InsertCall(
                ins, IPOINT_BEFORE, 
                (AFUNPTR)RecordMemRefs, IARG_FAST_ANALYSIS_CALL, 
                IARG_MEMORYWRITE_EA,
                IARG_PTR, a,
                IARG_END);
            }
        }

        // Insert a call to docount for every bbl, passing the number of instructions.
        // IPOINT_ANYWHERE allows Pin to schedule the call anywhere in the bbl to obtain best performance.
        // Use a fast linkage for the call.
        BBL_InsertCall(bbl, IPOINT_ANYWHERE, 
        (AFUNPTR)doDump, IARG_FAST_ANALYSIS_CALL,
        IARG_PTR, a,
        IARG_END);
    }
}

/* output the results, and free the poiters */
VOID Fini(INT32 code, VOID * a)
{
    Arguments * args = static_cast<Arguments *> (a);
    /* cast the void poiters */
    SampleStack * sampleStack = static_cast<SampleStack *> (args->first);
    Histogram<> * currSDD = static_cast<Histogram<> *> (args->second);
    Histogram<> * totalSDD = static_cast<Histogram<> *> (args->third);
    /* sum the current SDD to total SDD */
    *totalSDD += *currSDD;
    //currSDD->print(fout);
    SetDistr.print(fout);
    totalSDD->print(fout);
    ++NumIntervals;

    fout.close();
    /* free pointers */
    delete sampleStack;
    delete currSDD;
    delete totalSDD;
    delete args;

#ifdef PREDIC
    for (unsigned int i = 0; i < phaseTable.size(); ++i)
        delete phaseTable[i];

    std::cout << "phase table size " << phaseTable.size() << std::endl;
#endif
    std::cout << "Total memory accesses " << NumMemAccs << std::endl;
}

/* ===================================================================== */
/* Print Help Message                                                    */
/* ===================================================================== */
   
INT32 Usage()
{
    PIN_ERROR( "This Pintool calculate the stack distance of a program.\n" 
              + KNOB_BASE::StringKnobSummary() + "\n");
    return -1;
}

/* ===================================================================== */
/* Main                                                                  */
/* ===================================================================== */

int main(int argc, char *argv[])
{
    if (PIN_Init(argc, argv)) return Usage();

    IntervalSize = KnobIntervalSize.Value();
    Truncation = KnobTruncDist.Value();
    SddDiff = KnobSddDiff.Value();
    /* out put file open */
    fout.open(KnobOutputFile.Value().c_str(), std::ios::out | std::ios::binary);
    if (fout.fail()) {
         PIN_ERROR( "output file: " + KnobOutputFile.Value() + " cannot be opened.\n" 
              + KNOB_BASE::StringKnobSummary() + "\n");
         return -1;
    }

    /* sampleStack does sampling and calculate stack distance */
    SampleStack * sampleStack = new SampleStack((double) 1 / KnobSampleRate.Value());
    /* current phase SDD */
    Histogram<> * currSDD = new Histogram<>(DOLOG(Truncation) + 1);
    /* totalSDD records the whole SDD */
    Histogram<> * totalSDD = new Histogram<>(DOLOG(Truncation) + 1);

    /* arguments to pass to Trace() */
    Arguments * args = new Arguments;
    args->first = static_cast<void *> (sampleStack);
    args->second = static_cast<void *> (currSDD);
    args->third = static_cast<void *> (totalSDD);

    std::cout << "truncation distance " << Truncation << "\nout file " << KnobOutputFile.Value().c_str() \
    << "\ninterval size " << IntervalSize << "\nsample rate " << (double) 1 / KnobSampleRate.Value() << std::endl;

    // add an instrumentation function
    TRACE_AddInstrumentFunction(Trace, static_cast<VOID *> (args));

    /* when the instrucments finish, call this API */
    PIN_AddFiniFunction(Fini, static_cast<VOID *> (args));

    // Never returns
    PIN_StartProgram();

    std::cout << "finally return\n";
    
    return 0;
}
