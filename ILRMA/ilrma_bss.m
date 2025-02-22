%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sample program for blind source separation using independent low-rank   %
% matrix analysis (ILRMA)                                                 %
%                                                                         %
% Coded by D. Kitamura (d-kitamura@ieee.org) on 1 Apr, 2018 (ver1.0).     %
%                                                                         %
% Copyright 2018 Daichi Kitamura                                          %
%                                                                         %
% These programs are distributed only for academic research at            %
% universities and research institutions.                                 %
% It is not allowed to use or modify these programs for commercial or     %
% industrial purpose without our permission.                              %
% When you use or modify these programs and write research articles,      %
% cite the following references:                                          %
%                                                                         %
% # Original paper (The algorithm was called "Rank-1 MNMF" in this paper) %
% D. Kitamura, N. Ono, H. Sawada, H. Kameoka, H. Saruwatari, "Determined  %
% blind source separation unifying independent vector analysis and        %
% nonnegative matrix factorization," IEEE/ACM Trans. ASLP, vol. 24,       %
% no. 9, pp. 1626-1641, September 2016.                                   %
%                                                                         %
% # Book chapter (The algorithm was renamed as "ILRMA")                   %
% D. Kitamura, N. Ono, H. Sawada, H. Kameoka, H. Saruwatari, "Determined  %
% blind source separation with independent low-rank matrix analysis,"     %
% Audio Source Separation. Signals and Communication Technology.,         %
% S. Makino, Ed. Springer, Cham, pp. 125-155, March 2018.                 %
%                                                                         %
% See also:                                                               %
% http://d-kitamura.net                                                   %
% http://d-kitamura.net/en/demo_rank1_en.htm                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x_demixed, W] = ilrma_bss(x_mixed, it, fftSize, nBases, nSources, W)

% Set parameters
seed = 1; % pseudo random seed
refMic = 1; % reference microphone for back projection
% ns = size(x_mixed, 2); % number of sources
% fftSize = 4096; % window length in STFT [points]
shiftSize = fftSize / 2; % 2048; % shift length in STFT [points]
% nb = 10; % number of bases (for type=1, nb is # of bases for "each" source. for type=2, nb is # of bases for "all" sources)
% it = 100; % number of iterations (define by checking convergence behavior with drawConv=true)
type = 1; % 1 or 2 (1: ILRMA w/o partitioning function, 2: ILRMA with partitioning function)
drawConv = false; % true or false (true: plot cost function values in each iteration and show convergence behavior, false: faster and do not plot cost function values)
normalize = false; % true or false (true: apply normalization in each iteration of ILRMA to improve numerical stability, but the monotonic decrease of the cost function may be lost. false: do not apply normalization)

% Fix random seed
RandStream.setGlobalStream(RandStream('mt19937ar','Seed',seed))

% Blind source separation based on ILRMA
if exist('W','var')
    [x_demixed, cost, W] = bss_ILRMA(x_mixed,nSources,nBases,fftSize,shiftSize,it,type,refMic,drawConv,normalize,W);
else
    [x_demixed, cost, W] = bss_ILRMA(x_mixed,nSources,nBases,fftSize,shiftSize,it,type,refMic,drawConv,normalize);
end

end