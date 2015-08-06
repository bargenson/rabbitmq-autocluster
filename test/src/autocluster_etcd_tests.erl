-module(autocluster_etcd_tests).

-include_lib("eunit/include/eunit.hrl").

-include("autocluster.hrl").


extract_nodes_test() ->
  Values = [{struct, [{<<"key">>, <<"rabbitmq/default/foo">>}]},
            {struct, [{<<"key">>, <<"rabbitmq/default/bar">>}]},
            {struct, [{<<"key">>, <<"rabbitmq/default/baz">>}]}],
  Expectation = ["rabbit@foo", "rabbit@bar", "rabbit@baz"],
  ?assertEqual(Expectation, autocluster_etcd:extract_nodes(Values, [])).

base_path_test() ->
  autocluster_config_tests:reset_config(),
  ?assertEqual([v2, keys, "rabbitmq", "default"], autocluster_etcd:base_path()).

get_node_from_key_test() ->
  ?assertEqual("rabbit@foo", autocluster_etcd:get_node_from_key(<<"rabbitmq/default/foo">>)).

node_path_test() ->
  autocluster_config_tests:reset_config(),
  [_, Node] = string:tokens(atom_to_list(node()), "@"),
  Expectation = [v2, keys, "rabbitmq", "default", Node],
  ?assertEqual(Expectation, autocluster_etcd:node_path()).
