clear; clc;

a = -1; b = 0;
t_0 = 0; T = 1.0;

mu = @(t) log(2./(exp(t) - 2*t.*exp(-t)));
u_init = @(x) log(2./(1 - 2*x));

N = 50;
M = 200;

h = (b - a)/N;
tau = (T - t_0)/M;

x = a:h:b;
t = t_0:tau:T;

u = zeros(M + 1,N + 1);

u(1,:) = u_init(x);
u(2:M + 1,N + 1) = mu(t(2:M + 1));

for m = 1:M
    for n = N:-1:1
        S = 10;
        x_temp = zeros(1,S + 1);
        x_temp(1) = u(m + 1,n + 1);
        for s = 1:S
            x_temp(s + 1) = x_temp(s) - f(x_temp(s),u(m,n),u(m + 1,n + 1),h,tau,t(m + 1))/...
                f_x(x_temp(s),h,tau,t(m + 1));
        end
        u(m + 1,n) = x_temp(S + 1);
    end
end

figure;

for m = 1:(M + 1)
    plot(x,u(1,:),'-g','LineWidth',3); hold on;
    plot(x,u(m,:),'-or','MarkerSize',3,'LineWidth',3); hold on;
    axis([a b -0.6 1.2]);
    xlabel('X');
    ylabel('U');
    title('Решение уравнения переноса');
    txt2 = num2str(m); txt1 = 'Итерация = ';
    txt = [txt1 ' ' txt2] ;
    text(-0.3,0.85,txt);
    legend('Начальное условие','Решение'); %из-за этого тормозит
    hold off; drawnow; pause(0.01);
    
end





