% The function tests given realization X of random process Xi(t) for
% stationary, using of the specified two non-parametric criterions - the criterion of inversion
% and the criterion of the series. The syntax is:
%
% checkstationary(X,N,alpha,method), where:
%     X is a vector-column with random data of given realization;
%
%     N is an interval of observation;
%     For the criterion of series N must have one value from the following vector:
%     [10 12 14	16 18 20 22 24 26 28 30 32 36 40 50 60 70 80 90 100	
%      110 120 130 140 150 160 170 180 190 200]
%     For the criterion of inversion N must have one value from the following vector:
%     [0 10 12 14 16 18 20 30 40 50 60 70 80 90 100];
% 
%
%     alpha is a level of signification; alpha must be one from the
%     following numbers - 0.02, 0.05, 0.1, i.e respectively 2%, 5%, 10%;
%
%
%     method is the input variable, pointing which method is used when evaluated the hypothesis for
%     stationarity. If you choose 1, the function will use the criterion of series, if you choose 
%     2, the function will use the criterion of inversion.
%
%
% Example:
% The interval of acceptance using criterion of series for our hypothesis that the 
% data has monotonic trend is between:
%     86
%
% and
%    115
%
% The mean of data has not a monotonic trend.
% The variance of data has not a monotonic trend.
% You can discard the hypothesis, that this sequence of random data has monotonic trend, i.e.
% it is non-stationary.
% 
%
%
% If you find any bug, the author will be very glad to report for it on the
% following e-mail address: zlatkopetrov@yahoo.com.
% Any comments and suggestions would be accepted with appreciation. 
% 
%
%
% Author: Zlatko Petroff, May 23, 2004
% Last Revision July 30, 2004
%


function [h_ss] = checkstationary(X,N,alpha,method)
if nargin==0, help checkstationary
    return;
end
if nargin~=4
    error('Wrong syntax of the function. View the help for the right syntax.')
end
if (method~=1 && method~=2)
    error('You did not select appropriate method. Type help checkstationary to view the appropriate one.')
end
if method==2 % method of inversion is selected
    NN=[0 10 12 14 16 18 20 30 40 50 60 70 80 90 100];
    k=find(NN==N);
    kk=isempty(k);
    if kk==1;
        error('The value for the intervals of observation is not an appropriate number. See help for additional information.')
    end
else
    NN=2*[5 6 7 8 9 10 11 12 13 14 15 16 18 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100];
    k=find(NN==N, 1);
    kk=isempty(k);
    if kk==1;
        error('The value for the intervals of observation is not an appropriate number. See help for additional information.')
    end
end

if (alpha ~= 0.1 && alpha ~= 0.05 && alpha ~= 0.02)
    error('You must to insert an appropriate value for alpha. Check in the help for such one.')
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Partition X of N equal intervals and computation of the values for the means and the    % 
%   variance of the equal intervals X                                                       %       
l = length(X);
li = l/N; li = floor(li);
for j=1:N;    
        y=X(((j-1)*li+1):(j*li));   
        mean_value(j)=mean(y); % computation of the values for the means of the equal intervals X  
        variance(j)=var(y);    % computation of the values for the variance of the equal intervals X
end
j = 1:N;


figure();
plot(j,mean_value,'--rs','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',8)
xlabel('Interval of observation','interpreter','latex','fontsize',14);
title('Trend of the mean','interpreter','latex','fontsize',14);
ylabel('Mean','interpreter','latex','fontsize',14);
figure();
plot(j,variance,'--rs','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',8)
title('Trend of the variance','interpreter','latex','fontsize',14);
xlabel('Interval of observation','interpreter','latex','fontsize',14);
ylabel('Variance','interpreter','latex','fontsize',14);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Checking which method is selected                                  % 
if method==2 % method of inversion is selected
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  Computation of number of inversion for mean and variance                  %
inversion_of_mean = 0;
for i = 1:N;
    for j = (i+1):N;
        if      mean_value(i) > mean_value(j);
                h(i) = 1;
                inversion_of_mean = inversion_of_mean + h(i);
            else    h(i) = 0;
                inversion_of_mean = inversion_of_mean + h(i);
          end
    end
end

inversion_of_variance = 0;
for i = 1:N;
    for j = (i+1):N;
        if      variance(i) > variance(j);
                h(i) = 1;
                inversion_of_variance = inversion_of_variance + h(i);
            else    h(i) = 0;
                inversion_of_variance = inversion_of_variance + h(i);
          end
    end
