function heurestic = manhattan_distance(matrix, goal_state) 
heurestic = 0;
for i = 1:8
    %For each number in the puzzle (8 for 8 tile, 15 for 15 tile etc)
    %Find the row and col index in the entered state and the goal state
    num_index = find(matrix == i);
    row_index = mod((num_index - 1), 3) + 1;
    col_index = floor((num_index - 1)/ 3) + 1;
    num_index_goal = find(goal_state == i);
    row_index_goal = mod((num_index_goal - 1), 3) + 1;
    col_index_goal = floor((num_index_goal - 1)/ 3) + 1;
    %Distance between the goal number and the entered number is
    %The absolute value of the difference of the row indexes
    %plus the absolute value of the difference on the col indexes
    %The heurestic is the sum of these distances
    heurestic = heurestic + abs(row_index_goal - row_index) ...
        + abs(col_index_goal - col_index);
end
end