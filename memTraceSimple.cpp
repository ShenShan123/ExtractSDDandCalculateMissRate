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
void Histogram<B>::average(const Histogram<B> & rhs)
{
    assert(_size == rhs._size);

    for (int i = 0; i < _size; ++i)
        bins[i] = (bins[i] + rhs.bins[i]) / 2;

    samples = (samples + rhs.samples) / 2;
}

template <class B>
void Histogram<B>::sample(int x, uint16_t n)
{
    /* the sample number must less than max size of bins */
    assert(x < _size && x >= 0);
    bins[x] += n;
    /* calculate the total num of sampling */
    samples += n;
}

template <class B>
void Histogram<B>::print(std::ofstream & file)
{
    //file.write((char *)bins, sizeof(B) * _size);
    for (int i = 0; i < _size; ++i)
        file << bins[i] << " ";
    file  << "\n";
}

void ReuseDist::setSampleInterval(uint32_t s)
{
    sampleInterval = s;
    sampleCounter = s ? genRandNum(s) : 0;
}

#if 0
void ReuseDist::calReuseDist(uint64_t addr, Histogram<> & rdv)
{
    if (sampleInterval)
        sampleReuseDist(addr, rdv);
    else
        fullReuseDist(addr, rdv);
}
#endif

void ReuseDist::calReuseDist(uint64_t addr, Histogram<> & rdv)
{
    ++index;

    auto pos = addrMap.find(addr);

    if (pos != addrMap.end()) {
        uint32_t reuseDist = index - pos->second - 1; 
        /* for the sampling scheme, rd-counter is clear when finish rd calculation */
        if (sampleInterval)
            addrMap.erase(pos);
        /* if the rd larger than the truncation, we check other rd-counters, 
           if their rds are also larger then truncation, we just delete them */
        if (reuseDist >= Truncation) {
            /* the total number of rd-counters whose values are larger then truncation */
            int numTrunc = 1;

            for (auto it = addrMap.begin(); it != addrMap.end(); ) {
                if (index - it->second - 1 >= Truncation) {
                    ++numTrunc;
                    auto eraseIt = it;
                    ++it;
                    addrMap.erase(eraseIt);
                }
                else
                    ++it;
            }

            rdv.sample(DOLOG(Truncation), sampleInterval ? numTrunc : 1);

        }
        /* else we don't need to traverse the addrMap */
        else
            rdv.sample(DOLOG(reuseDist));
    }
    /* we don't find this address indicate cold address in non-sampling scheme */
    else if (!sampleInterval)
        rdv.sample(DOLOG(Truncation));

    /* for sampline scheme */
    if (sampleCounter)
        --sampleCounter;
    /* when sampleCounter is zero in sampling scheme, 
       we sample an address to calculate rd. */
    else if (sampleInterval) {
        /* ensure no same address is existing in addrMap */
        assert(!addrMap[addr]);
        uint32_t random = genRandNum(sampleInterval);
        /* set sampleCounter for the next sample */
        sampleCounter = random + sampleResidual;
        sampleResidual = sampleInterval - random;
        //std::cout << "do sample, mapsize: " << addrMap.size() << std::endl;
        /* record the new sampled address and the index */
        addrMap[addr] = index;
    }
    /* for non-sampling scheme */
    else 
        addrMap[addr] = index;

}

#if 0
void ReuseDist::sampleReuseDist(uint64_t addr, Histogram<> & rdv)
{
    auto pos = addrMap.find(addr);
    /* the same address is encountered, finish rd calculation, and clear the rd-counter */
    if (pos != addrMap.end()) {
        rdv.sample(DOLOG(pos->second));
        addrMap.erase(pos);
    }

    /* increas rd-counters and clear the rd-counters 
       whose content is larger than truncation */
    for (auto it = addrMap.begin(); it != addrMap.end(); ) {
        ++(it->second);
        /* test if the rd larger than truncation */
        if (it->second >= Truncation) {
            rdv.sample(DOLOG(Truncation));
            auto eraseIt = it;
            ++it;
            /* clear the rd-counter */
            addrMap.erase(eraseIt);
        }
        else 
            ++it;
    }

    if (sampleCounter)
        --sampleCounter;
    /* when sampleCounter is zero, we sample an address to calculate rd. */
    else {
        /* ensure no same address is existing in addrMap */
        assert(!addrMap[addr]);
        /* record the sampled address */
        addrMap[addr] = 0;
        uint32_t random = genRandNum(sampleInterval);
        /* set sampleCounter for the next sample */
        sampleCounter = random + sampleResidual;
        sampleResidual = sampleInterval - random;
        //std::cout << "do sample, mapsize: " << addrMap.size() << std::endl;
    }
}
#endif

