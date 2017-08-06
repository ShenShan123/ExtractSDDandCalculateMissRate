// StackDistance.cpp : Defines the entry point for the console application.
//
#include "calcMissRate.h"

template <class B, class Accur>
void Histogram<B, Accur>::clear()
{
	binsVec.clear();
	binsTra.clear();
	samples = 0;
	hits = 0.0;
	missRate = 0.0;
}

#ifdef LOG2
template <class B, class Accur>
bool Histogram<B, Accur>::mapToVector(std::vector<B> & buffer)
{
	assert(buffer.size());
	/* reserve some memory */
	binsVec.reserve(MaxDist + 1);

	/* first bin is SD=0 */
	binsVec.push_back(buffer[0]);
	/* calculate the sum of all samples */
	samples = buffer[0];

	/* i is the index of buffer and starts from 1 */
	for (uint32_t i = 1; i < buffer.size(); ++i)
		/* fill up with 0 for the blank bins */
		if (!buffer[i])
			binsVec.resize(binsVec.size() + std::exp2(i - 1));
		else {
			for (int j = std::exp2(i - 1); j < std::exp2(i) && j <= MaxDist; ++j)
				binsVec.push_back((Accur)buffer[i] / std::exp2(i - 1));
			samples += buffer[i];
		}

		return binsVec.size() == MaxDist + 1;
}
#else
template <class B, class Accur>
bool Histogram<B, Accur>::mapToVector(std::vector<B> & buffer)
{
	assert(buffer.size());
	binsVec.clear();
	/* reserve some memory */
	binsVec.reserve(MaxDist + 1);
	//binsVec.reserve(Trunc + 1);
	samples = 0;

	if (Trunc == 0)
		for (int i = 0; i < buffer.size(); ++i) {
			binsVec.push_back((Accur)buffer[i]);
			samples += buffer[i];
		}
	/* if we define a truncation distance */
	else {
		for (int i = 0; i <= Trunc; ++i) {
			binsVec.push_back((Accur)buffer[i]);
			samples += buffer[i];
		}

		for (int i = Trunc + 1; i < buffer.size(); ++i) {
			binsVec[Trunc] += buffer[i];
			samples += buffer[i];
		}
	}
	if (!Trunc)
		return binsVec.size() == MaxDist + 1;
	else
		return binsVec.size() == Trunc + 1;
}
#endif

template <class B, class Accur>
void Histogram<B, Accur>::reuseDistToStackDist()
{
	std::vector<Accur> frac;
	B temp = 0;
	/* calculate the fraction of reuse distance
	is greater than i */
	for (int i = 0; i < binsVec.size(); ++i) {
		temp += binsVec[i];
		frac.push_back((Accur)(samples - temp) / samples);
	}

	std::vector<B> transTemp(binsVec);

	for (int i = 1; i < binsVec.size(); ++i) {
		Accur sumFrac = 0.0;
		for (int j = 1; j <= i; ++j)
			sumFrac += frac[j];
		/* now we use the probabilities in RD to transform into SD, F(r)=s */
		transTemp[(int) std::round(sumFrac)] += binsVec[i];
	}
	transTemp[0] = binsVec[0];

	binsVec.clear();
	binsVec = transTemp;
}

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

template <class B, class Accur>
Accur Histogram<B, Accur>::fullyToSetAssoc(const int & cap, const int & blk, const int & assoc)
{
	int setNum = cap / (blk * assoc);
	/* p is a probability of mapping to a specific set */
	Accur p = (Accur)1 / setNum;
	binsTra.clear();

	/* secureDist = log2(assoc),
	the least not evcited SD, called secure distance */
	int secureDist = log2p1(assoc) - 1;

	/* if a mem ref's SD <= secureDist, it is a cache hit, 
	   we don't need to transform these bar */
	for (int i = 0; i <= secureDist; ++i)
		binsTra.push_back(binsVec[i]);
	binsTra.resize(binsVec.size());

	try {
		/* transition of each bar */
		for (int i = secureDist + 1; i < binsVec.size(); ++i) {
			if (!binsVec[i]) continue;

			/* each bar j before the current, need to be added,
			it's a binomial distribution */
			boost::math::binomial binom(i, p);

			/* start from j=0, ref with SD >= assoc + secureDist is definitely miss in PLRU cache,
			   so we don't need to calculate these bars */
			for (int j = 0; j <= i && j < assoc + secureDist; ++j)
				binsTra[j] += binsVec[i] * boost::math::pdf(binom, (Accur)j);

			//for (int j = 0; j <= k; ++j)
			//	binsTra[log2p1(j)] += (Accur)binsVec[i] / std::exp2(i - 1) * boost::math::pdf(binom, (Accur)j);// shen
		}

		hits = 0;
		for (int i = 0; i < assoc; ++i) // shen
			hits += (B)std::round(binsTra[i]);
		return 1 - (Accur)hits / samples;
	}
	catch (std::exception e) {
		std::cout << e.what() << std::endl;
	}
}

