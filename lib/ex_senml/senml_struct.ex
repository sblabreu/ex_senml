defmodule ExSenml.SenmlStruct do
  @moduledoc """

    Below Table provides an overview of all SenML fields defined by rfc8428
     with their respective labels and data types.

      +---------------+-------+------------+------------+------------+
      |          Name | Label | CBOR Label | JSON Type  | XML Type   |
      +---------------+-------+------------+------------+------------+
      |     Base Name | bn    |         -2 | String     | string     |
      |     Base Time | bt    |         -3 | Number     | double     |
      |     Base Unit | bu    |         -4 | String     | string     |
      |    Base Value | bv    |         -5 | Number     | double     |
      |      Base Sum | bs    |         -6 | Number     | double     |
      |  Base Version | bver  |         -1 | Number     | int        |
      |          Name | n     |          0 | String     | string     |
      |          Unit | u     |          1 | String     | string     |
      |         Value | v     |          2 | Number     | double     |
      |  String Value | vs    |          3 | String     | string     |
      | Boolean Value | vb    |          4 | Boolean    | boolean    |
      |    Data Value | vd    |          8 | String (*) | string (*) |
      |           Sum | s     |          5 | Number     | double     |
      |          Time | t     |          6 | Number     | double     |
      |   Update Time | ut    |          7 | Number     | double     |
      +---------------+-------+------------+------------+------------+

                            Table 1: SenML Labels

    This struct will be used to keep the field(s) values as helper for base fileds resolve record                         
  """

  @type t :: %__MODULE__{
          bn: String.t(),
          bt: integer,
          bu: String.t(),
          bv: integer,
          bs: integer,
          bver: integer,
          n: String.t(),
          t: integer,
          v: float,
          vs: String.t(),
          vd: String.t(),
          vb: boolean,
          s: integer,
          u: String.t(),
          ut: integer,
          ct: String.t()
        }
  @derive Jason.Encoder

  defstruct bn: nil,
            bt: nil,
            bu: nil,
            bv: nil,
            bs: nil,
            bver: nil,
            n: nil,
            t: nil,
            v: nil,
            vs: nil,
            vb: nil,
            vd: nil,
            s: nil,
            u: nil,
            ut: nil,
            ct: nil
end
