classdef Queue < handle
    %Set to handle because we only want 1 queue
    %Set Access to private so that we have to use functions to adjust
    %The queue
    properties (SetAccess = private)
        %Queue for states, depth, cost, and all_nodes
        state
        depth
        cost
        all_nodes
    end
    methods
        %Constructor function
        function obj = Queue(matrix, val1, val2)
            %State and all_nodes are 3D matrices
            obj.state = cat(3, matrix);
            obj.depth = val1;
            obj.cost = val2;
            obj.all_nodes = cat(3, matrix);
        end
        function index = find_smaller(obj, total)
            %Set the index to in case the obj.cost is empty
            index = 0;
            if isempty(obj.cost)
            else
                %If not, we set index equal to the index previous
                %The node which is larger than it
                for i = 1:size(obj.cost, 2)
                    if obj.cost(i) >= total
                        index = i - 1;
                        break;
                    else
                        %If it doesn't enter the if statement, then it
                        %Goes to the very end of queue
                        index = size(obj.cost, 2);
                    end
                end
            end     
        end
        function add_to_Queue(obj, matrix, deep, total)
            %Add the node to the all_nodes queue
            obj.all_nodes = cat(3, matrix, obj.all_nodes);
            q_size = size(obj.cost, 2);
            %Implement the indexing function
            index = find_smaller(obj, total);
            %If statement for if inserting at the front, back or in the
            %middle of the queue
            %Do this for all 3 of the queues
            if isequal(index, 0)
                %Front of queue
                obj.state = cat(3, matrix, obj.state);
                obj.depth = [deep, obj.depth];
                obj.cost = [total, obj.cost];
            elseif isequal(index, q_size)
                %End of queue
                obj.state = cat(3, obj.state, matrix);
                obj.depth = [obj.depth, deep];
                obj.cost = [obj.cost, total];
            else
                %Inserting in the middle, in between index and index + 1
                obj.state = cat(3, obj.state(:, :, 1:index), ...
                    matrix, obj.state(:, :, (index + 1):q_size));
                obj.depth = [obj.depth(1:index), deep, ...
                    obj.depth((index + 1):q_size)];
                obj.cost = [obj.cost(1:index), total, ...
                    obj.cost((index + 1):q_size)];
            end  
        end
        function [mat, deep, total] = pop_from_Queue(obj)
            %Return the matrix and depth at the front of the queue
            %And delete the first node of the state, depth, and cost
            mat = obj.state(:, :, 1); obj.state(:, :, 1) = [];
            deep = obj.depth(1); obj.depth(1) = [];
            total = obj.cost(1); obj.cost(1) = [];
        end
        function logic = repeated_states(obj, matrix)
            %Check for repeated states, if doesn't enter the if,
            %Returns false. Runs in linear time 
            logic = false;
            for i = 1:size(obj.all_nodes, 3)
                if isequal(matrix, obj.all_nodes(:, :, i))
                    logic = true;
                    break
                end
            end
        end
        function queueSize = get_Queue_size(obj)
            %Get the size of the cost queue
            queueSize = size(obj.cost, 2);
        end
    end
end