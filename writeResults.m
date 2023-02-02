function [] = writeResults(X_P_vec,directions)


%function to write results in a .txt file:

%   • '-------', if there is no intersection between the n-th line and any of the triangles

%   • 'idx, [x_p, y_p, z_p], A/B' if there is intersect
%     • The index idx of the triangle that first intersects the line coming from
%       infinity in the direction of the normal.
%     • The intersection point, [x_p, y_p, z_p]
%     • The character A or B, depending on which side of the triangle is “seen” by
%       the line as it approaches the triangle. See the figure for the explanation
%       of which side is which (i.e. if you re seeing face A, then the vertices v1,
%       v2, and v3 appear in counterclockwise fashion )
%------------------------------------------------------------------------------------------------


fileID = fopen('results.txt','w');
fprintf(fileID,'%12s,[%12s, %12s, %12s], %12s\n','idx','x_p','y_p','z_p','A/B');


    for jj = 1:length(directions(:,1))

        if X_P_vec(jj,2) == 0

            fprintf(fileID,'%s\n','-------');

        elseif X_P_vec(jj,2) ~= 0 && X_P_vec(jj,end) == 0

            fprintf(fileID,'%12d [%12f , %12f , %12f] %12s\n',X_P_vec(jj,1), X_P_vec(jj,3),X_P_vec(jj,4),X_P_vec(jj,5),'B');

        elseif X_P_vec(jj,2) ~= 0 && X_P_vec(jj,end) == 1

            fprintf(fileID,'%12d [%12f , %12f , %12f] %12s\n',X_P_vec(jj,1), X_P_vec(jj,3),X_P_vec(jj,4),X_P_vec(jj,5),'A');


        end

    end

fclose(fileID);

end