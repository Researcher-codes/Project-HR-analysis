function [accuracy] = EvaluateAccuracy(outcome,gt)
%EVALUATEACCURACY Summary of this function goes here
%   Detailed explanation goes here
tp=0;
for i=1:numel(outcome)
   if gt(i)==outcome(i)
     tp=tp+1;  
   end
    
end
accuracy=(tp/numel(outcome))*100;
end

