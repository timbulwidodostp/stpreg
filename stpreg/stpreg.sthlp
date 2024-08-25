{smcl}
{* *! version 1.0.0  05sep2019}{...}
{cmd:help stpreg}
{hline}

{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{hi:stpreg} {hline 2}}Probability of Occurrence of Events Models{p_end}
{p2colreset}{...}

{title:Syntax}
{phang}

{p 8 13 2}
{cmd:stpreg} [{indepvars}] {ifin} 
	[{cmd:,} {it:options}]

{synoptset 25 tabbed}{...}
{synopthdr :options}
{synoptline}
{syntab :Model}
{synopt :{opt df(#)}}apply a restricted cubic spline transformation (RCS) with {it:#} degrees of freedom either to log time or to time{p_end}
{synopt :{opt noort:hog}}turns off the default orthogonalisation of the splines{p_end}
{synopt :{opt time}}create splines using time rather than log time, the default{p_end}
{synopt :{opt tvc(varlist)}}time-varying covariates{p_end}
{synopt :{opt tvcdf(#)}}degrees of freedom for the time-varying interaction terms; default is {opt df(#)}{p_end}
{synopt :{opt timef:unction(string)}}user defined function of time{p_end}

{syntab :Maximization options}
{synopt :{opt nodes(#)}}number of quadrature nodes; default is 15{p_end}
{synopt :{opt search(string)}}search option to pass to {opt ml}{p_end}
{synopt :{opt initmat(matrix_name)}}matrix of initial values to pass to {opt ml}{p_end}
{synopt :{opt copy}}parameters in the initial values matrix are entered by position{p_end}
{synopt :{opt skip}}skip any parameters found in initial values matrix but not in model{p_end}

{syntab :Reporting}
{synopt :{opt rr}}report risk ratios instead of odds ratios{p_end}
{synopt :{opt rd}}report risk differences instead of odds ratios (default){p_end}
{synopt :{opt power}}report power instead of odds ratios (default){p_end}
{synopt :{opt coef}}report estimated coefficients instead of the exponentiated form. If the option {opt rd} is defined, {opt coef} is automatically specified{p_end}
{synopt :{opt showcomp:onent}}display the components in each equation of the model{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt nolog}}suppress display of log-likelihood iteration log{p_end}
{synopt :{opt matalogh:azard}}display the log hazard function passed to Mata{p_end}
{synopt :{opt matak:eep}}do not drop data from Mata after fitting a model{p_end}


{synoptline}

{p2colreset}{...}
{phang}See {manhelp stpreg_postestimation R:stpreg postestimation} for features
available after estimation.

{title:Description}

{pstd}
{cmd:stpreg} can estimate event-probabilities models which properly defines the instantaneous probability of an event. 
The command {cmd:stpreg} is based on Stata command {manhelp stgenreg R:stgenreg} developed by Michael J. Crowtherand and Paul C. Lambert.

{title:Options for stpreg}

{dlgtab:Model}

{phang}{opt df(#)} creates restricted cubic splines of either log time or time. df(#) defines the number of degrees of freedom.

{phang}{opt noorthog} turns off the default orthogonalisation of the restricted cubic splines.

{phang}{opt time} specifies that splines are created using time rather than log time, the default.

{phang}{opt tvc(varlist)} specifies those variables that vary continuously with respect to time, that is, time-varying covariates. {cmd:tvc()} requires {cmd:df()}, however, if both {cmd:tvc()} and {cmd:gfunctions()} are defined, {cmd:df()} is no longer needed.

{phang}{opt tvcdf(#)} defrees of freedom for the spline of time included in the interaxtion with the time-varyng covariates; default is {cmd:df({it:#})}. If {cmd:tvc()} is not defined, option {cmd:tvcdf()} is disregarded.

{phang}{opt timefunction} defines the  time function. {cmd:timefunction()} is any user defined function of #t written in Mata code, for example #t:^2.

{dlgtab:Maximization options}

{phang}{opt nodes(#)} defines the number of Gauss-Legendre quadrature points used to evaluate the cumulative hazard function in the maximisation process. Must be an integer > 2, with default 15. 

{phang}{opt search(string)} search option to pass to ml.

{phang}{opt initmat(matrix_name)} passes a matrix of initial values. 

{phang}{opt copy}  pass initial values by position rather than name. 

{phang}{opt skip} any parameters found in the initial values matrix but not in model are skipped. 

{phang}{it:maximize_options}; {opt dif:ficult}, {opt tech:nique(algorithm_spec)}, {opt iter:ate(#)}, {opt [no]}{opt lo:g}, {opt tr:ace}, {opt grad:ient}, {opt showstep}, {opt hess:ian}, {opt shownr:tolerance}, {opt tol:erance(#)}, {opt ltol:erance(#)}, {opt gtol:erance(#)}, {opt nrtol:erance(#)}, {opt nonrtol:erance}, {opt from(init_specs)}; see {manhelp maximize R}. These options are seldom used, but the {opt difficult} option may be useful if there are convergence problems.

{dlgtab:Reporting}

{phang}{opt rd} reports the risk differences instead of the log-odds ratios.
	Note that option {opt eform} can not be specified with {opt rd}.
	This model is less stable than the other models.

{phang}{opt rr} reports the log risk ratios instead of the log-odds ratios.
	This model is less stable than the log-odds or log-power models.
	The model becomes more stable by specifing option {opt dif:ficult} or by 
	increasing the number of quadrature nodes.

{phang}{opt power} reports the log power-probabilities instead of the log-odds.

{phang}{opt coef} report estimated coefficients instead of the exponentiated form. If the option {opt rd} is defined, {opt coef} is automatically specified.

{phang}{opt showcomponent} displays each parsed component specified in the {opt eq_name} options. This is useful to check that the options have been parsed correctly.

{phang}{opt level(#)} specifies the confidence level for confidence intervals.  The default is {opt level(95)} or as set by {helpb set level}. See 
{helpb estimation options##level():[R] estimation options}

{phang}{opt nolog} suppresses showing the iteration log of the progress of the log likelihood.

{phang}{opt mataloghazard} displays the log hazard function passed to Mata. This is useful to check that the log hazard function of the model.

{phang}{opt matakeep} does not drop the data from Mata following a model fit. By default, all data passed to Mata are dropped.


{title:Examples}

{phang2}{stata "webuse brcancer"}{p_end}
{phang2}{stata "stset rectime, failure(censrec = 1) scale(365.25)"}{p_end}

{pstd}Proportional log odds-model{p_end}
{phang2}{stata "stpreg hormon"}{p_end}

{pstd}Proportional risk-difference model{p_end}
{phang2}{stata "stpreg hormon, rd"}{p_end}

{pstd}Proportional risk-ratio model{p_end}
{phang2}{stata "stpreg hormon, rr"}{p_end}

{pstd}Odds-model with spline time and time-varying covariate{p_end}
{phang2}{stata "stpreg hormon, df(3) tvc(hormon)"}{p_end}

{pstd}Odds-model with spline time and time-varying covariate{p_end}
{phang2}{stata "stpreg hormon, df(3) tvc(hormon) tvcdf(1)"}{p_end}

{pstd}Odds-model with timefunction() function of time and time-varying covariate{p_end}
{phang2}{stata "stpreg hormon, timefunction(#t:^2) tvc(hormon)"}{p_end}

{pstd}Proportional power-model equivalent to a Cox regression{p_end}
{phang2}{stata "stpreg hormon, power df(3) nolog"}{p_end}
{phang2}{stata "stcox hormon"}{p_end}

{title:References}

{phang2}Bottai M, Discacciati A, Santoni G (2019). Modeling the probability of occurrence of events. Submitted.{p_end}

{phang2}Bottai, M. (2017). A regression method for modelling geometric rates. Statistical Methods in Medical Research 26(6), 2700-2707.{p_end}

{phang2}Discacciati, A. and M. Bottai (2017). Instantaneous geometric rates via generalized linear models. Stata Journal 17(2), 358-371.{p_end}

{title:Authors}

{pstd}Matteo Bottai{p_end}
{pstd}Unit of Biostatistics{p_end}
{pstd}{browse "http://ki.se/imm":Institute of Environmental Medicine}, Karolinska Institutet{p_end}
{pstd}Stockholm, Sweden{p_end}

{pstd}Andrea Discacciati{p_end}
{pstd}{browse "https://ki.se/en/meb":Department of Medical Epidemiology and Biostatistics}, Karolinska Institutet{p_end}
{pstd}Stockholm, Sweden{p_end}

{pstd}Giola Santoni{p_end}
{pstd}Upper Gastrointestinal Unit{p_end}
{pstd}{browse "https://ki.se/en/mmk/department-of-molecular-medicine-and-surgery":Department of Molecular Medicine and Surgery}, Karolinska Institutet{p_end}
{pstd}Stockholm, Sweden{p_end}

{title:Acknowledgement}

{pstd}The stpreg command was developed from the stgenreg command.{p_end}
{pstd}Crowther, M. and Lambert, P. (2013). stgenreg: A stata package for general parametric
survival analysis. Journal of Statistical Software 53, 1-17.{p_end}

{title:Also see}

{psee}
Online:  {manhelp st R:st},  {manhelp stgenreg R:stgenreg}
{p_end}
