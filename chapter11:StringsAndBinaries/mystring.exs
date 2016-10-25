defmodule MyString do
  # Write a function that returns true if a single-quoted string contains
  # only printable ASCII characters (space through tilde).
  def printable?(list1) do
    Enum.all?(list1, &(&1 in ?\s..?~))
  end

  # Write an anagram?(word1, word2) that returns true if its parameters are anagrams.
  def anagram?(word1, word2) do
    # my first implementation
    # length((word1 -- word2) ++ (word2 -- word1)) == 0
    # (word1 -- word2) ++ (word2 -- word1) == []

    # my re-implementation
    ( word1 |> Enum.sort ) == ( word2 |> Enum.sort )

    # I also like from the website:
    # Dave Thomas's solution:
    # def anagram(sqs1, sqs2), do: Enum.sort(sqs1) == Enum.sort(sqs2)

    # ( s1
    #   |> Kernel.to_string
    #   |> String.downcase
    #   |> Kernel.to_char_list
    #   |> Enum.sort
    # ) ===
    # ( s2
    #   |> Kernel.to_string
    #   |> String.downcase
    #   |> Kernel.to_char_list
    #   |> Enum.sort
    # )
  end
end