end
disp('The number of inversion for the mean is:')
disp(inversion_of_mean)
disp('The number of inversion for the variance is:')
disp(inversion_of_variance)
% the number of inversion of mean is the scalar inversion_of_mean
%the number of inversion of variance is the scalar inversion_of_variance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Check if the computed numbers for the inversions are in the area of acceptance       % 
B = [  0     0.99  0.975   0.95    0.05   0.025  0.01
       10       9     11     13     31     33     35
       12      16     18     21     44     47     49
       14      24     27     30     60     63     66 
       16      34     38     41     78     81     85
       18      45     50     54     98    102    107
       20      59     64     69    120    125    130
       30     152    162    171    263    272    282
       40     290    305    319    460    474    489
       50     473    495    514    710    729    751
       60     702    731    756   1013   1038   1067
       70     977   1014   1045   1369   1400   1437
       80    1299   1344   1382   1777   1815   1860
       90    1668   1721   1766   2238   2283   2336
       100   2083   2145   2198   2751   2804   2868];
   
BN = B(:,1);
IndexN = find(BN==N);
k1 = 1-alpha/2;
k2 = alpha/2;
BN = B(1,:);
Indexk1 = find(BN==k1);
Indexk2 = find(BN==k2);
left_border = B(IndexN,Indexk1);
right_border = B(IndexN,Indexk2);
disp('The interval of acceptance for our hypothesis that the data has monotonic trend is between:')
disp (left_border); disp('and');  disp(right_border)           
if (inversion_of_mean > left_border & inversion_of_mean <= right_border);      
    km = 1;
    disp('The mean of data has a monotonic trend.')
else  km = 0;
    disp('The mean of data has not a monotonic trend.')
end
if (inversion_of_variance > left_border & inversion_of_variance <= right_border);      
    kv = 1;
    disp('The variance of data has a monotonic trend.')
else  kv = 0;
    disp('The variance of data has not a monotonic trend.')
end
if (km == 1 & kv == 1);      
   disp('You can accept the hypothesis, that this sequence of random data has monotonic trend, i.e. it is stationary.')
else disp('You can discard the hypothesis, that this sequence of random data has monotonic trend, i.e. it is non-stationary.')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else %method of series is selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                      Criterion of series                                  %
median_mean = median(mean_value);
median_variance = median(variance);
series_m=0;
series_v=0;
for i=1:N;
    if mean_value(i) >= median_mean;
        hm(i) = 1;
    else hm(i) = 0;
    end
end
for i=1:N-1;
    if hm(i)~=hm(i+1);
        series_m=series_m+1;
    else series_m=series_m;
    end
end
for i=1:N;
    if variance(i) >= median_variance;
        hv(i) = 1;
    else hv(i) = 0;
    end
end
for i=1:N-1;
    if hv(i)~=hv(i+1);
        series_v=series_v+1;
    else series_v=series_v;
    end
end
disp('The number of series for the mean is:')
disp(series_m)
disp('The number of series for the variance is:')
disp(series_v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Check if the computed values for the numbers of series is in the intervals of acceptance % 
n=N/2;
B= [0  0.99  0.975 0.95 0.05 0.025  0.01
    5    2     2     3    8     9     9
    6    2     3     3   10    10     11
    7    3     3     4   11    12     12
    8    4     4     5   12    13     13
    9    4     5     6   13    14     15
   10    5     6     6   15    15     16
   11    6     7     7   16    16     17
   12    7     7     8   17    18     18
   13    7     8     9   18    19     20
   14    8     9    10   19    20     21
   15    9    10    11   20    21     22
   16   10    11    11   22    22     23 
   18   11    12    13   24    25     26
   20   13    14    15   26    27     28
   25   17    18    19   32    33     34
   30   21    22    24   37    39     40
   35   25    27    28   43    44     46 
   40   30    31    33   48    50     51
   45   34    36    37   54    55     57
   50   38    40    42   59    61     63
   55   43    45    46   65    66     68
   60   47    49    51   70    72     74
   65   52    54    56   75    77     79
   70   56    58    60   81    83     85 
   75   61    63    65   86    88     90
   80   65    68    70   91    93     96
   85   70    72    74   97    99    101
   90   74    77    79  102   104    107
   95   79    82    84  107   109    112
  100   84    86    88  113   115    117];
   
BN = B(:,1);
IndexN = find(BN==n);
k1 = 1-alpha/2;
k2 = alpha/2;
BN = B(1,:);
Indexk1 = BN==k1;
Indexk2 = BN==k2;
left_border = B(IndexN,Indexk1);
right_border = B(IndexN,Indexk2);
disp('The interval of acceptance using criterion of series for our hypothesis that the data has monotonic trend is between:')
disp (left_border); disp('and');  disp(right_border)           
if (series_m > left_border && series_m <= right_border);      
    km = 1;
    disp('The mean of data has a monotonic trend.')
else  km = 0;
    disp('The mean of data has not a monotonic trend.')
end
if (series_v > left_border && series_v <= right_border);      
    kv = 1;
    disp('The variance of data has a monotonic trend.')
else  kv = 0;
    disp('The variance of data has not a monotonic trend.')
end
if (km == 1 && kv == 1);      
   disp('You can accept the hypothesis, that this sequence of random data has monotonic trend, i.e. it is stationary.')
    
else 
    disp('You can discard the hypothesis, that this sequence of random data has monotonic trend, i.e. it is non-stationary.')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end