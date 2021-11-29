function [smallest_idx] = closest_point(map, X_i)
x = size(map,1); 
d_min = 100; 

smallest_idx = 1; 

for j = 1:x 
    
    d = norm(map(j, 1:end-1)-X_i); 
    
    %check for obstacle collision: 

        if d<d_min 
            smallest_idx = j;
            d_min = d; 
        end
    

end
end

