clear; clc; close all;

% let the user choose a problem
problemSelection = input('Enter problem number: [1-9]: ');

% load the following variables of the problem
%   knapsackLimit:	scalar
%       The maximum total size that the knapsack can hold.
%   packets:        [numPackets  x  {size, value}]
%       A column vector containing all the available packets as structures with
%       the attributes `size` and `value`.
load(sprintf('knapsack_%02d.mat', problemSelection));
numPackets = size(packets, 1);

DPStart = tic;
[maxValueDP, packetsUsedDP] = knapsackDPSolution(knapsackLimit, packets);
DPTime = toc(DPStart);

GenStart = tic;
fitnessFcn = @(population) knapsackFitnessFcn(population, knapsackLimit, packets);

creationFcn = @(numPackets, fitnessFcn, options) knapsackCreationFcn(numPackets, options);

options = optimoptions( 'ga', ...
                        'PopulationType',       'bitString', ...
                        'PopulationSize',       500, ...
                        'MaxStallGenerations',	200, ...
                        'MaxGenerations',       Inf, ...
                        'CreationFcn',          creationFcn, ...
                        'MutationFcn',          @mutationuniform, ...
                        'PlotFcn',              @gaplotbestf, ...
                        'UseVectorized',        true);

[x, fval, exitflag] = ga(fitnessFcn, numPackets, [], [], [], [], [], [], [], options);
maxValue = -fval;
packetsUsed = find(x);
GenTime = toc(GenStart);

fprintf('Genetic Algorithm\n');
fprintf('-----------------\n');
fprintf('Runing Time:\t\t\t%.3fs\n', GenTime);
fprintf('Best score achieved:\t%d\n', maxValue);
fprintf('Space left:\t\t\t\t%d\n', knapsackLimit - sum(cat(1, packets(packetsUsed).size)));
fprintf('Packets used:\t\t\t[%d', packetsUsed(1));
for i=2:length(packetsUsed)
    fprintf(', %d', packetsUsed(i));
end
fprintf(']\n\n');

fprintf('Dynamic Programing Algorithm (Deterministic Solution)\n');
fprintf('-----------------------------------------------------\n');
fprintf('Runing Time:\t\t\t%.3fs\n', DPTime);
fprintf('Best score achieved:\t%d\n', maxValueDP);
fprintf('Space left:\t\t\t\t%d\n', knapsackLimit - sum(cat(1, packets(packetsUsedDP).size)));
fprintf('Packets used:\t\t\t[%d', packetsUsedDP(1));
for i=2:length(packetsUsedDP)
    fprintf(', %d', packetsUsedDP(i));
end
fprintf(']\n\n');