template <class B, class Accur>
Accur Histogram<B, Accur>::calLruMissRatePoisson(const int & cap, const int & blk, const int & assoc)
{
	hits = 0;

	int setNum = cap / (blk * assoc);
	/* p is a probability of mapping to a specific set */
	Accur p = (Accur)1 / setNum;
	try {
		/* transition of each bar */
		for (int i = assoc; i < binsVec.size(); ++i) {
			if (!binsVec[i]) continue;

			/* each bar j before the current, need to be added,
			it's a binomial distribution */
			boost::math::poisson_distribution<Accur> pois(i * p);
			Accur q = boost::math::cdf(pois, (Accur)assoc - 1);
			hits += (B)std::round(binsVec[i] * q);
		}
	}
	catch (std::exception e) {
		std::cout << e.what() << std::endl;
	}

	/* if a mem ref's stack distance <= assoc - 1, it is a cache hit */
	for (int i = 0; i < assoc; ++i)
		hits += (B)std::round(binsVec[i]);

	missRate = 1 - (Accur)hits / samples;
	return missRate;
}

template <class B, class Accur>
Accur Histogram<B, Accur>::calLruMissRate(const int & cap, const int & blk, const int & assoc, const std::vector<double> & setDistr)
{
	hits = 0;

	int setNum = cap / (blk * assoc);
	/* p is a probability of mapping to a specific set */
	Accur p = (Accur)1 / setNum;

	try {
		for (int s = 0; s < setDistr.size(); ++s)
			/* we use cdf to calculate the probability that
		   	    other SDs will be less than assoc after transforming */
			for (int i = assoc; i < binsVec.size(); ++i) {
				boost::math::binomial binom(i, setDistr[s]);
				Accur q = boost::math::cdf(binom, (Accur)assoc - 1);
				hits += binsVec[i] * setDistr[s] * q;
			}
	}
	catch (std::exception e) {
		std::cout << e.what() << std::endl;
	}

	/* add up the SD < assoc fraction */
	for (int i = 0; i < assoc; ++i)
		hits += binsVec[i];

	missRate = 1 - (Accur)hits / samples;
	return missRate;
}

/* PLRU hit function is a piecewise linear function. */
template <class B, class Accur>
Accur Histogram<B, Accur>::calPlruMissRate(const int & cap, const int & blk, const int & assoc)
{
	fullyToSetAssoc(cap, blk, assoc);

	/* secureDist = log2(assoc),
	the least not evcited distance, called secure distance */
	int secureDist = log2p1(assoc) - 1;

	/* we assume that refs with SD <= secureDist are hits, SD > secureDist is a miss,
	   so the miss rate is SD(secureDist + 1) / sum(SD, secureDist + 1, 0). */
	Accur tempMisses = 0.0;
	Accur tempHits = 0.0;
	for (int i = 0; i <= secureDist; ++i)
		tempHits += binsTra[i];
	tempMisses = binsTra[secureDist + 1];
	Accur lastAccesMiss = tempMisses / (tempMisses + tempHits);

	//Accur tempMisses = 0.0;
	//Accur tempHits = 0.0;
	//for (int i = 0; i <= secureDist; ++i)
	//	tempHits += binsTra[i];
	//for (int i = secureDist + 1; i < assoc; ++i)
	//	tempMisses += binsTra[i];
	//Accur lastAccesMiss = tempMisses / (tempMisses + tempHits);

	int tempAssoc = assoc - 1;
	/* p1, a point with SD=secureDist+1 */
	Accur p1 = 1.0;
	/* 2^0 * 2^1 * ... * 2^(secureDist-1) / A(assoc-1, secureDist) */
	for (int i = 0; i < secureDist; ++i) {
		p1 *= (1 << i);
		p1 /= tempAssoc--;
	}
	/* the last ref is a miss */
	p1 *= lastAccesMiss;
	/* hit probability */
	p1 = 1 - p1;

	/* p2, a point with SD=assoc */
	Accur p2 = 1.0;
	/* accesses before current cousins */
	Accur front = 0.0;
	try {
		/* calculate the permutations */
		for (int j = 0; j < secureDist; ++j) {
			/* number of accesses in the serialization in same subtree */
			Accur cousins = (1 << j);
			/* tgammma_ratio(a, b) for (a-1)! / (b-1)! */
			p2 *= cousins * boost::math::tgamma_ratio(front + cousins, front + 1);
			front += cousins;
		}
		/* divide all possible permutation */
		p2 /= boost::math::tgamma((Accur)assoc);
		/* hit probability */
		p2 = 1 - p2;
	}
	catch (std::exception e) {
		std::cout << e.what() << std::endl;
	}

	hits = 0;
	/* the gradient of first piece */
	Accur k1 = (p2 - p1) / (assoc - secureDist - 1);
	for (int i = secureDist + 1; i <= assoc; ++i) {
		Accur y = k1 * (i - secureDist - 1) + p1;
		hits += y * binsTra[i];
		//std::cout << y << std::endl;
	}
	/* p3, with SD=assoc + assoc/2 - 2, hit probability */
	Accur p3 = 1 / (Accur)(assoc - 1);
	/* the gradient of second piece */
	Accur k2 = (p3 - p2) / (assoc / 2 - 2);
	for (int i = assoc + 1; i <= assoc * 3 / 2 - 2; ++i) {
		Accur y = k2 * (i - assoc) + p2;
		hits += y * binsTra[i];
		//std::cout << y << std::endl;
	}
	
	for (int i = 0; i <= secureDist; ++i)
		hits += binsTra[i];

	missRate = 1 - (Accur)hits / samples;
	return missRate;
}

