defmodule Example do
use Application
alias UUID
def start(_type,_args)do
Example.main()
Supervisor.start_link([], strategy: :one_for_one)
 end


def main do

name = "Frank"
status = Enum.random([:gold, :"not a member"])
 case status do
  :gold -> IO.puts("welcome to the fancy lounge, #{name}")
  :"not a member" -> IO.puts("lol get out ")
 _ -> IO.puts("get out skkrtboy")
end
end


end
