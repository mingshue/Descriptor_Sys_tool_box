function [E_w,A_w, B_w, C_w, D_w ] = Weier_Form(E,A,B,C,D)
%Weierstrass Form (E,A, B, C, D)>> ()
%Compute  Weierstrass form  of descriptor systems finted part
%% Eigenvector and Eigenvalue
    


%% Transform 
    E_w=Wf*E*Vf;
    A_w=Wf*A*Vf;
    B_w=Wf*B;
    C_w=C*Vf;
    D_w=D;
end