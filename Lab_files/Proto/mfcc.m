function output = mfcc(samples)

    % Args:
    %     samples: array of speech samples with shape (N,)
    %     winlen: lenght of the analysis window
    %     winshift: number of samples to shift the analysis window at every time step
    %     preempcoeff: pre-emphasis coefficient
    %     nfft: length of the Fast Fourier Transform (power of 2, >= winlen)
    %     nceps: number of cepstrum coefficients to compute
    %     samplingrate: sampling rate of the original signal
    %     liftercoeff: liftering coefficient used to equalise scale of MFCCs
    % 
    % Returns:
    %     N x nceps array with lifetered MFCC coefficients

    winlen = 400;
    winshift = 200;
    preempcoeff = 0.97;
    nfft = 512;
    nceps = 13;
    samplingrate = 20000;
    frames = enframe(samples, winlen, winshift)';
    preemph = preemp(frames, preempcoeff);
    windowed = windowing(preemph);
    spec = powerSpectrum(windowed, nfft);
    mspec = logMelSpectrum(spec, samplingrate);
    ceps = cepstrum(mspec, nceps);
    output = lifter_matlab(ceps);
end