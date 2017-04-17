function fbank = trfbank(fs, nfft)
    
    % Inputs:
    % fs:         sampling frequency (rate)
    % nfft:       length of the fft
    % lowfreq:    frequency of the lowest filter
    % linsc:      scale for the linear filters
    % logsc:      scale for the logaritmic filters
    % nlinfilt:   number of linear filters
    % nlogfilt:   number of log filters
    % 
    % Outputs:
    % res:  array with shape [N, nfft], with filter amplitudes for each column.
    %         (N=nlinfilt+nlogfilt)
    %Total number of filters
    
    %Variables
    format long;
    lowfreq = 133.33;
    linsc = 200/3.;
    logsc = 1.0711703;
    nlinfilt = 13; 
    nlogfilt = 27; 
    equalareas = false;
    nfilt = nlinfilt + nlogfilt;

    %------------------------
    % Compute the filter bank
    %------------------------
    % Compute start/middle/end points of the triangular filters in spectral
    % domain
    freqs = zeros(1,nfilt+2);
    freqs(1:(nlinfilt)) = lowfreq + (0:nlinfilt-1) * linsc;
    freqs(nlinfilt+1:end) = freqs(nlinfilt) * logsc .^(1:(nlogfilt + 2));
    if equalareas
        heights = ones(1:nfilt);
    else
        heights = 2./(freqs(3:end) - freqs(1:(size(freqs,2)-2)));
    end
    % Compute filterbank coeff (in fft domain, in bins)
    fbank = zeros(nfilt, nfft);
    % FFT bins (in Hz)
    nfreqs = (0:nfft-1) / (1. * nfft) * fs;
    for i = 1:nfilt
        low = freqs(i);
        cen = freqs(i+1);
        hi = freqs(i+2);
    
        lid = (floor(low * nfft / fs)+2):(floor(cen * nfft / fs)+1);
        lslope = heights(i) / (cen - low);
        rid = (floor(cen * nfft / fs)+2):(floor(hi * nfft / fs)+1);
        rslope = heights(i) / (hi - cen);
        fbank(i,lid) = lslope * (nfreqs(lid) - low);
        fbank(i,rid) = rslope * (hi - nfreqs(rid));
    end
end