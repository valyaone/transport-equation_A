function func = f(x,a,b,h,tau,t)
    func = (x - a)/tau - (b - x)/h - 1 + exp(t + x);
end
