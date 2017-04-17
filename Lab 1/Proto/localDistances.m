function output = localDistances(ut1, ut2)
    
    % Compute Euclidean distance between two uterances
    % 
    % Args:
    %     ut1 and ut2 the two utterances of size N and M
    % Output:
    %     Matrix [N x M] with the euclidean distance between each vector
    
    N = size(ut1,1);
    M = size(ut2,1);
    output = zeros(N, M);
    for i= 1:N
        for j = 1:M
            output(i,j) = norm(ut1(i,:) - ut2(j,:));
        end
    end
    