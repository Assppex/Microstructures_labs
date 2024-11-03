function draw_k_eff(k_eff1_by_k, k_eff1_by_r, p_linspace, k_matrix, k_inhom, type) %p_linspace должен быть таким же какой подавалс€ в get_k_eff

if type == 1
    str11 = strcat('Ёффективна€ теплопроводность = k_{', num2str(11), '} случай: p_{sphere} = p_{spheroid} = p / 2');
    str22 = strcat('Ёффективна€ теплопроводность = k_{', num2str(22), '} случай: p_{sphere} = p_{spheroid} = p / 2');
    str33 = strcat('Ёффективна€ теплопроводность = k_{', num2str(33), '} случай: p_{sphere} = p_{spheroid} = p / 2');
elseif type == 2
    str11 = strcat('Ёффективна€ теплопроводность = k_{', num2str(11), '} случай: p_{spheroid} = 0,  p_{sphere} = p');
    str22 = strcat('Ёффективна€ теплопроводность = k_{', num2str(22), '} случай: p_{spheroid} = 0,  p_{sphere} = p');
    str33 = strcat('Ёффективна€ теплопроводность = k_{', num2str(33), '} случай: p_{spheroid} = 0,  p_{sphere} = p');
else
    str11 = strcat('Ёффективна€ теплопроводность = k_{', num2str(11), '} случай: p_{spheroid} = p,  p_{sphere} = 0');
    str22 = strcat('Ёффективна€ теплопроводность = k_{', num2str(22), '} случай: p_{spheroid} = p,  p_{sphere} = 0');
    str33 = strcat('Ёффективна€ теплопроводность = k_{', num2str(33), '} случай: p_{spheroid} = p,  p_{sphere} = 0');
end


k11_by_k = zeros(size(p_linspace,2),1);
k22_by_k  = zeros(size(p_linspace,2),1);
k33_by_k  = zeros(size(p_linspace,2),1);

k11_by_r = zeros(size(p_linspace,2),1);
k22_by_r  = zeros(size(p_linspace,2),1);
k33_by_r  = zeros(size(p_linspace,2),1);

k1 = k_matrix;
k2 = k_inhom;
p1 = 1 - p_linspace;
p2 = p_linspace;

% тут как бы в чем логика, кажда€ фаза изотропна, а значит € могу
% использовать такую посчитанную границу ’ашина - Ўтрихмана на графиках дл€
% k_ii_eff / k0, т.к. k0_ii все равны k0
m = k2 - k1;
if ( k1 > k2) 
    k_hs_high = k1 + p2 ./ (p1 ./ (3*k1) + (1 / m));
else
    k_hs_high = k2 + p1 ./ ( p2 ./ (3*k2) - 1 / m);
end

for i = 1:1:size(p_linspace,2)
   k11_by_k(i) = k_eff1_by_k(1, 1, i) / k_matrix;
   k22_by_k(i) = k_eff1_by_k(2, 2, i) / k_matrix;
   k33_by_k(i) = k_eff1_by_k(3, 3, i) / k_matrix;
   
   k11_by_r(i) = k_eff1_by_r(1, 1, i) / k_matrix;
   k22_by_r(i) = k_eff1_by_r(2, 2, i) / k_matrix;
   k33_by_r(i) = k_eff1_by_r(3, 3, i) / k_matrix;
end

figure()
plot(p_linspace, k11_by_k, p_linspace, k11_by_r, p_linspace, k_hs_high / k_matrix , 'LineWidth', 1.5)
grid on
xlabel('p_{inhom}');
ylabel('k_{*_{11}}/k_{matrix}');
legend('„ерез тензор вклада в теплопроводность', '„ерез тензор вклада в сопротивл€емость' , 'Hashin-Shtrikman high');
title([str11]);
ylim([0 1])

figure()
plot(p_linspace, k22_by_k, p_linspace, k11_by_r, p_linspace, k_hs_high / k_matrix , 'LineWidth', 1.5)
grid on
xlabel('p_{inhom}');
ylabel('k_{*_{22}}/k_{matrix}');
legend('„ерез тензор вклада в теплопроводность', '„ерез тензор вклада в сопротивл€емость' , 'Hashin-Shtrikman high');
title([str22]);
ylim([0 1])

figure()
plot(p_linspace, k33_by_k,p_linspace, k11_by_r, p_linspace, k_hs_high / k_matrix ,  'LineWidth', 1.5)
grid on
xlabel('p_{inhom}');
ylabel('k_{*_{33}}/k_{matrix}');
legend('„ерез тензор вклада в теплопроводность', '„ерез тензор вклада в сопротивл€емость' , 'Hashin-Shtrikman high');
title([str33]);
ylim([0 1])


