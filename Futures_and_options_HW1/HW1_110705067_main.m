clear;

%parameters
T=2;
S0=50;
K=52;
r=0.05;
q=0;
sigma=0.3;
ExerciseType='a';%'a' for American option, 'e' for European option
OptionType='p';%'p' for put option, 'c' for call option

nt=252*T;
dt=T/nt;
u=exp(sigma*sqrt(dt));
d=1/u;
a=exp((r-q)*dt);
p=(a-d)/(u-d);

N_Steps=252*T;
Option_Value=zeros(N_Steps,1);

for i= 1:N_Steps;
    NT=i;
    Option_Value(i)=Binomial_BS(S0,K,r,q,sigma,T,ExerciseType,NT);
end;


disp(['N_Steps = ', num2str(N_Steps)]);
disp(['u = ', num2str(u)]);
disp(['d = ', num2str(d)]);
disp(['p = ', num2str(p)]);
disp(['Option price = ', num2str(Option_Value(N_Steps))]);
BS=BS(S0,K,r,q,sigma,T,OptionType);
BS_plot=BS*ones(N_Steps,1);
plot(1:N_Steps, Option_Value, 1:N_Steps, BS_plot);
xlim([0 250]);



disp(['N_Steps = ', num2str(N_Steps)]);
disp(['Binomial Option Price: ', num2str(Option_Value(N_Steps))]);
disp(['Black-Scholes Option Price: ', num2str(BS)]);
disp(['Binomial Option Price - Black-Scholes Option Price: ', num2str(Option_Value(N_Steps)-BS)]);



