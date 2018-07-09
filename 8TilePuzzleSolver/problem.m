function [depth, total_nodes, max_size] = problem(current, search_type)
%Including the diameter of the 8 tile puzzle in case the given problem
%Is an impossible problem
depth = 0; total_nodes = 0; max_size = 0; diameter = 31; cost = 0;
goal_state = [1 2 3; 4 5 6; 7 8 0];
%nodes = MAKE-QUEUE(MAKE-NODE(problem.INITIAL-STATE))
queue = Queue(current, 0, 0);
% do while notEMPTY(nodes)
% if empty, return failure
while get_Queue_size(queue) > 0
    %node = REMOVE-FRONT(nodes) 
    [state, depth, cost] = pop_from_Queue(queue);
    %fprintf('\nExpanding state\n') 
    %disp(state)
    %fprintf('With g(n) = %d and h(n) = %d \n', depth, (cost - depth))
    
    %Check for max size of the queue only to be able to return it
    if max_size < get_Queue_size(queue)
        max_size = get_Queue_size(queue);
    end
    %if problem.GOAL-TEST(node.STATE) succeeds then return node
    if isequal(state, goal_state)
        fprintf('Success!\n')
        fprintf('To solve this problem, the search algorithm expanded ')
        fprintf('%d nodes \nThe maximum number of nodes in the ', total_nodes)
        fprintf('queue at any one point in time was %d nodes \n', max_size)
        fprintf('The depth of the goal nodes was %d\n', depth)
        return
    end
    %In the case that the puzzle is unsolvable
    if depth <= diameter
        %Returns the index of the 0
        num_index = find(state == 0);
        %Convert the index into a row and column index
        row_index = mod((num_index - 1), 3) + 1;
        col_index = floor((num_index - 1)/ 3) + 1;
        if row_index > 1
            %move blank up
            node = move_blank(state, row_index, col_index, 1);
            %Check for repeated states. If so, don't update anything
            if ~(repeated_states(queue, node))
                %Uniform Cost Search, h(n) = 0, f(n) = depth + 1
                if isequal(search_type, 1)
                    cost = depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                %Misplaced Tiles, h(n) = f(n) + g(n), f(n) = depth + 1
                elseif isequal(search_type, 2)
                    cost = misplaced_tile(node, goal_state) + depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                %Manhattan Distance, f(n) = depth + 1
                else
                    cost = manhattan_distance(node, goal_state) + depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                end
                total_nodes = total_nodes + 1;
            end
        end
        if row_index < 3
            %move blank down
            node = move_blank(state, row_index, col_index, 2);
            %Check for repeated states. If so, don't update anything
            if ~(repeated_states(queue, node))
                %Uniform Cost Search, h(n) = 0, f(n) = depth + 1
                if isequal(search_type, 1)
                    cost = depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                %Misplaced Tiles, h(n) = f(n) + g(n), f(n) = depth + 1
                elseif isequal(search_type, 2)
                    cost = misplaced_tile(node, goal_state) + depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                %Manhattan Distance, f(n) = depth + 1
                else
                    cost = manhattan_distance(node, goal_state) + depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                end
                total_nodes = total_nodes + 1;
            end
        end
        if col_index > 1
            %move blank left
            node = move_blank(state, row_index, col_index, 3);
            %Check for repeated states. If so, don't update anything
            if ~(repeated_states(queue, node))
                %Uniform Cost Search, h(n) = 0, f(n) = depth + 1
                if isequal(search_type, 1)
                    cost = depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                %Misplaced Tiles, h(n) = f(n) + g(n), f(n) = depth + 1
                elseif isequal(search_type, 2)
                    cost = misplaced_tile(node, goal_state) + depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                %Manhattan Distance, f(n) = depth + 1
                else
                    cost = manhattan_distance(node, goal_state) + depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                end
                total_nodes = total_nodes + 1;
            end
        end
        if col_index < 3
            %move blank right
            node = move_blank(state, row_index, col_index, 4);
            %Check for repeated states. If so, don't update anything
            if ~(repeated_states(queue, node))
                %Uniform Cost Search, h(n) = 0, f(n) = depth + 1
                if isequal(search_type, 1)
                    cost = depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost); 
                %Misplaced Tiles, h(n) = f(n) + g(n), f(n) = depth + 1
                elseif isequal(search_type, 2)
                    cost = misplaced_tile(node, goal_state) + depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                %Manhattan Distance, f(n) = depth + 1
                else
                    cost = manhattan_distance(node, goal_state) + depth + 1;
                    add_to_Queue(queue, node, depth + 1, cost);
                end
                total_nodes = total_nodes + 1;
            end
        end
    end
end
'Failure. Puzzle is not solvable.'
end