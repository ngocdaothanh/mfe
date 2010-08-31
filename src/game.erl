-module(game).

-behaviour(gen_fsm).

%% External exports
-export([]).

%% gen_fsm callbacks
-export([init/1,
    state_name/2, state_name/3,
    handle_event/3, handle_sync_event/4, handle_info/3, terminate/3, code_change/4]).

-record(state, {watchers=[], players=[]}).

%% ====================================================================
%% External functions
%% ====================================================================


%% ====================================================================
%% Server functions
%% ====================================================================
init([]) ->
    {ok, not_enough_players, #state{}}.

not_enough_players({enter, upid}, StateData) ->
    {next_state, state_name, StateData}.

playing({enter, upid}, StateData) ->
    {next_state, state_name, StateData}.

game_over({enter, upid}, StateData) ->
    {next_state, state_name, StateData}.

playing(Event, From, StateData) ->
    Reply = ok,
    {reply, Reply, state_name, StateData}.

handle_event(Event, StateName, StateData) ->
    {next_state, StateName, StateData}.

handle_sync_event(Event, From, StateName, StateData) ->
    Reply = ok,
    {reply, Reply, StateName, StateData}.

handle_info(Info, StateName, StateData) ->
    {next_state, StateName, StateData}.

terminate(Reason, StateName, StatData) ->
    ok.

code_change(OldVsn, StateName, StateData, Extra) ->
    {ok, StateName, StateData}.

%% --------------------------------------------------------------------
%% Internal functions
%% --------------------------------------------------------------------

