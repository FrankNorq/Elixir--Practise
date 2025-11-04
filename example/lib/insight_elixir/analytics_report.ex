defmodule InsightElixir.AnalyticsReport do
  @moduledoc """
  This module handles the generation of reports
  """
  import InsightElixir.Utilities, only: [format_date: 1]
  alias Calculations.EngagementCalculator, as: Calc
  require InsightElixir.ReportMacros

  @constant_value 22
  def generate_report(:user_engagement, :weekly) do
    formatted_date = format_date(DateTime.utc_now())
    "user engagement weekly report for #{formatted_date}"
  end

  def generate_report(:sales, :monthly) do
    engagement_calc = Calc.calculate_engagement()
    "monthly sales reports generated with #{engagement_calc}"
  end

  def generate_report(:traffic, range = %{from: _, to: _}) do
    "traffic report generated for range #{inspect(range)}."
  end

  def generate_report(:user_engagement) do
    ReportMacros.log_report_generation(:user_engagement)
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
