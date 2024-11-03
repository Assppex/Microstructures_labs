function [k_effective_values_by_k, k_effective_values_by_r] = get_k_eff(alpha, gamma, k0, mic_case, m, p_linspace)
% k,r - ������� ������ � ���������������� � �������������
    % ������ �������� ������� � ��������������� ����� \alpha
    k1 = alpha * k0;

    % ������ ������ �����

    % ������ g

    if gamma == 0
        g = 0;
    elseif gamma < 1
        g = 1/ (gamma * sqrt(1 - gamma^2)) * atan(sqrt(1 - gamma^2) / gamma);
    elseif gamma > 1
        g = 1 / (2*gamma*sqrt(gamma^2 - 1)) * ln((gamma + sqrt(gamma^2 - 1)) / (gamma - sqrt(gamma^2 - 1)));
    end

    % ������� f0
    f0 = (1 - g) / (2 * (1 - gamma ^ -2));
    
    m = m / (sqrt(m(1)^2 + m(2)^2 + m(3)^2)); %��������� m

    m_diad = zeros(3);

    for i = 1 : 1 : 3
        for j = 1 : 1 : 3
            m_diad(i, j) = m(i) * m(j);
        end
    end

    % ������� �������������� ��������� ������
    I = diag([1;1;1]);

    % ������� �������������� ������ ����� ���������

    P_sphrd = 1/k0 * (f0 * (I - m_diad) + (1 - 2*f0)*m_diad); 

    % ������� �������������� ������ ����� ����

    P_sph = 1 / (3*k0) * I;
    

    % ������� ����������� ���������������� (c ������ ��������� ������� � ������ ���)
    
    r0 = 1 / k0 * I;
    r_sphrd = 1 / k1 *I;
    r_sph = 1 / k1 * I;
    
    k0 = k0 * I;
    
    k_sphrd = k1 * I;
    k_sph = k1 * I;
    
    
    % ������� ������ ������ ����� Q
    
    Q_sphrd = k0 * (I - P_sphrd * k0);
    
    Q_sph = k0 * (I - P_sph * k0)

    % � ��� ����� ���� ����������� ��������������� ��������, ���� ����������
    % ����, ������� �������������� ��������� �������� ����� �� ������, ��������
    % �������������� �������������� ������� ������ � ���������������� (K_i),
    % ������� ���� ��� ������� ���� ��������������� (���� � ���������)
    
    %��������� � ����������� �� �������� ���� �������������� � �� �����
    %�������������� (a = 1, b = 2, c = each)
    
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
            % ����� ���������������� ��������������� ����� ���� (� ��� � ��� ��������� �� �������), ������, 
            % ��� ���������������� ����� ������ (����������), � ������
            % ����� ���������� ��������������� �������� � ���������������
            % ��������� (�.�. � ��� ��� ��������� �� ��� r0, ���� � �������� ������� ������ ��������� ���� 1 / r0 --> 0 (r0 --> inf))
        end

        count = count + 1;
    end
end

