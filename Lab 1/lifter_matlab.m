function output = lifter_matlab(mfcc)
    % 
    % Applies liftering to improve the relative range of MFCC coefficients.
    % 
    %    mfcc: NxM matrix where N is the number of frames and M the number of MFCC coefficients
    %    lifter: lifering coefficient
    % 
    % Returns:
    %    NxM array with lifeterd coefficients
    lifter = 22;
    [nframes, nceps] = size(mfcc);
    cepwin = 1.0 + lifter/2.0 * sin(pi * (0:nframes-1) / lifter);
    cepwin = repmat(cepwin,nceps,1);

    output = mfcc.*cepwin';
end
