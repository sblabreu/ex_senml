defmodule ExSenml do
  @moduledoc """

  Toolset to Normalize SenML and other promises  

  SenML is an open ietf standard that defines a format for representing simple sensor
   measurements and device parameters in Sensor Measurement Lists (SenML)
  You can find the spec: https://tools.ietf.org/html/rfc8428
  Becoming more and more used within the IoT Domain, as common used standard for Constrained Application Protocol (CoAP)
  LwM2M 1.0 (https://tools.ietf.org/html/draft-ietf-core-senml) and LwM2M 1.0 uses the actual RFC.

  Also adding support for https://tools.ietf.org/html/draft-keranen-core-senml-data-ct-01 

  ## Features

    * (Basic) Normalized format for SenML Records (chapter 4.6 Resolve Records), A SenML Record is referred to as "resolved" if it does not contain
      any base value.
    * (TODO) Support Conversion between diferent representations defined in JavaScript Object Notation (JSON), 
      Concise Binary Object Representation (CBOR), eXtensible Markup Language (XML), and Efficient XML Interchange (EXI), 
      which share the common SenML data model. 

  ## Example 

    iex(1)> senml_payload_rsv_rec_1 = [%{u: "lon", v: 24.30621},%{u: "lat", v: 60.07965}]
    [%{u: "lon", v: 24.30621}, %{u: "lat", v: 60.07965}]
    iex(2)> ExSenml.Resolver.record(senml_payload_rsv_rec_1, %ExSenml.SenmlStruct{}, "1234", [])
    {:ok,
    [
      %{n: "1234", t: 1559941951, u: "lat", v: 60.07965},
      %{n: "1234", t: 1559941951, u: "lon", v: 24.30621}
    ]}

  ## TODO 

  - [x] Basic record normalization
  - [ ] Validate "n" fields caracters
  - [ ] Convert Beetween formats
  - [ ] Proper Documentation
  - [ ] Make the world adopt SenML


  """

  alias ExSenml.SenmlHandler

  defdelegate validate_and_resolve(payload,device_id), to: SenmlHandler
end
