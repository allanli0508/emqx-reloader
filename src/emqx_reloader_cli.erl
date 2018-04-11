%%--------------------------------------------------------------------
%% Copyright (c) 2013-2018 EMQ Enterprise, Inc. (http://emqtt.io)
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(emqx_reloader_cli).

-author("Feng Lee <feng@emqtt.io>").

-include_lib("emqx/include/emqx_cli.hrl").

-export([load/0, cmd/1, unload/0]).

load() -> emqx_ctl:register_cmd(reload, {?MODULE, cmd}, []).

cmd([Module]) ->
    case emqx_reloader:reload_module(list_to_atom(Module)) of
        {module, _Mod} ->
            ?PRINT("Reload module ~s successfully.~n", [Module]);
        {error, Reason} ->
            ?PRINT("Failed to reload module ~s: ~p.~n", [Module, Reason])
    end;

cmd(_) ->
    ?USAGE([{"reload <Module>", "Reload a Module"}]).

unload() -> emqx_ctl:unregister_cmd(reload).
