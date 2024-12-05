options msglevel=n;

%macro CreateDS(myDS);
  %let i = 1;
  %let DS = %scan(&myDS, &i);

  %do %until(&DS = %nrstr());
    %let Prefix = %lowcase(%substr(&DS, 1, 2));
    %let Suffix = %lowcase(%substr(&DS, %eval(%length(&DS)-1)));
    
    %if (&Prefix = p_) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2017/datafiles/&DS..xpt"; %end;
    %else %if (&Suffix = _l) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2021/datafiles/&DS..xpt"; %end;
    %else %if (&Suffix = _j) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2017/datafiles/&DS..xpt"; %end;
    %else %if (&Suffix = _i) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2015/datafiles/&DS..xpt"; %end;
    %else %if (&Suffix = _h) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2013/datafiles/&DS..xpt"; %end;
    %else %if (&Suffix = _g) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2011/datafiles/&DS..xpt"; %end;
    %else %if (&Suffix = _f) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2009/datafiles/&DS..xpt"; %end;
    %else %if (&Suffix = _e) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2007/datafiles/&DS..xpt"; %end;
    %else %if (&Suffix = _d) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2005/datafiles/&DS..xpt"; %end;
    %else %if (&Suffix = _c) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2003/datafiles/&DS..xpt"; %end;
    %else %if (&Suffix = _b) %then %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/2001/datafiles/&DS..xpt"; %end;
    %else %do; filename &DS url "https://wwwn.cdc.gov/nchs/data/nhanes/public/1999/datafiles/&DS..xpt"; %end;

    libname &DS xport;
    data &DS;
      set &DS..&DS;
    run;

    %let i = %eval(&i+1);
    %let DS = %scan(&myDS, &i);
  %end;
%mend CreateDS;
