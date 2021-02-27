// saved as 8schools.stan
data {
  int<lower=0> J;         // number of schools 
  int y[J];   // estimated treatment effects
  int n[J];
}
parameters {
  real mu;                // population treatment effect
  vector[J] eta;          // unscaled deviation from mu by school
  real<lower=0> tau;      // standard deviation in treatment effects
}
transformed parameters {
  vector[J] theta = mu + tau * eta;        // school treatment effects
  vector[J] p_i = inv_logit(theta);

}
model {
  tau ~ cauchy(0, 1);
  target += normal_lpdf(eta | 0, 1);       // prior log-density
  target += binomial_logit_lpmf(y | n, theta); // log-likelihood
}
