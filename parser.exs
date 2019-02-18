nemesesMap =
  File.stream!("nemesis.js")
  |> Enum.reduce(%{}, fn line, acc ->
    nemesisEntry = Regex.named_captures(~r/["'](?<name>\w+)["'],\s?["'](?<set>\w+)["']/, line)
    Map.put(acc, nemesisEntry["name"], nemesisEntry)
  end)

cardsMap =
  File.stream!("cards.js")
  |> Enum.reduce(%{}, fn line, acc ->
    cardEntry =
      Regex.named_captures(
        ~r/["'](?<name>\w+)["'],\s?["'](?<type>\w+)["'],\s?(?<cost>\d),\s?["'](?<set>\w+)["']/,
        line
      )

    Map.put(acc, cardEntry["name"], cardEntry)
  end)

