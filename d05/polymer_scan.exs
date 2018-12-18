defmodule Polymer do
  def scan(p) do
    l = do_scan(String.graphemes(p), [])
    length(l)
  end

  def pair_react?(a, b) do
    cond do
      a == b -> false
      a == String.upcase(b) -> true
      String.upcase(a) == b -> true
      true -> false
    end
  end

  def do_scan([], l), do: l

  def do_scan([h], l), do: [h] ++ l

  def do_scan([h|t], []) do
    if pair_react?(h, hd(t)) do
      do_scan(tl(t), [])
    else
      do_scan(t, [h])
    end
  end

  
  def do_scan([h|t], l) do
    # IO.puts "Comparing #{h} to #{hd(t)}, l is #{l}}"
    if pair_react?(h, hd(t)) do
      do_scan([hd(l)] ++ tl(t), tl(l))
    else
      do_scan(t, [h] ++ l)
    end
  end
end

1 = Polymer.scan("A")
2 = Polymer.scan("AB")
2 = Polymer.scan("BA")
0 = Polymer.scan("Aa")
0 = Polymer.scan("aBbA")
1 = Polymer.scan("gaBbA")


poly = "dabAcCaCBAcCcaDA"
10 = Polymer.scan(poly)

real_polymer =
  File.stream!("polymer.txt")
  |> Stream.map(&String.trim/1)
  |> Enum.to_list

IO.inspect(Polymer.scan(hd(real_polymer)))