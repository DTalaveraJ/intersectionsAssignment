%% -----------------------------------------------------------------------
% INTERSECTIONS - ASSIGNMENT FOR IENAI SPACE - By Daniel Talavera Jiménez
% 
%                       January 2023
% ------------------------------------------------------------------------

clc; clear; close all
format long

%% Read input files:
%-------------------------------------------------------------------------
fileID = fopen('directions.txt','r');
directions = cell2mat(textscan(fileID, '%f%f%f' ...
                , 'Delimiter', ','      ...
                , 'Whitespace', '[] '   ...
                , 'CollectOutput', true ));

fileID = fopen('triangles.txt','r');
triangles = cell2mat(textscan(fileID, '%f%f%f %f%f%f %f%f%f' ...
                , 'Delimiter', ','      ...
                , 'Whitespace', '[] '   ...
                , 'CollectOutput', true ));
%-------------------------------------------------------------------------


%% Initialization
%-------------------------------------------------------------------------

X_P = zeros(3,length(triangles(:,1)),length(directions(:,1)));
X_P_vec = zeros(length(directions(:,1)),6);
index = 0;
index_check = 0;

%% Iteration over triangles and rays
%-------------------------------------------------------------------------

for jj = 1:length(directions(:,1))

    for ii = 1:length(triangles(:,1))
        %definition of the triangle vertices
        v1 = [triangles(ii,1),triangles(ii,2),triangles(ii,3)];
        v2 = [triangles(ii,4),triangles(ii,5),triangles(ii,6)];
        v3 = [triangles(ii,7),triangles(ii,8),triangles(ii,9)];

        %origin
        O = [0 0 0];

        %normal vectors - direction of each ray
        dir = [directions(jj,1),directions(jj,2),directions(jj,3)];

        [flag, facing, u, v, t] = MTalgorithm(O, dir, v1, v2, v3);



        if flag == 0

            X_P(:,ii,jj) = [0.0,0.0,0.0];

        elseif flag == 1

            X_P(:,ii,jj) = O + t*dir; %intercept point on the triangle
            
            index = index + 1;
            index_check = index_check + 1;
            X_P_dummy(index,:) = [jj;ii;t;X_P(:,ii,jj);facing];

            if index > 1
                if abs(X_P_dummy(index,3))> abs(X_P_dummy(index-1,3))
                
                        
                        X_P_vec(jj,:) = X_P_dummy(index,2:end);
    
                end
            else
                X_P_vec(jj,:) = X_P_dummy(index,2:end);
            end
            



        end

        
    end
    index = 0;
    clear X_P_dummy;
    
end

%% Write results in .txt file
%-------------------------------------------------------------------------

writeResults(X_P_vec,directions)


%% Graphical representation
%-------------------------------------------------------------------------

% select direction and triangle

dirIndex = 54;
triangleIndex = 38;

representation(dirIndex,triangleIndex, triangles, directions, O, X_P_vec)





