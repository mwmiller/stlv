defmodule StlvTest do
  use ExUnit.Case
  doctest Stlv

  test "encode" do
    assert Stlv.encode("Howdy.", 127) == <<127, 6, 72, 111, 119, 100, 121, 46>>
    assert Stlv.encode(127, "Howdy") == :error
    assert Stlv.encode(127, 127) == :error
    assert Stlv.encode(<<127>>, 127) == <<127, 1, 127>>
  end

  test "decode" do
    assert Stlv.decode(<<127, 6, 72, 111, 119, 100, 121, 46>>) == {127, "Howdy.", ""}

    assert Stlv.decode(<<127, 6, 72, 111, 119, 100, 121, 46, 65, 66, 67>>) ==
             {127, "Howdy.", "ABC"}

    assert Stlv.decode(<<127, 6, 72, 111, 119, 100, 121>>) == :error
    assert Stlv.decode(<<248, 6, 72, 111, 119, 100, 121, 46>>) == :error
    assert Stlv.decode(<<127, 250, 72, 111, 119, 100, 121, 46>>) == :error
  end

  test "round-trip" do
    assert Stlv.encode("Howdy.", 1) |> Stlv.decode() == {1, "Howdy.", ""}
    assert (Stlv.encode("Howdy.", 1) <> "Extra") |> Stlv.decode() == {1, "Howdy.", "Extra"}
  end
end
