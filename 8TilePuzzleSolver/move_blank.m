function node = move_blank(matrix, row_index, col_index, n)
%Having calculated the row_index and col_index of the blank,
%We have a 4 line temp and switch in order to get the new matrix
node = matrix;
if n == 1
    %For moving the blank up
    temp_num = matrix(row_index - 1, col_index);
    node(row_index - 1, col_index) = 0;
elseif n == 2
    %For moving the blank down
    temp_num = matrix(row_index + 1, col_index);
    node(row_index + 1, col_index) = 0;
elseif n == 3
    %For moving the blank left
    temp_num = matrix(row_index, col_index - 1);
    node(row_index, col_index - 1) = 0;
else
    %For moving the blank right
    temp_num = matrix(row_index, col_index + 1);
    node(row_index, col_index + 1) = 0;
end
node(row_index, col_index) = temp_num;
end