defmodule Launchstats.StatsView do
  use Launchstats.Web, :view

  def is_greater(first, second) do
    make_int(first) > make_int(second)
  end

  def add_html_nums(first, second) do
    make_int(first) + make_int(second)
  end

  def prev_page(offset, pagesize) do
    previous_page = make_int(offset) - make_int(pagesize)
    if previous_page > 0, do: previous_page, else: 0
  end

  def next_page(offset, pagesize) do
    make_int(offset) + make_int(pagesize)
  end


  defp make_int(value) do
    cond do
      is_integer(value) ->
        value 
      is_float(value) ->
        Float.floor(value) |> round
      interpolated_int(value) ->
        interpolated_int(value)
      true ->
        0
    end
  end

  defp interpolated_int(str) do
    try do
      {int_val, _} = str |> String.trim |> Integer.parse
      int_val
    rescue _ ->
      false
    end
  end

end
