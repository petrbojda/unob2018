function [c] = matched_filter_timedom(t,x_ref,x) 


for i1 = 1:length(t)
    c(i1) = [x,zeros(size(t))] * [zeros([1,i1-1]),x_ref,zeros([1,length(t)-i1+1])]';
end
