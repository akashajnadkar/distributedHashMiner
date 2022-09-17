-module(project_1).
-export([for/2,start/0,get_random_string/2,compare/4]).
-import(string,[concat/2,substr/3]).
-import(lists,[duplicate/2]). 


get_random_string(Length, AllowedChars) ->
        lists:foldl(fun(_, Acc) ->
                        [lists:nth(rand:uniform(length(AllowedChars)),
                                   AllowedChars)]
                            ++ Acc
                end, [], lists:seq(1, Length)).


compare(HshStrZero,MinZero,HshStr,NewVar) ->
    if 
            HshStrZero == MinZero -> io:fwrite(NewVar), io:fwrite("\t"), io:fwrite(HshStr), io:fwrite("\n");
            true ->          io:fwrite("") 

        end.

for(0,_) ->
    io:fwrite("");

    
    for(N,Term) when N>0 ->
        Temp=get_random_string(6,"abcdefghijklmnopqrstuvwxyz0123456789"),
        NameVar="a.ajnadkar;",
        NewVar=concat(NameVar,Temp),
        spawn(fun()->mine_coins(NewVar,Term)end),
        for(N-1,Term).

mine_coins(NewVar, Term) ->
    HshStr=io_lib:format("~64.16.0b", [binary:decode_unsigned(crypto:hash(sha256,NewVar))]),
    HshStrZero = substr(HshStr,1,Term), %storing leading Term number of zeroes in LeadZeroStr
    MaxZero = "0000000000000000000000000000000000000000000000000000000000000000",
    MinZero=substr(MaxZero,1,Term),
    %%io:format("~w \n",MinZero),
    compare(HshStrZero,MinZero,HshStr,NewVar).

start() ->
    {ok, Term} = io:read("Enter No. of Leading Zeroes in hashed String:"),
    %spawn(fun()->for(10000,Term)end).
    for(1000000,Term).
    
