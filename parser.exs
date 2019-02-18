nemesesMap = File.stream!("nemesis.js")
|> Enum.reduce(%{}, fn(line, acc) ->
  nemesisEntry = Regex.named_captures(~r/["'](?<name>\w+)["'],\s?["'](?<set>\w+)["']/, line)
  Map.put(acc, nemesisEntry["name"], nemesisEntry)
end)

