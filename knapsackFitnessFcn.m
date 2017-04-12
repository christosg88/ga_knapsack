function scores = knapsackFitnessFcn(population, knapsackLimit, packets)
%knapsackFitnessFcn Returns a column vector, with the same length as population
%containing the score of each individual in population.
%   Each individual is assigned a score equal to the negative[*] sum of the
%   values of all the packets included for this individual. In case of an
%   individual having a sum of packet sizes greater than the `knapsackLimit`,
%   the individual is assigned a score of 0.
%   [*] The reason we use the negative sum is because the genetic algorithm
%   tries to minimize the fitness function, but we want the sum of values to be
%   the maximum.
%
%   population:     [populationSize  x  numPackets]
%       A matrix containing all the individuals of this population, one
%       individual per row. Each individual consists of a bitString, where a '1'
%       on the i-th index denotes that the i-th packet is inside the knapsack
%       for this individual, and '0' denotes that it isn't.
%   knapsackLimit:  scalar
%       A positive real value denoting the maximum size that the knapsack can
%       keep.
%   packets:        [numPackets  x  {size, value}]
%       A column vector containing all the available packets as structures with
%       the attributes `size` and `value`.

populationSize = size(population, 1);

scores = zeros(populationSize, 1);

for i=1:populationSize
    indexes = population(i, :) == 1;
    totalPacketSize = sum(cat(1, packets(indexes).size));
    if totalPacketSize <= knapsackLimit
        scores(i) = -sum(cat(1, packets(indexes).value));
    end
end

end
