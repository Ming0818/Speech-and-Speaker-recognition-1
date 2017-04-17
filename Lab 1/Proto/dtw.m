function output = dtw(localdist)

%     Args:
%       localdist: array NxM of local distances computed between two sequences
%                of length N and M respectively
%     Output:
%       globaldist: scalar, global distance computed by Dynamic Time Warping
%      [N, M] = size(localdist);
%     Accumulator = zeros(N+1, M+1);
%     Accumulator(1,1) = localdist(1,1);
%     for i=2:N+1
%         off = localdist(i-1,1);
%         Accumulator(i,1) = Accumulator(i-1,1) + off;
%     end
%     for j = 2:M+1
%         off = localdist(1,j-1);
%         Accumulator(1,j) = Accumulator(1,j-1) + off;
%     end
%     for i = 2:N+1
%         for j = 2:M+1
%             off = localdist(i-1,j-1);
%             Accumulator(i,j) = min( [Accumulator(i-1,j), Accumulator(i-1,j-1), Accumulator(i,j-1)]) + off;
%         end
%     end
%     output = Accumulator(N+1,M+1);
    [N, M] = size(localdist);
    Accumulator = zeros(N+1,M+1);
    Accumulator(1,1) = 0;
    for i=2:N+1
        Accumulator(i,1) = inf;
    end
    for j = 2:M+1
        Accumulator(1,j) = inf;
    end
    for i = 2:N+1
        for j = 2:M+1
            off = localdist(i-1,j-1);
            Accumulator(i,j) = min( [Accumulator(i-1,j), Accumulator(i-1,j-1), Accumulator(i,j-1)]) + off;
        end
    end
output = Accumulator(N+1,M+1);