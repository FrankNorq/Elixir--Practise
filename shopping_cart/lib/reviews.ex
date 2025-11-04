defmodule Reviews do
  def get_reviews() do
    [
      %{rating: 5, text: "omeaga great", date: ~D[2024-01-02]},
      %{rating: 4, text: "great", date: ~D[2025-01-03]},
      %{rating: 3, text: "decent", date: ~D[2022-01-04]},
      %{rating: 2, text: "Almost shit", date: ~D[2021-01-01]},
      %{rating: 1, text: "Shit", date: ~D[2023-01-05]}
    ]
  end

  def get_ratings(reviews) do
    Enum.map(reviews, & &1.rating)
  end

  def get_avarage_ratings(reviews) do
    reviews
    |> Enum.map(fn review -> review.rating end)
    |> Enum.sum()
    |> divide_reviews(reviews)
  end

  defp divide_reviews(sum, reviews) do
    sum / length(reviews)
  end

  def filter_ratings(reviews, rating) do
    Enum.filter(reviews, fn review -> review.rating >= rating end)
  end

  def date_sorted(reviews) do
    Enum.sort_by(reviews, & &1.date, :desc)
  end
end
