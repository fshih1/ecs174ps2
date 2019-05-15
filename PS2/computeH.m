function H = computeH(t1, t2)
    [nRow, nCol] = size(t1);
    
    if size(t1) ~= size(t2)
        error('Dimension mismatch');
    end
    if size(t1) < 4
        error('Too few dimensions');
    end
    
%     Scale coordinates to 0 - 2
    [m, ~] = max([t1, t2], [], 2);
    t1(1,:) = (t1(1,:) / m(1)) * 2;
    t2(1,:) = (t2(1,:) / m(1)) * 2;
    t1(2,:) = (t1(2,:) / m(2)) * 2;
    t2(2,:) = (t2(2,:) / m(2)) * 2;
    
    A = [];
    for col = 1:nCol
        x = t1(1, col);
        y = t1(2, col);
        x_p = t2(1, col);
        y_p = t2(2, col);
        sub = [x, y, 1, 0, 0, 0, -x_p*x, -x_p*y, -x_p;
                0, 0, 0, x, y, 1, -y_p*x, -y_p*y, -y_p];
        A = [A; sub];
    end
        
    [H, ~] = eigs(A' * A, 1, 'SM');
end


    