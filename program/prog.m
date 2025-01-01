%% prog.m

clear
format compact

syms s
syms kP kI kD real
syms a0 a1 b0 real

P = b0/(s^2 + a1*s + a0);
C = (kD*s^2 + kP*s + kI)/s;

[Np Dp] = numden(P);
[Nc Dc] = numden(C);

Delta = Dp*Dc + Np*Nc;
Delta = collect(Delta,s)
alpha = coeffs(Delta,s);

N = length(alpha);
n = N - 1;

% ===== 条件 A =======================
disp('----- 条件 A：a_i > 0 ------')
for i = 1:N
  str = ['a', num2str(i-1), '= alpha(i)'];
  eval(str)
end 

cond1 = ' ';
for i = 1:N
  if i == 1
    cond1 = strcat(cond1,['simplify(a' num2str(i-1) '> 0)']);
  else
    cond1 = strcat(cond1,[' & simplify(a' num2str(i-1) '> 0)']);
  end
end

% ===== 条件 B" =======================
for i = 1:n
  for j = 1:n
    k = (N - 1) + (i - 1) - 2*(j - 1);

    if k >= 1 & k <= N 
      H(i,j) = alpha(k);
    else
      H(i,j) = 0;
    end
  end
end

disp('----- 行列 H ------')
H

if mod(n,2) == 0  % 次数: n = 2*k
  i_min = 3;  i_max = n - 1;
else              % 次数: n = 2*k + 1
  i_min = 2;  i_max = n - 1;
end

disp('----- 条件 B"：H_i > 0 ------')
for i = i_min:2:i_max
  str = ['H', num2str(i), '= det(H(1:i,1:i))'];
  eval(str)
end 

cond2 = ' ';
for i = i_min:2:i_max
  if i == i_min
    cond2 = strcat(cond2,['simplify(H' num2str(i) '> 0)']);
  else
    cond2 = strcat(cond2,[' & simplify(H' num2str(i) '> 0)']);
  end
end

% ===== 安定条件 =======================
disp('----- 安定条件 ------')
simplify(eval(cond1) & eval(cond2))