/* to calculate C(a, k) / C(b, k) */
inline double combinationRatio(int b, int a, int k)
{
	if (b < a || !a || !b || !k)
		throw std::exception();
	
	/* This is for the condition that wouldn't occur. */
	if (k > a) return 0.0;


	int loops = b - a;
	double result = 1.0;
	while (loops--)
		result *= (double)(b - k) / (b--);

	if (result <= DBL_MIN)
		throw std::exception();

	return result;
}

template <class B, class Accur>
Accur Histogram<B, Accur>::calMissRate(const int & cap, const int & blk, const int & assoc, const bool plru, const std::vector<double> & setDistr)
{
	if (!plru)
		//return calLruMissRatePoisson(cap, blk, assoc);
		return calLruMissRate(cap, blk, assoc, setDistr);
	else
		return calPlruMissRate(cap, blk, assoc);
}

template <class B, class Accur>
void Histogram<B, Accur>::print(std::ofstream & file)
{}

Reader::Reader(std::ifstream & fin, std::ofstream & fout, int cap, int blk, int assoc) {
	Histogram<int64_t> histogram;
	int binSize = DOLOG(MaxDist) + 1;
	std::vector<int64_t> buffer(binSize);
	int64_t * line = new int64_t[MAXSETNUM];

	/* read the set distribution */
	fin.read((char *)line, MAXSETNUM * sizeof(int64_t));
	int setNum = cap / (blk * assoc);
	std::vector<double> setDistribution(setNum, 0.0);
	int64_t total = 0;
	/* calculate set distribution for this cache configuration */
	for (int i = 0; i < MAXSETNUM; ++i) {
		setDistribution[i & (setNum - 1)] += (double)line[i];
		total += line[i];
	}

	delete [] line;

	/* print set distribution */
	for (int i = 0; i < setNum; ++i) {
		fout << setDistribution[i] << " ";
		setDistribution[i] /= (double) total;
	}
	fout << std::endl;

	line = new int64_t[binSize];
	/* read the SDD */
	while (!fin.eof()) {
		fin.read((char *)line, binSize * sizeof(int64_t));

		if (line[binSize - 1] < 0)
			break;

		for (int i = 0; i < binSize; ++i)
			buffer[i] += line[i];
	}

	//for (int i = 0; i < binSize; ++i)
	//	std::cout << buffer[i] << " ";
	delete[] line;
	/* save line bins into histogram */
	bool succ = histogram.mapToVector(buffer);
	assert(succ);

	double lruMissRate = histogram.calMissRate(cap, blk, assoc, false, setDistribution);
	//double lruTraMissRate = histogram.fullyToSetAssoc(cap, blk, assoc);
	//double plruMissRate = histogram.calMissRate(cap, blk, assoc, true);
	//fout << "estimated_miss_rate " << std::setprecision(6) << lruMissRate << std::endl;
	fout.close();
	std::cout << std::setprecision(6) << lruMissRate << std::endl; //" " << lruTraMissRate << std::endl;
}

int main(int argc, char *argv[])
{
	std::ifstream fin;
	std::ofstream fout;
	/* truncation distance */
	std::string missBar(argv[4]);
	MaxDist = std::stol(missBar, nullptr);
	/* input file path */
	std::string pathIn(argv[5]);
	fin.open(pathIn, std::ios::binary | std::ios::in);
	/* output file path */
	std::string pathOut(argv[6]);
	fout.open(pathOut, std::ios::out | std::ios::app);
	if (fin.fail() || fout.fail()) {
		std::cout << "SDD file or output file openning failed! " << std::endl;
		return 0;
	}
	/* cache config */
	std::string capstr(argv[1]);
	std::string blkstr(argv[2]);
	std::string assocstr(argv[3]);
	int cap = std::stoi(capstr);
	int blk = std::stoi(blkstr);
	int assoc = std::stoi(assocstr);
	//std::cout << "cache capacity " << cap << "\nblock size " << blk << "\nassociativity " << assoc \
	<< "\ntruncation distance " << MaxDist << "\ninput file " << pathIn << "\noutput file " << pathOut \
	<< std::endl;

	Reader reader(fin, fout, cap, blk, assoc);
 	return 0;
}