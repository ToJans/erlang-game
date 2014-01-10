-module(comms_handler).
-behaviour(cowboy_websocket_handler).
 
-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).
 
init({tcp, http}, _Req, _SocketMessageBus) ->
    {upgrade, protocol, cowboy_websocket}.
 
websocket_init(_TransportName, Req, SocketMessageBus) ->
    io:format(user, "Socket message bus ~p~n", [SocketMessageBus]),
    SocketMessageBus ! { subscribe, self() },
    {ok, Req, SocketMessageBus}.
 
websocket_handle({text, Msg}, Req, SocketMessageBus) ->
    SocketMessageBus ! { broadcast, {text, Msg} },
    {ok, Req, SocketMessageBus};

websocket_handle(_Data, Req, State) ->
    {ok, Req, State}.
 
websocket_info({text, Msg}, Req, State) ->
    {reply, { text, Msg }, Req, State};

websocket_info(_Info, Req, State) ->
    {ok, Req, State}.
 
websocket_terminate(_Reason, _Req, SocketMessageBus) ->
    SocketMessageBus ! { unsubscribe, self() },
    ok.
