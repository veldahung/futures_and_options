function Binomial_Value = Binomial_BS(S0,K,r,q,sigma,T,ExerciseType,NT)

dt=T/NT;
u=exp(sigma*sqrt(dt));
d=1/u;
a=exp((r-q)*dt);
p=(a-d)/(u-d);

f=zeros(NT+1, NT+1);

%option prices at maturity
for j = 0:NT;
    %Put
    f(NT+1,j+1)=max(K-S0*(u^j)*(d^(NT-j)),0);
end;

%backward induction
for i = (NT-1):-1:0;
    for j = 0:i;
        if(ExerciseType=='a')
            %put american
            EV=max(K-S0*(u^j)*(d^(i-j)),0);
            f(i+1,j+1)=max(EV,exp(-r*dt)*(p*f(i+2,j+2)+(1-p)*f(i+2,j+1)));
        else
            %put europen
            f(i+1,j+1)=max(0,exp(-r*dt)*(p*f(i+2,j+2)+(1-p)*f(i+2,j+1)));
        end;
    end;
end;

Binomial_Value=f(1,1)
end
