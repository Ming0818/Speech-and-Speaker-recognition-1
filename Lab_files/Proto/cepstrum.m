function output =  cepstrum(input, nceps)
    
    %Calulates Cepstral coefficients from mel spectrum applying Discrete Cosine Transform
    %
    %Args:
    %    input: array of log outputs of Mel scale filterbank [N x nmelfilters] where N is the
    %           number of frames and nmelfilters the length of the filterbank
    %    nceps: number of output cepstral coefficients
    %Output:
    %    array of Cepstral coefficients [N x nceps]
    %Note: you can use the function dct from scipy.fftpack.realtransforms
    output = dct(input);
    output = output(1:nceps,:);
end