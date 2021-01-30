% Code Author: Hao LI
% Code Function: Split Covariance Intersection Filter (Split CIF)
% Direct Reference:
% H. Li, F. Nashashibi and M. Yang, "Split Covariance Intersection Filter: Theory and Its Application to Vehicle Localization," IEEE Transactions on Intelligent Transportation Systems, vol. 14, no. 4, pp. 1860-1871
%
% Although the Split CIF is called "filter", its application is not limited to temporal recursive estimation;
% the Split CIF can be used as a pure data fusion method besides its filtering sense, just as the Kalman filter can also be treated as a data fusion method.
%
% Suppose {X1, P1i+P1d} is a complete estimate i.e. X1 = X_true
%         {X2, P2i+P2d} is a partial (or complete) estimate i.e. X2 = H * X_true
% For each estimate X in the split form, 
%     the "i" covariance part Pi represents the degree of X being independent, 
%     whereas the "d" part Pd represents its degree of being potentially correlated with other estimates. 
%
% Special cases of the Split CIF:
% Case 1: P1d = 0 matrix , P2d = 0 matrix
%     The Split CIF is simply reduced to the Kalman filter (KF);
%     So if you want to use the KF, then you can still use the Split CIF by simplying setting both P1d and P2d to zero matrices
% Case 2: P1i = 0 matrix , P2i = 0 matrix
%     The Split CIF is simply reduced to the Covariance Intersection (CI) fusion method; 
%     So if you want to use the CI, then you can still use the Split CIF by simplying setting both P1i and P2i to zero matrices
% Note: The Split CIF is a generalization of both the KF and the CI
function [X, Pi, Pd] = SplitCIF(X1, P1i, P1d, X2, P2i, P2d, H)
    I = eye(length(X1));
    numeric_eps = 0.00000000001;
    function val = DetP(w)
        if (w<numeric_eps)
            w = numeric_eps;
        elseif (w>1-numeric_eps)
            w = 1-numeric_eps;
        end
        P1 = P1d/w + P1i;
        P2 = P2d/(1-w) + P2i;
        K = P1*H'*inv(H*P1*H'+P2);
        P = (I-K*H)*P1;
        val = det(P);
    end

    % The w-optimization problem is theoretically guaranteed to be convex; one can refer to "On w-Optimization of the Split Covariance Intersection Filter" (https://arxiv.org/pdf/2101.10159.pdf) for proof. 
    % Therefore, some convex optimization technique which is accurate as well as efficient can be used to solve the w-optimization problem.
    % The golden section technique is adopted to search for the global optimal w under certain error tolerance (i.e. specified by "err_tol" in following code) 
    function w_opt = GetW_GoldenSection(P1i, P1d, P2i, P2d, H)
        if (trace(abs(P2d))<numeric_eps)
            w_opt = 1;
            return
            fprintf('No continuation\n');
        elseif (trace(abs(P1d))<numeric_eps)
            w_opt = 0;
            return
            fprintf('No continuation\n');
        end        
        wL = 0; fwL = DetP(wL);
        wR = 1; fwR = DetP(wR);
        sL = 0.382; fsL = DetP(sL);
        sR = 0.618; fsR = DetP(sR);
        err_tol = 0.00001;  % Already very accurate for many applications according to our engineering practice
        while(wR-wL>err_tol)
            if (fsL < fsR)
                wR = sR; fwR = fsR;
                sR = sL; fsR = fsL;
                sL = wL + 0.618*(sL-wL); fsL = DetP(sL);
            else
                wL = sL; fwL = fsL;
                sL = sR; fsL = fsR;
                sR = wR - 0.618*(wR-sR); fsR = DetP(sR);
            end
        end
        fmin = min([fwL, fsL, fsR, fwR]);
        if (fwL == fmin)
            w_opt = wL;
        elseif (fwR == fmin)
            w_opt = wR;
        else
            w_opt = (wL+wR)/2;
        end
    end

    w_opt = GetW_GoldenSection(P1i, P1d, P2i, P2d, H);
    if (w_opt<numeric_eps)
        w_opt = numeric_eps;
    elseif (w_opt>1-numeric_eps)
        w_opt = 1-numeric_eps;
    end
    P1 = P1d/w_opt + P1i;
    P2 = P2d/(1-w_opt) + P2i;
    K = P1*H'*inv(H*P1*H'+P2);
    X = X1 + K*(X2-H*X1);
    P = (I-K*H)*P1;
    Pi = (I-K*H)*P1i*(I-K*H)' + K*P2i*K';
    Pd = P-Pi;
end %% end whole function

