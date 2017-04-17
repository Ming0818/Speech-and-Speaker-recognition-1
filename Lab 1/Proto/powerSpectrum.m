function output = powerSpectrum(input, nfft)

    % Calculates the power spectrum of the input signal, that is the square of the modulus of the FFT
    % 
    % Args:
    %     input: array of speech samples [N x M] where N is the number of frames and
    %            M the samples per frame
    %     nfft: length of the FFT
    % Output:
    %     array of power spectra [N x nfft]
    % Note: you can use the function fft from scipy.fftpack
    freq = fft(input, nfft);
    output = abs(freq).^2;

end