-module(infix2rpn).

%% Code reused from Internet and added some bug fixing
%% http://stackoverflow.com/questions/7242315/how-to-convert-infix-to-postfix-in-erlang
-export([p/1]).


p(Str) ->
	Tree = parse(Str),
	rpn(Tree),
	io:format("~n").


parse(Str) ->
	{ok, Tokens, _} = erl_scan:string(Str ++ "."),
	{ok, [E]} = erl_parse:parse_exprs(Tokens),
	E.

rpn({op, _, What, LS, RS}) ->
	rpn(LS),
	rpn(RS),
	io:format(" ~s ", [atom_to_list(What)]);
rpn({cons, _, LS, RS}) ->
	rpn(LS),
	rpn(RS);
rpn({var, _, N}) ->
	io:format(" ~s ", [N]);
rpn({integer, _, N}) ->
	io:format(" ~B ", [N]);
rpn({nil,1}) ->
    ok.

