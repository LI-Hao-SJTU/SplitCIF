% Code Author: Hao LI
% Code Function: Demo for the usage of the Split Covariance Intersection Filter (Split CIF)

format compact; format short;

fprintf('Demo for the usage of the Split Covariance Intersection Filter (Split CIF)\n');
fprintf('==========================================================================\n');
fprintf('PART I: Demo for general cases\n');
fprintf('Demo 1: Fuse source estimates of same dimension\n');
X1 = [2;2;1]; 
P1i = [4, 0, 1; 0, 4, 0; 1, 0, 4];
P1d = diag([4,4,4]);
H = eye(3); % identity matrix
X2 = [-4;-4;-2]; 
P2i = [8, 0, 2; 0, 8, 0; 2, 0, 8];
P2d = diag([4,4,4]);

[X, Pi, Pd] = SplitCIF(X1, P1i, P1d, X2, P2i, P2d, H);
fprintf('[X1, P1i, P1d] = '); [X1, P1i, P1d]
fprintf('[X2, P2i, P2d] = '); [X2, P2i, P2d]
fprintf('[X, Pi, Pd] = '); [X, Pi, Pd]

fprintf('Demo 2: Fuse source estimates of different dimensions\n');
X1 = [2;2;1]; 
P1i = [4, 0, 1; 0, 4, 0; 1, 0, 4];
P1d = diag([4,4,4]);
H = [1 0 0; 0 1 0]; 
X2 = [-4;-4]; 
P2i = diag([4,4]); P2d = diag([1,1]);

[X, Pi, Pd] = SplitCIF(X1, P1i, P1d, X2, P2i, P2d, H);
fprintf('[X1, P1i, P1d] = '); [X1, P1i, P1d]
fprintf('[X2, P2i, P2d, H] = '); [X2, P2i, P2d, H]
fprintf('[X, Pi, Pd] = '); [X, Pi, Pd]

fprintf('Press any key to continue ...\n');
pause

fprintf('==========================================================================\n');
fprintf('PART II: Demo for special case 1 (reduced to the Kalman filter)\n');
fprintf('Demo 1: Fuse source estimates of same dimension\n');
X1 = [2;2;1]; 
P1i = [4, 0, 1; 0, 4, 0; 1, 0, 4];
P1d = zeros(3,3);
H = eye(3); % identity matrix
X2 = [-4;-4;-2]; 
P2i = [8, 0, 2; 0, 8, 0; 2, 0, 8];
P2d = zeros(3,3);

[X, Pi, Pd] = SplitCIF(X1, P1i, P1d, X2, P2i, P2d, H);
fprintf('[X1, P1i, P1d] = '); [X1, P1i, P1d]
fprintf('[X2, P2i, P2d] = '); [X2, P2i, P2d]
fprintf('[X, Pi, Pd] = '); [X, Pi, Pd]

fprintf('Demo 2: Fuse source estimates of different dimensions\n');
X1 = [2;2;1]; 
P1i = [4, 0, 1; 0, 4, 0; 1, 0, 4];
P1d = zeros(3,3);
H = [1 0 0; 0 1 0]; 
X2 = [-4;-4]; 
P2i = diag([4,4]); P2d = zeros(2,2);

[X, Pi, Pd] = SplitCIF(X1, P1i, P1d, X2, P2i, P2d, H);
fprintf('[X1, P1i, P1d] = '); [X1, P1i, P1d]
fprintf('[X2, P2i, P2d, H] = '); [X2, P2i, P2d, H]
fprintf('[X, Pi, Pd] = '); [X, Pi, Pd]

fprintf('Press any key to continue ...\n');
pause

fprintf('==========================================================================\n');
fprintf('PART III: Demo for special case 2 (reduced to the covariance intersection)\n');
fprintf('Demo 1: Fuse source estimates of same dimension\n');
X1 = [2;2;1]; 
P1i = zeros(3,3);
P1d = diag([4,4,4]);
H = eye(3); % identity matrix
X2 = [-4;-4;-2]; 
P2i = zeros(3,3);
P2d = diag([8,4,2]);

[X, Pi, Pd] = SplitCIF(X1, P1i, P1d, X2, P2i, P2d, H);
fprintf('[X1, P1i, P1d] = '); [X1, P1i, P1d]
fprintf('[X2, P2i, P2d] = '); [X2, P2i, P2d]
fprintf('[X, Pi, Pd] = '); [X, Pi, Pd]

fprintf('Demo 2: Fuse source estimates of different dimensions\n');
X1 = [2;2;1];
P1i = zeros(3,3);
P1d = [4, 0, 1; 0, 4, 0; 1, 0, 4];
H = [1 0 0; 0 1 0]; 
X2 = [-4;-4]; 
P2i = zeros(2,2); P2d = diag([1,2]);

[X, Pi, Pd] = SplitCIF(X1, P1i, P1d, X2, P2i, P2d, H);
fprintf('[X1, P1i, P1d] = '); [X1, P1i, P1d]
fprintf('[X2, P2i, P2d, H] = '); [X2, P2i, P2d, H]
fprintf('[X, Pi, Pd] = '); [X, Pi, Pd]

fprintf('==========================================================================\n');
fprintf('End of the Split CIF demo\n');