ITER = 1500; 
close all; 

start_point = [5 2];

goal_point = [-10 5]; 

map = [start_point, 1]; 
epsilon = 0.3; 

%obstacles: 
obstacles = [2 3 2; 
             7 8 2;
             -1 -1 2;
             -8 -5 2]; %centers and radii
         
NoOfobstacles = size(obstacles,1);
         
viscircles(obstacles(:, 1:end-1) ,obstacles(:, end), 'Color', 'g')


 hold on
 plot(start_point(1),start_point(2),'r*','MarkerSize',10)
 text(start_point(1),start_point(2), 'S')
 plot(goal_point(1),goal_point(2),'r*','MarkerSize',10)
 text(goal_point(1),goal_point(2), 'G')
 X_new = start_point; 
while norm(X_new-goal_point) > 0.1
    i = i+1;
    if randn>0

        X_rand = 10*randn([1, 2]); %take a random point in the environment
    else
        X_rand = goal_point; 
    end
    
    %calculate which point in the existing map has the smallest distance to
    %X_rand
    
    [smallest_idx] = closest_point(map,X_rand); 
    X_near = map(smallest_idx, 1:end-1); 
    X_new = X_near + (X_rand - X_near)/norm(X_rand - X_near)*epsilon ; %new point is proportional to the distance from the nearest point
    
    dis_from_obs = sqrt((X_new(1)-obstacles(:, 1)).^2 + (X_new(2)-obstacles(:, 2)).^2); 
    if sum(dis_from_obs > obstacles(:, end))== NoOfobstacles
        map = [map; [X_new, smallest_idx]]; 
        con = [X_near; X_new];
        line(con(:,1), con(:,2))
        drawnow
    end

end


[smallest_idx] = closest_point(map,goal_point); 
X_near = map(smallest_idx, 1:end-1); % nearest point to the goal 
con = [X_near; goal_point];
line(con(:,1), con(:,2),'Color', 'r')

while X_near~=start_point 
    
    parent_idx = map(smallest_idx,end);
    
    X_parent = map(parent_idx, 1:end-1);
    
    con = [X_near; X_parent];
    
    line(con(:,1), con(:,2),'Color', 'r', 'linewidth',2)
    
    smallest_idx = parent_idx;
    X_near = X_parent;
    
end 

print -dpng algo_output.png
