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
    # or
    # (word1 -- word2) ++ (word2 -- word1) == []

    # my re-implementation
    ( word1 |> Enum.sort ) == ( word2 |> Enum.sort )

    # I also like from the website:
    # Dave Thomas's solution:
    # def anagram(sqs1, sqs2), do: Enum.sort(sqs1) == Enum.sort(sqs2)

    # Another solution from the website:
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

  # Write a function to capitalize the sentences in a string.
  #
  # Instead of embedding the String function calls into the
  # pipeline, I wrote wrapper functions that serve two purposes:
  # - to describe what they do
  # - hide the implementation in case it changes
  #
  # This is clearly the OO habits in me coming out perhaps unnecessarily
  # in this functional language. But I like how that main method reads then
  # and actually reads slightly more declaratively.
  def capitalize_sentences(str) do
    str
      |> split_into_sentences
      |> capitalize_each_sentence
      |> Enum.join(". ")
  end

  defp capitalize_each_sentence(sentences) do
    Enum.map( sentences, &String.capitalize(&1) )
  end

  defp split_into_sentences(str) do
    String.split(str, ". ")
  end
end
