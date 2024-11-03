% Теплопроводность

%Задаем свойства матрицы и неоднородностей
k1 = 300; %Матрица
k2= 0;

%Задаем оьемные доли неоднородности
p2 = 0:0.01:1; %Неоднородности
p1 = 1 - p2; %Матрица


k_voigt = p1*k1 + p2*k2;
k_reuss = (p1/k1 + p2/k2).^-1;


% Хашин - Штрихман
m = k2 - k1;
if ( k1 > k2) 
    k_hs_high = k1 + p2 ./ (p1 ./ (3*k1) + (1 / m));
    k_hs_low = k2 + p1 ./ ( p2 ./ (3*k2) - (1 / m));
else
    k_hs_low = k1 + p2 ./ (p1 ./ (3*k1) + 1 / m);
    k_hs_high = k2 + p1 ./ ( p2 ./ (3*k2) - 1 / m);
end

figure()
plot(p2, k_voigt / k1, p2, k_reuss / k1, p2, k_hs_high / k1, p2, k_hs_low / k1 , 'LineWidth', 1.5);
grid on
xlabel('p_{inhom}');
ylabel('k_*/k_{matrix}');
legend('Voignt', 'Reuss' , 'Hashin-Shtrikman high', 'Hashin-Shtrikman low');
title(['Теплопроводность Voigt-Reuss: k_{matrix} = ', num2str(k1), ', k_{inhomogenity} = ', num2str(k2)]);



% %Упругость
% 
% %Задаем свойства матрицы и неоднородностей
% k1 = 332; %Матрица
% k2= 965;
% 
% mu1 = 654;%Матрица
% mu2 = 167;
% 
% %Задаем оьемные доли неоднородности
% p2 = 0:0.01:1; %Неоднородности
% p1 = 1 - p2; %Матрица
% 
% k_voigt = k1*p1 + k2*p2;
% k_reuss = (p1/k1 + p2/k2).^-1;
% 
% mu_voigt = mu1*p1 + mu2*p2;
% mu_reuss = (p1/mu1 + p2/mu2).^-1;
% 
% figure()
% subplot(1,2,1)
% plot(p2, k_voigt / k1, p2, k_reuss / k1, 'LineWidth', 1.5);
% grid on
% xlabel('p_{inhom}');
% ylabel('k_*/k_{matrix}');
% legend('Voignt', 'Reuss');
% title(['Упругость модуль обьемного сжатия Voigt-Reuss: K_{matrix} = ', num2str(k1), ', K_{inhomogenity} = ', num2str(k2)]);
% 
% subplot(1,2,2)
% plot(p2, mu_voigt / mu1, p2, mu_reuss / mu1, 'LineWidth', 1.5);
% grid on
% xlabel('p_{inhom}');
% ylabel('k_*/k_{matrix}');
% legend('Voignt', 'Reuss');
% title(['Упругость модуль сдвига Voigt-Reuss: \mu_{matrix} = ', num2str(mu1), ', \mu_{inhomogenity} = ', num2str(mu2)]);
% 
% 
% 

% %Теплопроводность
% 
% k1 = 700; %Матрица
% k2 = 300;
% 
% p2 = 0 : 0.01 : 1;
% p1 = 1 - p2;
% 
% 
% 
% figure()
% plot(p2, k_hs_high / k1, p2, k_hs_low / k1, 'LineWidth', 1.5);
% grid on
% xlabel('p_{inhom}');
% ylabel('k_*/k_{matrix}');
% legend('Hashin-Shtrikman high', 'Hashin-Shtrikman low');
% title(['Теплопроводность Hashin-Shtrikman: k_{matrix} = ', num2str(k1), ', k_{inhomogenity} = ', num2str(k2)]);
% 



