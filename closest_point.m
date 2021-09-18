function [smallest_idx] = closest_point(map, X_i)
x = size(map); 
d_min = 100; 

smallest_idx = 1; 

for j = 1:x(1) 
    
    d = norm(map(j, :)-X_i); 
    
    %check for obstacle collision: 

        if d<d_min 
            smallest_idx = j;
            d_min = d; 
        end
    

end
end

