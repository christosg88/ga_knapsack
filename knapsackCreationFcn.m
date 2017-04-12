function population = knapsackCreationFcn(numPackets, options)
%knapsackCreationFcn Returns a matrix containing the initial population for the
%knapsack problem.
%   The first `numPackets` lines consist an eye(numPackets) matrix, so we have a
%   '1' only on the diagonal. That allows us to be certain that even if the
%   knapsack can hold only one of the packets, we have an individual that will
%   fit this restriction. The rest populationSize-numPackets lines are filled
%   randomly with '1's, following a uniform distribution, so that in case our
%   knapsack can hold a large number of packets, the algorithm doesn't have to
%   develop too many generations to reach a good result. In case the
%   populationSize is smaller than numPackets, then only the first
%   populationSize lines are initialized, with a '1' on the i-th column at the
%   i-th row.
%
%   numPackets:     scalar
%       A positive integer denoting the number of different packets available.
%   options:        GaOptions struct
%       A GaOptions structure containing information about the options for the
%       genetic algorithm

populationSize = options.PopulationSize;

if populationSize <= numPackets
    population = eye(populationSize, numPackets);
else
    population = [eye(numPackets); double(0.5 > rand(populationSize-numPackets, numPackets))];
end

end

