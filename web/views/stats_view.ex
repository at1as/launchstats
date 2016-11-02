defmodule Launchstats.StatsView do
  use Launchstats.Web, :view

  def is_greater(first, second) do
    make_int(first) > make_int(second)
  end

  def add_html_nums(first, second) do
    make_int(first) + make_int(second)
  end

  def pagination_description(offset, count, total) do
    # Return string like "1 to 10 out of 1033"
    offset = make_int(offset) || 0
    count  = make_int(count) || 0
    total  = make_int(total) || 0

    if offset > total, do: offset = total
    if total == 0 do
      "0"
    else
      "#{offset + 1} to #{offset + count} out of #{total}"
    end
  end

  def prev_page(offset, pagesize) do
    previous_page = make_int(offset) - make_int(pagesize)
    if previous_page > 0, do: previous_page, else: 0
  end

  def next_page(offset, pagesize) do
    make_int(offset) + make_int(pagesize)
  end

  def num_vals_equal(val1, val2) do
    make_int(val1) == make_int(val2)
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
