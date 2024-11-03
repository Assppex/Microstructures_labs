% ������ ���������� ��������� �� �������� ����
p = 0 : 0.1 : 1;
 % ������ �������� ��� ���������
m = [1; 0; 0];
% ��������� ������
alpha = 0; %���� 0, �� ����, ���� 1, �� ���������������� ����� � �� ����� 
% �� ����� ����� �������, �� ���� ������ ������ �����������
gamma = 0.8;
k_matrix = 10;

[k_eff_by_k1, k_eff_by_r1] = get_k_eff(alpha, gamma, k_matrix, 1, m, p);
[k_eff_by_k2, k_eff_by_r2] = get_k_eff(alpha, gamma, k_matrix, 2, m, p);
[k_eff_by_k3, k_eff_by_r3] = get_k_eff(alpha, gamma, k_matrix, 3, m, p);

draw_k_eff(k_eff_by_k1, k_eff_by_r1, p, k_matrix, k_matrix * alpha, 1);
draw_k_eff(k_eff_by_k2, k_eff_by_r2, p, k_matrix, k_matrix * alpha, 2);
draw_k_eff(k_eff_by_k3, k_eff_by_r3, p, k_matrix, k_matrix * alpha, 3);