PhaseTable::Entry::Entry(const Histogram<> & rdv, const uint32_t _id) : Histogram<>(rdv), id(_id), occur(1), reuse(0)
{
    //for (int i = 0; i < this->_size; ++i)
      //  id ^= this->bins[i];
}

void PhaseTable::Entry::merge(Entry & rhs)
{
    assert(_size == rhs._size);

    for (int i = 0; i < _size; ++i)
        bins[i] += rhs.bins[i];

    samples += rhs.samples;
    occur += rhs.occur;
}

double PhaseTable::Entry::manhattanDist(const Histogram<> & rhs)
{
    assert(this->_size == rhs.size());

    int64_t dist = 0;
    for (int i = 0; i < this->_size; ++i)
        /* abstract the sum of the similar rdvs in the entry 
           with the rhs(current phase rdv), this is 
           an approximation to average manhattan distance
           between to clusters. */
        //dist += std::abs(this->bins[i] - occur * rhs[i]);
        dist += std::abs(this->bins[i] - rhs[i]);

    return (double)dist / this->samples;
}

double PhaseTable::Entry::manhattanDist(const Entry & rhs)
{
    int64_t dist = 0;
    for (int i = 0; i < this->_size; ++i)
        /* abstract the sum of the similar rdvs in the entry 
           with the rhs(current phase rdv), this is 
           an approximation to average manhattan distance
           between to clusters. */
        //dist += std::abs(this->bins[i] / occur - rhs[i] / rhs.occur);
        dist += std::abs(this->bins[i] - rhs[i]);

    //return (double)dist / (this->samples / occur);
    return (double)dist / this->samples;
}

void PhaseTable::Entry::clearReuse() { reuse = 0; }

PhaseTable::~PhaseTable() 
{
    for (auto it = pt.begin(); it != pt.end(); ++it)
        delete *it;
}

void PhaseTable::init(double t, uint32_t s)
{
    threshold = t;
    ptSize = s;
}

void PhaseTable::mergeClusts()
{
    uint32_t i = 0;

    for (auto it = pt.begin(); it != pt.end(); ++it) {
        double distMin = DBL_MAX;
        auto similarPos = pt.end();
        /* find the next entries in phase table */
        auto jt = it;
        ++jt;
        for (; jt != pt.end(); ++jt) {
            double dist = (*it)->manhattanDist(**jt);
            if (dist < distMin) {
                distMin = dist;
                similarPos = jt;
            }
        }

        assert(jt == pt.end());

        /* find similar phase in victim table */
        bool inVicts = false;
        for (jt = victs.begin(); jt != victs.end(); ++jt) {
            double dist = (*it)->manhattanDist(**jt);
            if (dist < distMin) {
                distMin = dist;
                similarPos = jt;
                inVicts = true;
            }
        }
        /* the distance between two phase is less than the threshold,
           we merge these into one phase, and empty an entry */
        if (distMin < threshold) {
            assert(similarPos != pt.end() && similarPos != victs.end());
            (*it)->merge(**similarPos);
            std::cout << "merge two entris " << (*it)->getId() << " with " << (*similarPos)->getId() << std::endl;
            fout << (*it)->getId() << " " << (*similarPos)->getId() << " merge\n"; 
            
            if (inVicts)
                victs.erase(similarPos);
            else
                pt.erase(similarPos);
        }

        ++i;

        if (i > pt.size() / 2)
            break;
    }
}

#define VICTSIZE 4

