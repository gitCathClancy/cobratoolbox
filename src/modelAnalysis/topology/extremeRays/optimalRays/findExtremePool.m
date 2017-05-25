function [x, output] = findExtremePool(fbaModel, obj, printLevel)
% find an extreme ray in the left nullspace of the stoichiometric matrix

A    = fbaModel.S';
[n, m] = size(A);

if nargin < 2
    obj = rand(m,1);
end
if nargin < 3
    printLevel = 0;
end


LPProblem.A=sparse([A; ones(1,m)]);
LPProblem.b=[zeros(n,1); 1];
LPProblem.c=obj;
LPProblem.lb=-100*ones(size(LPProblem.A,2),1);
LPProblem.ub= 100*ones(size(LPProblem.A,2),1);
LPProblem.osense=-1;
LPProblem.csense(1:size(LPProblem.A,1),1)='E';
output = solveCobraLP(LPProblem);
x=output.full; 