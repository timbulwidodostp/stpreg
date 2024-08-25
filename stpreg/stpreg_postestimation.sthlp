{smcl}
{* *! version 1.0.0 01jun2010}{...}

{title:Title}

{p2colset 5 30 35 2}{...}
   Postestimation tools for stpreg
{p2colreset}{...}


{title:Introduction}

{pstd}
The following postestimation commands are of special interest after the most
recently fit event-probability regression model using {helpb stpreg}.

{title:Postestimation commands}

{synoptset 18}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb estat ic##estat ic:estat ic}}Akaike's and Schwarz's Bayesian information criteria (AIC and BIC){p_end}
{synopt :{helpb estat summarize##estat summarize:estat summarize}}summary statistics for the estimation sample{p_end}
{synopt :{helpb estat vce##estat vce:estat vce}}variance-covariance matrix of the estimators (VCE){p_end}
{synopt :{helpb estimates##estimates:estimates}}cataloging estimation results{p_end}
{synopt :{helpb hausman##hausman:hausman}}Hausman's specification test{p_end}
{synopt :{helpb lincom##lincom:lincom}}point estimates, standard errors, testing, and inference for linear combinations of coefficients{p_end}
{synopt :{helpb lrtest##lrtest:lrtest}}likelihood-ratio test{p_end}
{synopt :{helpb nlcom##nlcom:nlcom}}l point estimates, standard errors, testing, and inference for nonlinear combinations of coefficients{p_end}
{synopt :{helpb stpreg postestimation##predict:predict}}predictions of probabilities, odds function, hazard functions and other functions after stpreg{p_end}
{synopt :{helpb test##test:test}}Wald tests of simple and composite linear hypotheses{p_end}
{synopt :{helpb testnl##testnl:testnl}}Wald tests of nonlinear hypotheses{p_end}


{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {newvar} {ifin} [{cmd:,} {it:statistic}]

{synoptset 25 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab:Main}
{synopt :* {opt p:robability}}event-probability function{p_end}
{synopt :* {opt h:azard}}hazard function{p_end}
{synopt :* {opt cumh:azard}}cumulative hazard function{p_end}
{synopt :* {opt s:urvival}}survival function{p_end}
{synopt :* {opt f:ailure}}failure function{p_end}
{synopt :{opt mata}}the user-defined [log] hazard function contains a Mata only function, see details{p_end}
{synopt :{opt ci}}calculate confidence intervals{p_end}
{synopt :{opt time:var(varname)}}time variable used for predictions (default _t){p_end}
{synopt :{opt at(vn # [vn # ...])}}predict at values of specified covariates{p_end}
{synopt :{opt zero:s}}sets all covariates to zero (baseline prediction){p_end}
               
{syntab:Subsidiary}
{synopt :{opt l:evel}}sets confidence level (default 95){p_end}
{synoptline}
{p2colreset}{...}
{synoptset 0 tabbed}{...}
{synopt :* Either {opt probability}, {opt hazard}, {opt cumhazard}, {opt survival}, or {opt failure}  is required.}



{title:Description for predict}

{pstd}
{opt predict} creates a new variable containing predictions such as probabilities, hazard function, cumulative hazard, baseline survivor, and failure function.


{title:Options for predict}

{dlgtab:Main}

{phang}
{opt probability} calculates the predicted event-probabilities.

{phang}
{opt hazard} calculates the predicted hazard.

{phang}
{opt cumhazard} calculates the predicted cumulative hazard.

{phang}
{opt survival} calculates the predicted survivor function.

{phang}
{opt failure} calculates the predicted failure function (1-survival).

{phang}
{opt mata} uses Mata to calculate the prediction, required when a Mata only function is included in the 
user-defined [log] hazard function used to fit the model. {cmd:ci} is not available when {cmd:mata} is used.

{phang}
{opt ci} calculates a confidence interval for the requested statistic and
stores the confidence limits in {it:newvar}{cmd:_lci} and
{it:newvar}{cmd:_uci}.

{phang}
{opt timevar(varname)} defines the variable used as time in the predictions.
Default {it:varname} is {cmd:_t}. This is useful for large datasets where 
for plotting purposes predictions are only needed for 200 observations for example. 
Note: unless {opt at()} and/or {opt zeros} are specified, predictions are made at the covariate values for the first 200 rows of data.

{phang}
{opt at(varname # [ varname # ...])} requests that the covariates specified by 
the listed {it:varname}(s) be set to the listed {it:#} values. For example,
{cmd:at(x1 1 x3 50)} would evaluate predictions at {cmd:x1} = 1 and
{cmd:x3} = 50. Variables not listed in {opt at()}, are set to their sample
values. Add option {opt zeros} to set all the other covariates to zero.

{phang}
{opt zeros} sets all covariates to zero (baseline prediction). For 
example, {cmd:predict s0, survival zeros} calculates the baseline
survival function. See also {opt at()}.



{dlgtab:Subsidiary}

{phang}
{opt level(#)} sets the confidence level; default is {cmd:level(95)}
or as set by {help set level}.


{title:Examples}

{pstd}Setup{p_end}
{phang2}{stata "webuse brcancer"}{p_end}
{phang2}{stata "stset rectime, failure(censrec = 1) scale(365.25)"}{p_end}

{pstd}Proportional log odds-model{p_end}
{phang2}{stata "stpreg hormon, df(2)"}{p_end}
{phang2}{stata "predict prob1, probability ci"}{p_end}
{phang2}{stata "twoway line prob1 _t if hormon==0, sort || line prob1 _t if hormon==1, sort"}{p_end}
{phang2}{stata "predict surv1, survival ci"}{p_end}
{phang2}{stata "twoway line surv1 _t if hormon==0, sort || line surv1 _t if hormon==1, sort"}{p_end}
