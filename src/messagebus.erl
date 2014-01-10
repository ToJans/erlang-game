-module(messagebus).
-behaviour(gen_server).

-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link(Name) ->
  gen_server:start_link({local, Name}, messagebus, [], []).

init([]) ->
  { ok, []}.

handle_call(not_implemented, _From, State) ->
  {reply, ok, State}.
handle_cast(not_implemented, State) ->
  {noreply, State}.

handle_info({ subscribe, Pid}, ExistingPids ) ->
  { noreply, ExistingPids ++ [Pid]  };

handle_info({ unsubscribe, Pid}, ExistingPids ) ->
  { noreply, ExistingPids -- [Pid] };

handle_info({ broadcast, Msg}, ExistingPids ) ->
  [ Pid ! Msg || Pid <- ExistingPids ],
  { noreply, ExistingPids }.

%% TODO: This is probably important to hook as we need to tell clients we've vanished
terminate(_Reason, _State) -> ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.




