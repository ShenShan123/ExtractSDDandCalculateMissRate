#pragma once

#include <fstream>
#include <sstream>
#include <map>
#include <vector>
#include <algorithm>
#include <assert.h>
#include <iostream>
#include <cmath>
#include <stdexcept>
#include <float.h>
#include <stdexcept>
#include <boost/math/distributions/binomial.hpp>
#include <boost/math/distributions/poisson.hpp>
#include <boost/random.hpp>
#include <boost/math/special_functions/gamma.hpp>

#define LOG
static int64_t MaxDist = 0;

static int64_t Trunc = 0;

/* for recording distribution into a Histogram, 
   Accur is the accuracy of transforming calculation */
template <class B = int64_t, class Accur = double>
class Histogram
{
	/* Histogram implemented by std::map */
	std::map<long, B> binsMap;
	/* Histogram implemented by std::vector */
	//std::vector<B> binsVec;
	std::vector<Accur> binsVec;
	/* Histogram implemented by std::vector, 
	   after fully-to-set-associative cache transformation */
	std::vector<Accur> binsTra;
	/* number of sampling */
	B samples;
	/* total number of hit references */
	B hits;
	/* cache miss rate */
	Accur missRate;

public:
	Histogram() : samples(0), hits(0), missRate(0.0) {};

	~Histogram() {};

	void clear();

	void sample(B x);

	bool mapToVector();
	/* complete the histogram with std::vector, to fast calculation. */
	bool mapToVector(B * buffer, int bufSize);

	bool mapToVector(std::vector<B> & buffer);
	/* use boost binomial distribution to do a fully-to-set-associative cache transformation */
	Accur fullyToSetAssoc(const int & cap, const int & blk, const int & assoc);
	/* use boost poisson distribution to do a fully-to-set-associative cache transformation */
	Accur calLruMissRatePoisson(const int & cap, const int & blk, const int & assoc);
	/* transform reuse distance distribution to stack distance distribution */
	void reuseDistToStackDist();

	void print(std::ofstream & file);
	/* calculate the miss rate for LRU set associative cache via cdf of binomial distribution */
	Accur calLruMissRate(const int & cap, const int & blk, const int & assoc);
	
	Accur calPlruMissRate(const int & cap, const int & blk, const int & assoc);
	/* calculate the miss rate for PLRU set associative cache, 
	   first do set-association transforming, then calculate hit function */
	Accur calMissRate(const int & cap, const int & blk, const int & assoc, const bool plru);
};

class Reader
{
public:
	Reader(std::ifstream & fin, std::ofstream & fout, int cap, int blk, int assoc);
};