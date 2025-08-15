options msglevel=n;

%macro CreateDS(myDS);
  %let i = 1;
  %let DS = %scan(&myDS, &i);

  %do %until(&DS = %nrstr());
    %let Prefix = %lowcase(%substr(&DS, 1, 2));
    %let Suffix = %lowcase(%substr(&DS, %eval(%length(&DS)-1)));

    %if (&Prefix = p_) %then %let BeginYear = 2017;
   	%else %if (&Suffix = _s) %then %do;
	  %let Suffix = %lowcase(%substr(&DS, %eval(%length(&DS)-3)));
      %if (&Suffix = _d_s) %then %let BeginYear = 2005;
      %else %if (&Suffix = _c_s) %then %let BeginYear = 2003;
      %else %if (&Suffix = _b_s) %then %let BeginYear = 2001;
      %else %let BeginYear = 1999;
    %end;
    %else %if (&Suffix = _l) %then %let BeginYear = 2021;
    %else %if (&Suffix = _j) %then %let BeginYear = 2017;
    %else %if (&Suffix = _i) %then %let BeginYear = 2015;
    %else %if (&Suffix = _h) %then %let BeginYear = 2013;
    %else %if (&Suffix = _g) %then %let BeginYear = 2011;
    %else %if (&Suffix = _f) %then %let BeginYear = 2009;
    %else %if (&Suffix = _e) %then %let BeginYear = 2007;
    %else %if (&Suffix = _d) %then %let BeginYear = 2005;
    %else %if (&Suffix = _c) %then %let BeginYear = 2003;
    %else %if (&Suffix = _b) %then %let BeginYear = 2001;
    %else %let BeginYear = 1999;

    filename nhanes url "https://wwwn.cdc.gov/nchs/data/nhanes/public/&BeginYear/datafiles/&DS..xpt";
    libname nhanes xport;
    data &DS;
      set nhanes.&DS;
    run;

    %let i = %eval(&i+1);
    %let DS = %scan(&myDS, &i);
  %end;
%mend CreateDS;
