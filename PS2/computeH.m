function H = computeH(t1, t2) %
    A = [];
    [num_r,num_c] = size(t1);
    
    for c = 1:num_c
        coor_x1 = t1(1,c)
        coor_y1 = t1(2,c)
        coor_x1_prime = t2(1,c)
        coor_y1_prime = t2(2,c)
        temp1 = [ coor_x1 coor_y1 1 0 0 0 -coor_x1_prime*coor_x1 -coor_x1_prime*coor_y1 -coor_x1_prime]
        A = [A; temp1]
        temp2 = [ 0 0 0 coor_x1 coor_y1 1 -coor_y1_prime*coor_x1 -coor_y1_prime*coor_y1 -coor_y1_prime]
        A = [A; temp1]
    end
    
    [eig_vec,eig_val] = eig(A'*A)
    [size2,size3] = size(eig_val)
    min = eig_val(size2,size2)
    min_idx = size2
    for i = 1:size2
        if eig_val(i,i) < min
            min = eig_val(i,i)
            min_idx = i
        end
    end

    H = eig_vec(:,min_idx)
