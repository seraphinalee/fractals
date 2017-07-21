function ordered = peano( V, m )
%V: running order of points
%m: how many more iterations we need to do

if m==0
    %convert all addresses back to primary
    for i=1:length(V)
        V(:,i) = primary(V(:,i));
    end
    ordered = V;
    return
end

m=m-1;
fstlength = length(V(:,1));
newV = zeros(fstlength+1, 3*length(V)); %initialize new list of points (3 times size of old list)
for i=1:length(V)
    fst = primary(V(:,i));
    snd = primary(V(:, mod(i, length(V))+1)); %to account for the last point to the first point
    index = 3*(i-1)+1; %get the new index in the new spaced out list
    newV(:, index) = [fst(1); fst]; %put original point in new list
    
    %get cell containing both first and second points
    [cella, cellb] = pointcells(fst);
    [cell1, cell2] = pointcells(snd);
    intersection = intersect([cella cellb]', [cell1 cell2]','rows')';

    %if the addresses aren't in the form of [i; celladdress], convert so
    %that they are
    if not(isequal(fst, [fst(1); intersection]))
        fst = secondary(fst);
    end
    if not(isequal(snd, [snd(1); intersection]))
        snd = secondary(snd);
    end

    %hardcoded in substitution rule 
    if (fst(1) == 0 && snd(1) == 1)
        newV(:, index+1) = [2; 0; intersection];
        newV(:, index+2) = [1; 2; intersection];
    
    elseif (fst(1) == 1 && snd(1) == 2)
        newV(:, index+1) = [0; 1; intersection];
        newV(:, index+2) = [2; 0; intersection];
    
    elseif (fst(1) == 2 && snd(1) == 0)
        newV(:, index+1) = [1; 2; intersection];
        newV(:, index+2) = [0; 1; intersection];
    
    
    elseif (fst(1) == 1 && snd(1) == 0)
        newV(:, index+2) = [2; 0; intersection];
        newV(:, index+1) = [1; 2; intersection];
    
    elseif (fst(1) == 2 && snd(1) == 1)
        newV(:, index+2) = [0; 1; intersection];
        newV(:, index+1) = [2; 0; intersection];
    
    elseif (fst(1) == 0 && snd(1) == 2)
        newV(:, index+2) = [1; 2; intersection];
        newV(:, index+1) = [0; 1; intersection];
    end

end

%recurse
ordered = peano(newV, m);
end

