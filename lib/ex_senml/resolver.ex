defmodule ExSenml.Resolver do
  alias ExSenml.SenmlStruct

  def record([h | t], last_entries, id, rsv_rec) do
    senml_fields = %SenmlStruct{}

    with false <-
           Map.has_key?(h, :bn) or Map.has_key?(h, :bt) or Map.has_key?(h, :bv) or
             Map.has_key?(h, :bs) or Map.has_key?(h, :bver) do
      h =
        case Map.has_key?(h, :n) do
          false ->
            case last_entries.bn do
              nil ->
                Map.put(h, :n, id)

              name ->
                Map.put(h, :n, name)
            end

          true ->
            # TODO Validate name and 
            # IO.inspect h.n
            case String.starts_with?(h.n, id) do
              true ->
                # IO.inspect last_entries
                case last_entries.bn do
                  nil ->
                    h

                  name ->
                    Map.put(h, :n, name <> "/" <> h.n)
                end

              false ->
                # Force N to name
                Map.put(h, :n, id <> "/" <> h.n)
            end
        end

      # Normalize Field t:
      h =
        case Map.has_key?(h, :t) do
          false ->
            case last_entries.bt do
              nil ->
                Map.put(h, :t, DateTime.to_unix(DateTime.utc_now()))

              base_time_value ->
                Map.put(h, :t, base_time_value)
            end

          true ->
            case last_entries.bt do
              nil ->
                # TODO Need to check if it's unix time
                h

              base_time_value ->
                Map.put(h, :t, base_time_value + conv_abs_time(h.t))
                # |> IO.inspect
            end
        end

      # Normalize Field u: 
      h =
        case Map.has_key?(h, :u) do
          false ->
            case last_entries.bu do
              nil ->
                h

              name ->
                Map.put(h, :u, name)
            end

          true ->
            h
        end

      base_fields = struct!(senml_fields, Map.from_struct(last_entries))

      try do
        # TODO refactoring for the case when record odes not contain SenML fields and therefore not a valid Senml record.
        base_fields = struct!(base_fields, h)
        record(t, base_fields, id, [h | rsv_rec])
      rescue
        KeyError ->
          record(t, base_fields, id, rsv_rec)
      end

      # record(t, base_fields, id, [h | rsv_rec])
    else
      true ->
        base_fields = struct!(senml_fields, h)
        # |> IO.inspect
        record(t, base_fields, id, rsv_rec)
    end
  end

  def record([], _base_fields, _id, rsv_rec) do
    # IO.inspect(rsv_rec)
    {:ok, rsv_rec}
  end

  defp conv_abs_time(time) do
    case time <= 0 do
      true -> DateTime.to_unix(DateTime.utc_now()) + time
      false -> time
    end
  end
end
