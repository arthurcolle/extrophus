defmodule WordListTool do
  def run do
    {:ok, rawfile} = File.read "wordlist.txt"
    words = String.split rawfile, "\n"
    IO.inspect words
  end
end
