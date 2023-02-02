function [] = representation(dirIndex,triangleIndex, triangles, directions, O, X_P_vec)

%function to plot the results: ray direction, triangle, and point of
%intercept (if it exists)
%-------------------------------------------------------------------------


% assign coordinates to the vertices and build direction vector

v1 = [triangles(triangleIndex,1),triangles(triangleIndex,2),triangles(triangleIndex,3)];
v2 = [triangles(triangleIndex,4),triangles(triangleIndex,5),triangles(triangleIndex,6)];
v3 = [triangles(triangleIndex,7),triangles(triangleIndex,8),triangles(triangleIndex,9)];
dir = [directions(dirIndex,1),directions(dirIndex,2),directions(dirIndex,3)];


tri_surf = [v1; v2; v3];

figure()
grid on
hold on
plot3(v1(1),v1(2),v1(3),'b.', 'MarkerSize', 15)
plot3(v2(1),v2(2),v2(3),'k.', 'MarkerSize', 15)
plot3(v3(1),v3(2),v3(3),'r.', 'MarkerSize', 15)
trisurf([1 2 3],tri_surf(:,1), tri_surf(:,2), tri_surf(:,3),'FaceColor','yellow','EdgeColor','black');


% direction
quiver3(O(1), O(2), O(3), dir(1), dir(2), dir(3), 10);
quiver3(O(1), O(2), O(3), -dir(1), -dir(2), -dir(3), 10);

% intersection
plot3(X_P_vec(dirIndex,3), X_P_vec(dirIndex,4), X_P_vec(dirIndex,5),'o','Color','b','MarkerSize',5,...
    'MarkerFaceColor','#D9FFFF');

labels={'v1','v2','v3'};
text(tri_surf(:,1), tri_surf(:,2), tri_surf(:,3),labels,'VerticalAlignment','bottom','HorizontalAlignment','left');
legend('','','','','from \infty','towards \infty');

if X_P_vec(dirIndex,end) == 1
  title(['direction = ',num2str(dirIndex),', idx = ', num2str(triangleIndex), ', x_p = ',num2str(X_P_vec(dirIndex,3)),', y_p = ',num2str(X_P_vec(dirIndex,4)),', z_p = ',num2str(X_P_vec(dirIndex,5)),', A']);
else
  title(['direction = ',num2str(dirIndex),', idx = ', num2str(triangleIndex), ', x_p = ',num2str(X_P_vec(dirIndex,3)),', y_p = ',num2str(X_P_vec(dirIndex,4)),', z_p = ',num2str(X_P_vec(dirIndex,5)),', B']); 
end

view(60,30);
alpha(0.5);
axis tight;
xlabel('x');
ylabel('y');
zlabel('z');

end