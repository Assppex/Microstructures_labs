function [k_effective_values_by_k, k_effective_values_by_r] = get_k_eff(alpha, gamma, k0, mic_case, m, p_linspace)
% k,r - тензоры вклада в теплопроводность и резестивность
    % Задаем свойства матрицы и неоднородностей через \alpha
    k1 = alpha * k0;

    % Строим тензор Хилла

    % Задаем g

    if gamma == 0
        g = 0;
    elseif gamma < 1
        g = 1/ (gamma * sqrt(1 - gamma^2)) * atan(sqrt(1 - gamma^2) / gamma);
    elseif gamma > 1
        g = 1 / (2*gamma*sqrt(gamma^2 - 1)) * ln((gamma + sqrt(gamma^2 - 1)) / (gamma - sqrt(gamma^2 - 1)));
    end

    % Задачем f0
    f0 = (1 - g) / (2 * (1 - gamma ^ -2));
    
    m = m / (sqrt(m(1)^2 + m(2)^2 + m(3)^2)); %Нормируем m

    m_diad = zeros(3);

    for i = 1 : 1 : 3
        for j = 1 : 1 : 3
            m_diad(i, j) = m(i) * m(j);
        end
    end

    % Матрица олицетворяющая единичный тензор
    I = diag([1;1;1]);

    % Матрица олицетворяющая тензор Хилла сфероидов

    P_sphrd = 1/k0 * (f0 * (I - m_diad) + (1 - 2*f0)*m_diad); 

    % Матрица олицетворяющая тензор Хилла сфер

    P_sph = 1 / (3*k0) * I;
    

    % Подсчет эффективной теплопроводности (c учетом изотропии матрицы и прочих фаз)
    
    r0 = 1 / k0 * I;
    r_sphrd = 1 / k1 *I;
    r_sph = 1 / k1 * I;
    
    k0 = k0 * I;
    
    k_sphrd = k1 * I;
    k_sph = k1 * I;
    
    
    % Считаем второй тензор Хилла Q
    
    Q_sphrd = k0 * (I - P_sphrd * k0);
    
    Q_sph = k0 * (I - P_sph * k0)

    % У нас обьем всех сферических неоднородностей одинаков, всех сфероидных
    % тоже, выносим соответсвующие множители обьемных долей за скобки, остается
    % просуммировать соответсвующие тензоры вклада в теплопроводность (K_i),
    % которые свои для каждого вида неоднородностей (сфер и сфероидов)
    
    %Исследуем в зависимости от обьемной доли неоднородности и от кейса
    %микроструктуры (a = 1, b = 2, c = each)
    
    k_effective_values_by_k = zeros(3, 3, 11);
    k_effective_values_by_r = zeros(3, 3, 11);
    count = 1;
    for i = 1 : 1 : size(p_linspace, 2)
        if mic_case == 1
            
            p_sphere = p_linspace(i) / 2;
            p_spheroid = p_linspace(i) / 2;
            
        elseif mic_case == 2
            
            p_sphere = p_linspace(i);
            p_spheroid = 0;
        else 
            
            p_sphere = 0;
            p_spheroid = p_linspace(i);
        end
        
        k_effective_values_by_k(:, :, count) = k0 + p_spheroid * inv(inv(k_sphrd-k0) + P_sphrd) + p_sphere * inv(inv(k_sph - k0) + P_sph);
        if k1 ~= 0
            k_effective_values_by_r(:, :, count) = inv(r0 + p_spheroid * inv(inv(r_sphrd-r0) + Q_sphrd) + p_sphere * inv(inv(r_sph - r0) + Q_sph));
        else
            k_effective_values_by_r(:, :, count) = inv(r0 + p_spheroid * inv(Q_sphrd) + p_sphere * inv(Q_sph)); 
            % когда теплопроводность неоднородностей очень мала (а она у них одинакова по условию), значит, 
            % что сопротивляемость очень велика (бесконечна), а значит
            % можно пренебречь соответсвующщим обратным к сопротивлямости
            % слагаемым (т.к. у нас все изотропно см вид r0, явно в обратную матрицу войдут слагаемые вида 1 / r0 --> 0 (r0 --> inf))
        end

        count = count + 1;
    end
end

