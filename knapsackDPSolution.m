function [maxValue, packetsUsed] = knapsackDPSolution(knapsackLimit, packets)
%knapsackDPSolution Computes the maximum value that can be achieved for the
%knapsack problem using a Dynamic Programing aproach. Both the time and space
%complexity are O(knapsackLimit * numPackets).
%Reference: http://www.geeksforgeeks.org/dynamic-programming-set-10-0-1-knapsack-problem/
%   knapsackLimit:  scalar
%       A positive real value denoting the maximum size that the knapsack can
%       keep.
%   packets:        [numPackets  x  {size, value}]
%       A column vector containing all the available packets as structures with
%       the attributes `size` and `value`.

numPackets = size(packets, 1);

K = zeros(numPackets+1, knapsackLimit+1);

for n = 1:numPackets+1
    for s = 1:knapsackLimit+1
        if s == 1 || n == 1
            % initialize the maximum value for 0 space and 0-th packet to 0
            K(n, s) = 0;
        elseif packets(n-1).size <= s-1
            % if the (n-1)-th packet fits inside a knapsack with size (s-1), set
            % the maximum value that can be achieved to the max between the
            % value we get if we add the (n-1)-th packet and the value we get if
            % we don't add it
            K(n, s) = max(packets(n-1).value + K(n-1, s-packets(n-1).size), K(n-1, s));
        else
            % if the (n-1)-th packet doesn't fit inside a knapsack with size
            % (s-1), set the maximum value that can be achieved to the value we
            % had at the previous packet
            K(n, s) = K(n-1, s);
        end
    end
end
maxValue = K(end, end);

% create a row vector containing the indexes of the packets used to achieve the
% maximum score
packetsUsed = [];
s = knapsackLimit+1;
for n=numPackets+1:-1:2
    if K(n, s) > K(n-1, s)
        packetsUsed = [n-1, packetsUsed];
        s = s - packets(n-1).size;
    end
end

end