void PhaseTable::lruRepl(Entry * ent, std::list<Entry *>::iterator & p, bool inVicts)
{
    /* move the most recently access entry to the head of list */
    pt.push_front(ent);

    /* the signature phase is in victim table */
    if (inVicts) {
        assert(p != victs.end());
        victs.erase(p);
        std::cout << "phase in victim table\n";
        fout << "invicts\n";
    }
    /* erase the old position in phase table */
    else if (p != victs.end())
        pt.erase(p);
    
    /* if it is a new entry, we check the max size of phase table */
    /* if the phase table is full, move the last entry into victim table */
    if (pt.size() > ptSize) {
        std::cout << "full phase table!! pop " << pt.back()->getId() << " occurence " << pt.back()->occur << " reuseCounter " << pt.back()->getReuse() << std::endl;
        mergeClusts();
        /* puts the victim into victim table */
        if (pt.back()->occur > 1) {
            victs.push_front(pt.back());
            /* if the victs size is maximum, free the pointer */
            if (victs.size() > VICTSIZE) {
                delete victs.back();
                victs.pop_back();
            }
        }
        /* free the pointer, Entry *, and pop the last element */
        pt.pop_back();
    }

    assert(pt.size() <= ptSize);
}

PhaseTable::Entry * PhaseTable::find(const Histogram<> & rdv)
{
    double distMin = DBL_MAX;
    Entry * entryPtr = nullptr;
    auto similarPos = victs.end();
    bool inVicts = false;

    /* search for a similar RDV in phase table */
    for (auto it = pt.begin(); it != pt.end(); ++it) {
        /* update the reuse conter */
        ++(*it)->reuse;

        double dist = (*it)->manhattanDist(rdv);
        if (dist < distMin) {
            distMin = dist;
            entryPtr = *it;
            /* record the postion of the nearest vector */
            similarPos = it;
        }
    }

    /* search for a similar RDV in victim table */
    for (auto it = victs.begin(); it != victs.end(); ++it) {
        ++(*it)->reuse;

        double dist = (*it)->manhattanDist(rdv);
        if (dist < distMin) {
            distMin = dist;
            entryPtr = *it;
            /* record the postion of the nearest vector */
            similarPos = it;
            inVicts = true;
        }
    }

    /* if found a similar entry in phase table, 
       add the rdv to the simial cluster,
       and incread the occurence counter. */
    if (distMin < threshold && entryPtr != nullptr) {
        ++entryPtr->occur;
        entryPtr->average(rdv);
        std::cout << "found a similar phase: id " << entryPtr->id << std::endl;
        
        lruRepl(entryPtr, similarPos, inVicts);
    }
    /* creat a new phase entry and do LRU replacement policy */
    else {
        ++newId;
        similarPos = victs.end();
        //entryPtr = new Entry(rdv, genRandNum(ptSize * 8));
        entryPtr = new Entry(rdv, newId);
        std::cout << "creat a new phase: id " << entryPtr->id << std::endl;
        
        lruRepl(entryPtr, similarPos, false);
    }

    return entryPtr;
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

        //PhaseTable::Entry * entry = phaseTable.find(currRDD);
        /* print the current phase index */
        //fout << entry->getId() << "\n";

        currRDD.print(fout);
        currRDD.clear();
        std::cout << "==== " << NumIntervals << "th interval ====" << std::endl;
    }

    /* if we got a maximum memory references, just exit this program */
    if (NumIntervals >= 5000) {
        Fini(0);
        exit(0);
    }
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

    /* set whether do sampling or not, default is 0 */
    reuseDist.setSampleInterval(KnobSample.Value());
    /* current phase RDD */
    currRDD.setSize(DOLOG(Truncation) + 1);
    /* init the phase table with  threshold = 5%  and table size */
    phaseTable.init((double)KnobRdvThreshold.Value() / 100, KnobPhaseTableSize.Value());

    std::cout << "truncation distance " << Truncation << "\nRDV dimension " << currRDD.size() << "\nout file " << KnobOutputFile.Value().c_str() \
    << "\ninterval size " << IntervalSize << "\nPhase threshold " << (double)KnobRdvThreshold.Value() / 100 \
    << "\nphase table size " << KnobPhaseTableSize.Value() << "\nsample interval size " << KnobSample.Value() << std::endl;

    // add an instrumentation function
    TRACE_AddInstrumentFunction(Trace, 0);

    /* when the instrucments finish, call this API */
    PIN_AddFiniFunction(Fini, 0);

    // Never returns
    PIN_StartProgram();

    return 0;
}