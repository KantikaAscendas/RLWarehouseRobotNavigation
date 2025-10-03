function newState = moveRobot(state,action,gridSize)
    newState = state;
    switch action
        case 1 % up
            newState(1) = max(1,state(1)-1);
        case 2 % down
            newState(1) = min(gridSize(1),state(1)+1);
        case 3 % left
            newState(2) = max(1,state(2)-1);
        case 4 % right
            newState(2) = min(gridSize(2),state(2)+1);
    end
end
