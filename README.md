# Split Covariance Intersection Filter (SplitCIF)

Matlab demo code for implementation and usage of the Split Covariance Intersection Filter (Split CIF) is given in this repository. The _SplitCIF.m_ file instantiates the Split CIF algorithm in Matlab code and can be used directly by readers in their own Matlab code. Besides, the _SplitCIF.m_ file can also serve as a guide for readers to instantiate the Split CIF algorithm in other programming languages such as C/C++, Java, Python etc. The _demoSplitCIF.m_ file which invokes _SplitCIF.m_ serves as demo code for usage of the Split CIF.

The direct reference of this repository works is [1] which provides a theoretical foundation for the Split CIF. A reference closely related to [1] is [2] which presents the Split CIF heuristically without theoretical analysis. __One can refer to [1] for details of the Split CIF__. For using and referring to this repository works, __please cite both [1] and [2]__.

__[1] H. Li, F. Nashashibi and M. Yang, "Split Covariance Intersection Filter: Theory and Its Application to Vehicle Localization," IEEE Transactions on Intelligent Transportation Systems, vol. 14, no. 4, pp. 1860-1871, 2013__

__[2] S.J. Julier, J.K. Uhlmann, “General decentralized data fusion with covariance intersection (CI)”, Chapter 12, D. Hall, J. Llinas (Eds.), Handbook of Data Fusion, CRC Press, Boca Raton FL USA, 2001__

A complementary note that provides convexity analysis of the w-optimization problem is given by

__[3] H. Li, "On w-optimization of the split covariance intersection filter", arXiv__

https://browse.arxiv.org/pdf/2101.10159.pdf

## Notes:

The Split CIF is coined originally as "split covariance intersection" in [2]. __In [1], the term "filter" is added to form an analogy of the Split CIF to the well-known Kalman filter__. Although the Split CIF is called "filter", its application is not limited to temporal recursive estimation; __the Split CIF can be used as a pure data fusion method besides its filtering sense__, just as the Kalman filter can also be treated as a data fusion method.

For each estimate __X__ in the split form, the "i" covariance part __Pi__ represents the degree of __X__ being independent, whereas the "d" part __Pd__ represents its degree of being potentially correlated with other estimates. 

__Special cases of the Split CIF:__

Case 1: __P1d = 0__ matrix , __P2d = 0__ matrix. 
The Split CIF is simply reduced to the Kalman filter (KF); So if you want to use the KF, then you can still use the Split CIF by simplying setting both __P1d__ and __P2d__ to zero matrices

Case 2: __P1i = 0__ matrix , __P2i = 0__ matrix.
The Split CIF is simply reduced to the Covariance Intersection (CI) fusion method; So if you want to use the CI, then you can still use the Split CIF by simplying setting both __P1i__ and __P2i__ to zero matrices

The Split CIF is a generalization of both the KF and the CI.
