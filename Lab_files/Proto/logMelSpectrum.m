function [output, filterBank] = logMelSpectrum(input, samplingrate)
    
    % Calculates the log output of a Mel filterbank when the input is the power spectrum
    % 
    % Args:
    %     input: array of power spectrum coefficients [N x nfft] where N is the number of frames and
    %            nfft the length of each spectrum
    %     samplingrate: sampling rate of the original signal (used to calculate the filterbank shapes)
    % Output:
    %     array of Mel filterbank log outputs [N x nmelfilters] where nmelfilters is the number
    %     of filters in the filterbank
    % Note: use the trfbank function provided in tools.py to calculate the filterbank shapes and
    %       nmelfilters
    [nfft,~] = size(input);
    filterBank = trfbank(samplingrate, nfft);
    output = log( filterBank * input );
end
    