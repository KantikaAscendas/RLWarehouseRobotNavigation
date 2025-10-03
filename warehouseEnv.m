classdef warehouseEnv < rl.env.MATLABEnvironment
    %% Properties
    properties
        GridSize = [5 5] % ขนาดโกดัง (5x5)
        State = [1 1]    % ตำแหน่งเริ่มต้น (Entrance)
        Goal = [5 5]     % จุดหมาย (Loading Dock)
        Obstacles = [3 3; 2 4; 5 2] % ตำแหน่งสิ่งกีดขวาง
    end
    
    methods
        function this = warehouseEnv()
            % Observation = [row col] / Action = {1=up,2=down,3=left,4=right}
            ObservationInfo = rlNumericSpec([1 2]);
            ObservationInfo.Name = 'Robot Position';
            
            ActionInfo = rlFiniteSetSpec([1 2 3 4]);
            ActionInfo.Name = 'Move Action';
            
            this = this@rl.env.MATLABEnvironment(ObservationInfo,ActionInfo);
        end
        
        function [obs,reward,isDone,log] = step(this,action)
            % Move robot
            nextState = moveRobot(this.State,action,this.GridSize);
            this.State = nextState;
            
            % Reward
            if ismember(nextState,this.Obstacles,'rows')
                reward = -5; isDone=false;
            elseif isequal(nextState,this.Goal)
                reward = 20; isDone=true;
            else
                reward = -1; isDone=false;
            end
            obs = this.State;
            log = [];
        end
        
        function obs = reset(this)
            this.State = [1 1]; % reset กลับไป Entrance
            obs = this.State;
        end
    end
end
