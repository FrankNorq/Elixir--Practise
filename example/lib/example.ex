defmodule Example do
use Application
alias UUID
def start(_type,_args)do
Example.main()
Supervisor.start_link([], strategy: :one_for_one)
 end


def main do
# IO.puts("interpolation looks like \#{}")
a = 10
a = a + 5.0
b = 3.7
IO.puts(a+b)
end


end
