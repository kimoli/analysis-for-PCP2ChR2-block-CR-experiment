function [cellarray] = populateCell(temp,cellarray,col)

for t = 1:length(temp)
    cellarray{t,col} = temp{t,1};
end

end