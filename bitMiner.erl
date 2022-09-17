-module(miner).
-import(strings,[chr/0]).
-export([start/0]).

initiate_server(Term) -> 
    

start() ->
    {ok, Term} = io:read("Enter No. of Leading Zeroes in hashed String else using a worker node enter the server IP:"),
    inp = string:chr(Term, "."),
    if 
        inp >= 0 -> 
            initiate_worker(Term);
    true -> 
        initiate_server(Term)
    end.