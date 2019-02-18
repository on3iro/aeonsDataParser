defmodule Parser do
  def getNemeses(), do: File.stream!("nemesis.js")
    |> Enum.reduce(%{}, fn line, acc ->
      nemesisEntry = Regex.named_captures(~r/["'](?<name>\w+)["'],\s?["'](?<set>\w+)["']/, line)
      Map.put(acc, nemesisEntry["name"], nemesisEntry)
    end)

  def getCards(), do: File.stream!("cards.js")
    |> Enum.reduce(%{}, fn line, acc ->
      cardEntry =
        Regex.named_captures(
          ~r/["'](?<name>\w+)["'],\s?["'](?<type>\w+)["'],\s?(?<cost>\d),\s?["'](?<set>\w+)["']/,
          line
        )

      Map.put(acc, cardEntry["name"], cardEntry)
    end)

  def getMages(), do: File.stream!("mages.js")
    |> Enum.reduce(%{}, fn line, acc ->
      magesEntry = Regex.named_captures(~r/["'](?<name>\w+)["'],\s?["'](?<set>\w+)["']/, line)
      Map.put(acc, magesEntry["name"], magesEntry)
    end)

  def getForSet(map, set) do
    Map.values(map)
    |> Enum.filter(fn value -> value["set"] == set end)
  end

  def main() do
    magesMap = getMages()
    nemesesMap = getNemeses()
    cardsMap = getCards()

    resultMap = %{
      AE: %{
        mages: getForSet(magesMap, "AE"),
        nemeses: getForSet(nemesesMap, "AE"),
        cards: getForSet(cardsMap, "AE")
      },
      Nameless: %{
        mages: getForSet(magesMap, "Nameless"),
        nemeses: getForSet(nemesesMap, "Nameless"),
        cards: getForSet(cardsMap, "Nameless")
      },
      Depths: %{
        mages: getForSet(magesMap, "Depths"),
        nemeses: getForSet(nemesesMap, "Depths"),
        cards: getForSet(cardsMap, "Depths")
      },
      WE: %{
        mages: getForSet(magesMap, "WE"),
        nemeses: getForSet(nemesesMap, "WE"),
        cards: getForSet(cardsMap, "WE")
      },
      OD: %{
        mages: getForSet(magesMap, "OD"),
        nemeses: getForSet(nemesesMap, "OD"),
        cards: getForSet(cardsMap, "OD")
      },
      TV: %{
        mages: getForSet(magesMap, "TV"),
        nemeses: getForSet(nemesesMap, "TV"),
        cards: getForSet(cardsMap, "TV")
      },
      Legacy: %{
        mages: getForSet(magesMap, "Legacy"),
        nemeses: getForSet(nemesesMap, "Legacy"),
        cards: getForSet(cardsMap, "Legacy")
      },
      BS: %{
        mages: getForSet(magesMap, "BS"),
        nemeses: getForSet(nemesesMap, "BS"),
        cards: getForSet(cardsMap, "BS")
      },
    }

    IO.inspect(resultMap)
  end
end

Parser.main()
