function heurestic = misplaced_tile(matrix, goal_state)
%Comparing the matrix to the goal state creates a 3x3 logical matrix
%Summing the logical matrix gets us the number of properly placed tiles
dif = sum(sum(matrix == goal_state));
    %The if-else statement is to check whether the blank is also counted
    %as a properly placed tile. If so, subtract the sum from 8. Else
    %subtract from 9 and you get your heuristic
    if find(matrix == 0) == 9
        heurestic = 9 - dif;
    else
        heurestic = 8 - dif;
    end
end
        