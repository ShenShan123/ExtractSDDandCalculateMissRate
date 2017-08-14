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
B & Histogram<B>::operator[](const int idx) const
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
    assert(_size == rhs._size);

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
    //file.write((char *)bins, sizeof(B) * _size);
    for (int i = 0; i < _size; ++i)
        file << bins[i] << " ";
    file  << "\n";
}

void ReuseDist::calReuseDist(uint64_t addr, Histogram<> & rdv)
{
    long & value = addrMap[addr];

    ++index;

    /* value is 0 under cold miss */
    if (!value) {
        rdv.sample(DOLOG(Truncation));
        value = index;
        return;
    }

    /* update b of last reference */
    if (value < index) {
        uint32_t reuseDist = index - value - 1;
        reuseDist = reuseDist >= Truncation ? Truncation : reuseDist;
        rdv.sample(DOLOG(reuseDist));
    }

    value = index;
}

template<class B>
PhaseTable::Entry<B>::Entry(const Histogram<B> & rdv, const uint32_t _id) : Histogram<B>(rdv), id(_id), occur(1)
{
    //for (int i = 0; i < this->_size; ++i)
      //  id ^= this->bins[i];
}

template<class B>
double PhaseTable::Entry<B>::manhattanDist(const Histogram<B> & rhs)
{
    assert(this->_size == rhs.size());

    B dist = 0;
    for (uint32_t i = 0; i < this->_size; ++i)
        /* abstract the sum of the similar rdvs in the entry 
           with the rhs(current phase rdv), this is 
           an approximation to average manhattan distance
           between to clusters. */
        dist += std::abs(this->bins[i] - occur * rhs[i]);

    return (double)dist / this->samples;
}

PhaseTable::~PhaseTable() 
{
    for (auto it = pt.begin(); it != pt.end(); ++it)
        delete *it;
}

uint32_t PhaseTable::find(const Histogram<> & rdv)
{
    ++index;
    double distMin = DBL_MAX;
    Entry<int64_t> * entryPtr = nullptr;

    /* search for a similar RDV of a phase */
    for (auto it = pt.begin(); it != pt.end(); ++it) {
        double dist = (*it)->manhattanDist(rdv);

        if (dist < distMin) {
            distMin = dist;
            entryPtr = *it;
        }
    }

    /* if found a similar entry in phase table, 
       add the rdv to it which is similar with,
       and incread the occurence counter. */
    if (distMin < threshold && entryPtr != nullptr) {
        ++entryPtr->occur;
        *entryPtr += rdv;
        std::cout << "found a similar phase: id " << entryPtr->id << std::endl;
        return entryPtr->id;
    }
    else {
        entryPtr = new Entry<int64_t>(rdv, pt.size() + 1);
        std::cout << "creat a new phase: id " << entryPtr->id << std::endl;
        pt.push_back(entryPtr);
        return entryPtr->id;
    }
}

VOID PIN_FAST_ANALYSIS_CALL
RecordMemRefs(ADDRINT ea)
{
    ++NumMemAccs;
    ++InterCount;

    reuseDist.calReuseDist(reinterpret_cast<uint64_t> (ea) >> BlkBits, currRDD);

    if (InterCount >= IntervalSize) {
        /* compensate the residual of insts */
        InterCount -= IntervalSize;
        ++NumIntervals;

        //uint32_t id = phaseTable.find(currRDD);
        //fout << id << "\n";

        currRDD.print(fout);
        currRDD.clear();
        std::cout << "==== " << NumIntervals << "th interval ====" << std::endl;
    }

    /* if we got a maximum memory references, just exit this program */
    //if (NumMemAccs >= 50000000000) {
        //Fini(0);
        //exit(0);
    //}
}

/*
 * Insert code to write data to a thread-specific buffer for instructions
 * that access memory.
 */
VOID Trace(TRACE trace, VOID * v)
//VOID PIN_FAST_ANALYSIS_CALL Instruction(INS ins, VOID *v)
{   
    // Insert a call to record the effective address.
    for(BBL bbl = TRACE_BblHead(trace); BBL_Valid(bbl); bbl=BBL_Next(bbl))
        for(INS ins = BBL_InsHead(bbl); INS_Valid(ins); ins=INS_Next(ins)) {
            /* if the inst is a memory inst, then call the analysis routine */
            if (INS_IsMemoryRead(ins))
                INS_InsertCall(
                ins, IPOINT_BEFORE,
                (AFUNPTR)RecordMemRefs, IARG_FAST_ANALYSIS_CALL,
                IARG_MEMORYREAD_EA,
                IARG_END);
            if (INS_HasMemoryRead2(ins))
                INS_InsertCall(
                ins, IPOINT_BEFORE,
                (AFUNPTR)RecordMemRefs, IARG_FAST_ANALYSIS_CALL,
                IARG_MEMORYREAD2_EA,
                IARG_END);
            if (INS_IsMemoryWrite(ins))
                INS_InsertCall(
                ins, IPOINT_BEFORE,
                (AFUNPTR)RecordMemRefs, IARG_FAST_ANALYSIS_CALL,
                IARG_MEMORYWRITE_EA,
                IARG_END);
        }
}

/* output the results, and free the poiters */
VOID Fini(INT32 code, VOID *v)
{
    /* sum the current SDD to total SDD */
    //totalSDD += currRDD;
    //totalSDD->print(fout);
    ++NumIntervals;

    fout.close();

    std::cout << "phase table size " << phaseTable.size() << std::endl;
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
    /* out put file open */
    fout.open(KnobOutputFile.Value().c_str(), std::ios::out | std::ios::binary);
    if (fout.fail()) {
         PIN_ERROR( "output file: " + KnobOutputFile.Value() + " cannot be opened.\n" 
              + KNOB_BASE::StringKnobSummary() + "\n");
         return -1;
    }

    /* current phase RDD */
    currRDD.setSize(DOLOG(Truncation) + 1);
    /* default threshold = 0.05 */
    phaseTable.setThreshold((double)1 / KnobRdvThreshold.Value());

    std::cout << "truncation distance " << Truncation << "\nout file " << KnobOutputFile.Value().c_str() \
    << "\ninterval size " << IntervalSize << "\nPhase threshold " << (double) 1 / KnobRdvThreshold.Value() << std::endl;

    // add an instrumentation function
    TRACE_AddInstrumentFunction(Trace, 0);

    /* when the instrucments finish, call this API */
    PIN_AddFiniFunction(Fini, 0);

    // Never returns
    PIN_StartProgram();

    return 0;
}
