function [y_ind, obj, innerloop] = cd_F(A, Y, n_iter)
    if nargin < 3
        n_iter = 50;
    end
    % 是否记录内层迭代的obj和标签
    if nargout > 2
        innerloop = {};
        req_inner = true;
    else
        req_inner = false;
    end

    n = size(Y, 1);
    y_ind = vec2ind(Y')';

    H = A * Y;
    yAy = full(sum(H .* Y));
    yDy = full(sum(H));
    H = full(H);  % For efficient slicing

    obj(1) = sum(yAy ./ yDy);
    for iter = 1:n_iter
        if req_inner
            innerloop{iter} = [];
        end
        for m = 1:n
            p = y_ind(m); % 当前行1的位置

            a_Y = H(m, :);

            yAy_k = yAy + 2 * a_Y;  % j=1...c, j != p的情况
            yAy_k(p) = yAy(p);  % j=p的情况，下同

            yDy_k = yDy + 1;
            yDy_k(p) = yDy(p);

            yAy_0 = yAy;
            yAy_0(p) = yAy(p) - 2 * a_Y(p);

            yDy_0 = yDy;
            yDy_0(p) = yDy(p) - 1;

            delta = yAy_k ./ yDy_k - yAy_0 ./ yDy_0;

            [~, r] = max(delta);
            
            if r ~= p
                yAy(p) = yAy_0(p);
                yDy(p) = yDy_0(p);
                yAy(r) = yAy_k(r);
                yDy(r) = yDy_k(r);

                A_m = A(:, m);
                H(:, r) = H(:, r) + A_m;
                H(:, p) = H(:, p) - A_m;

                % Y(m, [r, p]) = [1, 0];

                y_ind(m) = r;
            end
            if req_inner
                cur_row = struct();
                cur_row.obj = sum(yAy ./ yDy);
                cur_row.Y = y_ind;
                innerloop{iter} = [innerloop{iter}; cur_row];
            end
        end
        obj(iter + 1) = sum(yAy ./ yDy);

        if iter > 2 && (obj(iter) - obj(iter - 1)) < 1e-6
            break;
        end
    end
end
