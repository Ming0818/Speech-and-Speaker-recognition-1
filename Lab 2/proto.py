import numpy as np
from tools2 import *

def gmmloglik(log_emlik, weights):
    """Log Likelihood for a GMM model based on Multivariate Normal Distribution.

    Args:
        log_emlik: array like, shape (N, K).
            contains the log likelihoods for each of N observations and
            each of K distributions
        weights:   weight vector for the K components in the mixture

    Output:
        gmmloglik: scalar, log likelihood of data given the GMM model.
    """
    # log_emlik is of size NxK with N the number of windows in the utterance and K the number of possible states. 
    # weights is of size Kx1 and stores the weights of every possible state. 
    # Then if we do the matrix multiplication log_emlik x weights we have the likelihood of each window N. 
    win_lik = np.dot( np.exp(log_emlik), weights) 
    
    # We want it in the log scale, as we are calculating the log likelihood
    win_log_lik = np.log(win_lik)
    
    # The output has to be the scalar that express the total likelihood of the current utterance, then
    return np.sum(win_log_lik)


def forward(log_emlik, log_startprob, log_transmat):
    """Forward probabilities in log domain.

    Args:
        log_emlik: NxM array of emission log likelihoods, N frames, M states
        log_startprob: log probability to start in state i
        log_transmat: log transition probability from state i to j

    Output:
        forward_prob: NxM array of forward log probabilities for each of the M states in the model
    """
    N, M = log_emlik.shape
    forward_prob = np.zeros([N, M])
    for j in range(M):
        forward_prob[0, j] = log_startprob[j] + log_emlik[0, j]

    for i in range(1, N):
        for j in range(M):
            forward_prob[i, j] = logsumexp( forward_prob[i-1] +  log_transmat[:, j] ) + log_emlik[i, j]

    return forward_prob

def backward(log_emlik, log_startprob, log_transmat):
    """Backward probabilities in log domain.

    Args:
        log_emlik: NxM array of emission log likelihoods, N frames, M states
        log_startprob: log probability to start in state i
        log_transmat: transition log probability from state i to j

    Output:
        backward_prob: NxM array of backward log probabilities for each of the M states in the model
    """
    N, M = log_emlik.shape
    backward_prob = np.zeros([N, M])

    for n in range(N-2, -1, -1):
        for i in range(M):
            backward_prob[n, i] = logsumexp( log_transmat[i, :] + log_emlik[n+1, :] + backward_prob[n+1, :])

    return backward_prob

def viterbi(log_emlik, log_startprob, log_transmat):
    """Viterbi path.

    Args:
        log_emlik: NxM array of emission log likelihoods, N frames, M states
        log_startprob: log probability to start in state i
        log_transmat: transition log probability from state i to j

    Output:
        viterbi_loglik: log likelihood of the best path
        viterbi_path: best path
    """
    N, M = log_emlik.shape
    
    # The viterbi path has to have the same lenght as the number of frames in the utterance, as the path evolves in the same 
    # direction of the sound
    viterbi_path = np.zeros([N,])
    
    # We declare V as in the formulas of the lab notes
    V = np.zeros([N, M])
    
    # We declare B as in the formulas of the lab notes, to determine the best path
    B = np.zeros([N, M])

    # For every state
    for j in range(M):
        V[0, j] = log_startprob[j] + log_emlik[0, j]

    # For every frame but the first one
    for i in range(1, N):
        for j in range(M):
            V[i, j] = max( V[i-1, :] + log_transmat[:, j] ) + log_emlik[i, j]
            
            #Store all the paths
            B[i, j] = np.argmax( V[i-1, :] + log_transmat[:, j] )

    # The last step in the path is given by the max likelihood in the last frame.
    viterbi_path[N-1] = np.argmax(V[N-1, :])
    
    # The max likelihood will be the one given by the max likelihood in the last frame
    viterbi_loglik = np.max(V[N-1,:])

    # The best path is returned. To do so, we move backwards over this path. 
    for i in range(N-2, -1, -1):
        viterbi_path[i] = B[i+1, viterbi_path[i+1]]
        
    return viterbi_loglik, viterbi_path