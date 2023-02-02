function [flag, facing, u, v, t] = MTalgorithm(O, dir, V1, V2, V3)

%             Möller-Trumbore algorithm
%-------------------------------------------------------------------------
%INPUTS:
%     - V1, V2, V3: vertices of the triangle
%     - dir: direction of the ray
%     - O: origing of the ray
%OUTPUTS:
%      - flag: 1 for intercept, 0 for NO intercept
%      - facing: 1 for frontfacing, 0 for backfacing
%      - u, v: barycentric coordinates
%      - t: distance from the ray origin to P
%-------------------------------------------------------------------------

    epsilon = 1e-5;

    edge1 = V2-V1;
    edge2 = V3-V1;
    pvec  = cross(dir,edge2);     % perpendicular vector
    det  = dot(edge1,pvec);       % determinant of the matrix M

       
    %determine side from which ray incides on the triangle: CULLING 
    
    if det > 0
        facing = 1; %front-facing
    else
        facing = 0; %back-facing
    end


    if (det>-epsilon && det<epsilon) 
        % the vector is parallel to the plane (the intersection is at infinity)
        [flag, u, v, t] = deal(0,0,0,0);
        return
    end

    invDet = 1/det;
    tvec = O-V1;
    u = invDet*dot(tvec,pvec);
    

    if (u<0.0 || u>1)
        % the ray does not intersect the triangle
        [flag, u, v, t] = deal(0,0,0,0);
        return          
    end
    
    qvec = cross(tvec,edge1);
    v = invDet*dot(dir,qvec);
    
    if (v<0.0 || u+v>1.0)
        % the ray does not intersect the triangle
        [flag, u, v, t] = deal(0,0,0,0);
        return
    end
    
    t = invDet*dot(edge2,qvec); % distance from the ray origin to P 
    flag = 1;                   % the ray intersects the triangle
    





end