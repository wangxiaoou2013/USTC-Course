function [z1,z2] = Z_Solve(f,M)
    z1=f*(1+1/M);
    z2=M*z1;
end

