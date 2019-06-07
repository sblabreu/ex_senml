defmodule ExSenmlNormalizerTest do
  use ExUnit.Case
  # use Broadway
  alias ExSenml.Resolver
  # doctest Senml

  @senml_payload_base_fields [
    %{bn: "1234", bt: 1_559_813_429, bu: "%RH", v: 20},
    %{u: "lon", v: 24.30621},
    %{u: "lat", v: 60.07965},
    %{n: "tracker", t: 60, v: 20.3}
  ]

  @senml_payload_rsv_rec_1 [
    %{u: "lon", v: 24.30621},
    %{u: "lat", v: 60.07965}
  ]

  @senml_payload_rsv_rec_2 [
    %{n: "1234", u: "lon", v: 24.30621},
    %{u: "lat", v: 60.07965}
  ]

  @senml_payload_rsv_rec_3 [
    %{n: "1234", u: "lon", v: 24.30621, t: 1_559_813_429},
    %{u: "lat", v: 60.07965, t: 1_559_813_429}
  ]

  @non_valid_senml_payload [
    %{name_n: 1234},
    %{test_1: "lat", value: 60.07965, time: 1_559_813_429},
    %{u: "lat", v: 60.07965, t: 1_559_813_429}
  ]

  test "send base senml message" do
    ref = Resolver.record(@senml_payload_base_fields, %ExSenml.SenmlStruct{}, "1234", [])

    assert ref ==
             {:ok,
              [
                %{
                  n: "1234/tracker",
                  t: 1_559_813_429 + 60,
                  u: "%RH",
                  v: 20.3
                },
                %{n: "1234", u: "lat", v: 60.07965, t: 1_559_813_429},
                %{n: "1234", u: "lon", v: 24.30621, t: 1_559_813_429}
              ]}
  end

  test "send senml message 1" do
    ref = Resolver.record(@senml_payload_rsv_rec_1, %ExSenml.SenmlStruct{}, "1234", [])

    assert ref ==
             {:ok,
              [
                %{n: "1234", u: "lat", v: 60.07965, t: DateTime.to_unix(DateTime.utc_now())},
                %{n: "1234", u: "lon", v: 24.30621, t: DateTime.to_unix(DateTime.utc_now())}
              ]}
  end

  test "send senml message 2" do
    ref = Resolver.record(@senml_payload_rsv_rec_2, %ExSenml.SenmlStruct{}, "1234", [])

    assert ref ==
             {:ok,
              [
                %{n: "1234", u: "lat", v: 60.07965, t: DateTime.to_unix(DateTime.utc_now())},
                %{n: "1234", u: "lon", v: 24.30621, t: DateTime.to_unix(DateTime.utc_now())}
              ]}
  end

  test "send senml message 3" do
    ref = Resolver.record(@senml_payload_rsv_rec_3, %ExSenml.SenmlStruct{}, "1234", [])

    assert ref ==
             {:ok,
              [
                %{n: "1234", u: "lat", v: 60.07965, t: 1_559_813_429},
                %{n: "1234", u: "lon", v: 24.30621, t: 1_559_813_429}
              ]}
  end

  test "send non_valid_senml_payload" do
    ref = Resolver.record(@non_valid_senml_payload, %ExSenml.SenmlStruct{}, "1234", [])
    assert ref == {:ok, [%{n: "1234", t: 1_559_813_429, u: "lat", v: 60.07965}]}
  end
end
