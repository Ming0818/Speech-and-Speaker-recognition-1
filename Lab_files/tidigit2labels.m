function labels = tidigit2labels(tidigitsarray)
    
    % Return a list of labels including gender, speaker, digit and repetition information for each
    % utterance in tidigitsarray. Useful for plots.
    
    labels = []
    nex = size(tidigitsarray,2)
    for ex = 1:nex
        labels = [labels;[tidigitsarray{1,ex}.gender(1),'-', ...
            tidigitsarray{1,ex}.speaker,'-',tidigitsarray{1,ex}.digit,...
            '-',tidigitsarray{1,ex}.repetition]];
    end