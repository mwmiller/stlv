defmodule Stlv do
  @moduledoc """
  Simple type-length-value.
  Type and length are encoded as Varu64
  """

  @doc """
  Encode arbitrary binary in sltv form.

  ## Examples

      iex> Stlv.encode("💩", 256)               
      <<249, 1, 0, 4, 240, 159, 146, 169>>
  """
  @spec encode(binary, non_neg_integer) :: binary
  def encode(value, type) when is_binary(value) and is_integer(type) and type >= 0 do
    Varu64.encode(type) <> Varu64.encode(byte_size(value)) <> value
  end

  def encode(_, _), do: :error

  @doc """
  Decode arbitrary binary in sltv form.

  Returns {type, value, rest_of_binary} on success.

  ## Examples

      iex> Stlv.decode(<<249, 1, 0, 4, 240, 159, 146, 169, 77, 111, 114, 101>>)
      {256, "💩", "More"}
  """
  @spec decode(binary) :: {non_neg_integer, binary, binary} | :error
  def decode(stlv) when is_binary(stlv) do
    case Varu64.decode(stlv) do
      :error ->
        :error

      {type, lv} ->
        case Varu64.decode(lv) do
          :error ->
            :error

          {len, v} ->
            case byte_size(v) >= len do
              false ->
                :error

              true ->
                <<val::binary-size(len), rest::binary>> = v
                {type, val, rest}
            end
        end
    end
  end

  def decode(_), do: :error
end
