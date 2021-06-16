%%%-------------------------------------------------------------------
%%% @author yr
%%% @copyright (C) 2021, <yanFan>
%%% @doc
%%%
%%% @end
%%% Created : 11. 1月 2021 18:23
%%%-------------------------------------------------------------------
-module(g_return_svr).
-author("yr").

-behavior(grpc_return_bhvr).

%% API
-export([get_money/2]).

-callback get_money(ctx:ctx(), ct_return_pb:account_plat()) ->
    {ok, ct_return_pb:charge(), ctx:ctx()} | grpcbox_stream:grpc_error_response().
get_money(CTX, #{account := Account}) ->
    Money1 = case return_charge:get_account_money(Account) of
                 Money when Money > 0 ->
                     Money;
                 _ ->
                     0
             end,
    Reply = #{money => Money1},
    {ok, Reply, CTX}.