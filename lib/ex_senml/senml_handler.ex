defmodule ExSenml.SenmlHandler do
  alias ExSenml.Resolver
  alias ExSenml.SenmlStruct

  def validate_and_resolve(body, id) when is_list(body) and length(body) >= 1 do
    Enum.fetch!(body, 0)
    resolve(body, Enum.fetch!(body, 0), id)
  end

  def validate_and_resolve(body, _id) when is_list(body) and length(body) == 0 do
    # TODO parse SenML Function ... for now basic validation
    body |> IO.inspect()
    {:not_acceptable, "Payload is not valid SenML"}
  end

  def validate_and_resolve(_, _id) do
    # TODO parse SenML Function ... for now basic validation
    {:not_acceptable, "Payload is not valid SenML"}
  end

  
  def resolve(body, %{bn: base_name} = _body_header, id) do
    # TODO parse SenML Function ... for now basic validation
    with {:ok, "Valid SenML Payload"} <- check_endpoint(base_name, id, :bn),
         {:ok, rsv_rec_senml} <- Resolver.record(body, %SenmlStruct{}, id, []) do
      {:ok, rsv_rec_senml}
    else
      {:not_acceptable, "Payload is not valid SenML"} ->
        {:not_acceptable, "Payload is not valid SenML"}
    end
  end

  def resolve(body, _body_header, id) do
    # TODO parse SenML Function ... for now basic validation
    with {:ok, rsv_rec_senml} <- Resolver.record(body, %SenmlStruct{}, id, []) do
      {:ok, rsv_rec_senml}
    else
      {:not_acceptable, "Payload is not valid SenML"} ->
        {:not_acceptable, "Payload is not valid SenML"}
    end
  end

  # def resolve(_, _, _id) do
  #   # TODO parse SenML Function ... for now basic validation
  #   {:not_acceptable, "Payload is not valid SenML"}
  # end

  def check_endpoint(base_name, id, :bn) do

    case base_name == id do
      true ->

        {:ok, "Valid SenML Payload"}

      false ->
        {:not_acceptable, "Payload is not valid SenML"}
    end
  end

  def check_endpoint(n_value, id, :n) do

    case String.starts_with?(n_value, id) do
      true -> {:ok, "Valid SenML Payload"}
      false -> {:not_acceptable, "Payload is not valid SenML"}
    end

  end
end
