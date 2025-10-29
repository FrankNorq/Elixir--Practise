defmodule Example do
use Application
alias UUID
def start(_type,_args)do
Example.main()
Supervisor.start_link([], strategy: :one_for_one)
 end


def main do
time = DateTime.new!(Date.new!(2026,1,1),Time.new!(0,0,0,0), "Etc/UTC")
time_till = DateTime.diff(time,DateTime.utc_now())
IO.puts(time_till)
days = div(time_till , 86400)
IO.puts(days)
hours = div(rem(time_till,86_400),60 *60)
IO.puts(hours)
minutes = div(rem(time_till,60 *60),60)
IO.puts(minutes)
secounds = rem(time_till,60)
IO.puts(secounds)
IO.puts("Time until new year: #{days} days, #{hours} hours, #{minutes} minutes, #{secounds} secounds.")
end



end
