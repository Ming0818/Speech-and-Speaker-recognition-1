function output = preemp(input, a)
  
%    Pre-emphasis filter.
%    Args:
%        input: array of speech frames [N x M] where N is the number of frames and
%               M the samples per frame
%        p: preemhasis factor (defaults to the value specified in the exercise)
%    Output:
%        output: array of pre-emphasised speech samples
%    Note (you can use the function lfilter from scipy.signal)
%  
% Parameters definition 
A = 1;
B = [1, -a];

output = filter(B, A, input);

end