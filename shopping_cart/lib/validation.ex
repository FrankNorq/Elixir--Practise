defmodule Validation do
  def validate_required_fields(user_data) do
    required_fields = [:username, :email, :password]

    missing_fields =
      required_fields
      |> Enum.filter(fn field -> Map.get(user_data, field, nil) in [nil, ""] end)

    if missing_fields == [],
      do: {:ok, user_data},
      else: {:error, {missing_fields, missing_fields}}
  end

  def validate_email_format(email) do
    regex = ~r/^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$/
    if email =~ regex, do: {:ok, email}, else: {:error, :invalid_email}
  end

  def validate_age(age) do
    min_age = 18
    if age >= min_age, do: {:ok, age}, else: {:error, :age_not_valid}
  end

  def register_user(user_data) do
    with {:ok, _} <- validate_required_fields(user_data),
         {:ok, _} <- validate_email_format(user_data.email),
         {:ok, _} <- validate_age(user_data.age) do
      {:ok, "registration successfull"}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
