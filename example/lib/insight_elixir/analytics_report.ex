defmodule InsightElixir.AnalyticsReport do
  @moduledoc """
  This module handles the generation of reports
  """
  @constant_value 22
  def generate_report(:user_engagement, :weekly) do
    "user engagement report generated bajs"
  end

  def generate_report(:sales, :monthly) do
    "monthly sales reports"
  end

  def generate_report(:traffic, range = %{from: _, to: _}) do
    "traffic report generated for range #{inspect(range)}."
  end

  # generate report
  def generate_report do
    "default report generated."
  end

  # generate page view report
  def short_generate_report do
    "default report generated shorthand"
  end

  # generate peak traffic report
end
