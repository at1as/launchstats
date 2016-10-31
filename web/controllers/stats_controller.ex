defmodule Launchstats.StatsController do
  use Launchstats.Web, :controller
  alias Launchstats.Stats


  def index(conn, params) do
    today      = get_current_date |> format_date
    offset     = Map.get(params, "offset", 0)
    page_size  = Map.get(params, "page_size", 10)
    url_params = url_params_to_str(%{"offset" => offset, "startdate" => today, "limit" => page_size})
    
    url        = make_url(endpoint = "launch", params = url_params)
    response   = make_request(url)
    {launches, count, total} = extract_launch_body(response)
    
    render conn, "index.html", launches: launches, count: count, total: total, offset: offset, page_size: page_size, type: "upcoming"
  end

  def show(conn, %{"id" => id}) do
    url      = make_url("launch/#{id}?mode=verbose")
    response = make_request(url)
    
    {launches, _, _} = extract_launch_body(response)
    launch = List.first(launches)
    
    render conn, "show.html", launch: launch
  end

  def historical(conn, params) do
    today      = get_current_date |> format_date
    offset     = Map.get(params, "offset", 0)
    page_size  = Map.get(params, "page_size", 10) 

    url_params = url_params_to_str(%{"enddate": today, "mode": "verbose", "offset": offset, "limit": page_size})
    
    url        = make_url("launch", url_params)
    response   = make_request(url)

    {launches, count, total} = extract_launch_body(response)
   
    render conn, "index.html", launches: launches, count: count, total: total, offset: offset, page_size: page_size, type: "historical"
  end

  def search(conn, params) do
    offset     = Map.get(params, "offset", 0)
    page_size  = Map.get(params, "page_size", 10) 
    
    params_map = %{}
    params_map = add_params_to_map(params_map, "page_size", "limit")
    params_map = add_params_to_map(params_map, "start_date", "startdate")
    params_map = add_params_to_map(params_map, "end_date", "enddate")
    params_map = add_params_to_map(params_map, "sort", "sort")
    params_map = add_params_to_map(params_map, "name", "name")

    url_params = url_params_to_str(params_map)
    url        = make_url("launch", url_params)
    response   = make_request(url)

    {launches, count, total} = extract_launch_body(response)

    render conn, "index.html", launches: launches, count: count, total: total, offset: offset, page_size: page_size, type: "extended-search"
  end

  defp make_request(url) do
    HTTPotion.get url, headers: ["User-Agent": http_header]
  end

  defp make_url(endpoint \\ "", params \\ "") do
    base_url = "https://launchlibrary.net/1.2"
    endpoint = String.trim_leading(endpoint, "/") 
               |> String.trim_trailing("/")
    full_url = base_url <> "/" <> endpoint <> "?" <> params
               |> String.replace("/?", "?")
               |> String.trim_trailing("?")
  end

  defp url_params_to_str(params) do
    url_params = for {k, v} <- params, do: "#{k}=#{v}"
    Enum.join(url_params, "&")
  end

  defp add_params_to_map(params_as_map, name, name_in_api) do
    if Map.get(params_as_map, name) do
      Map.put(params_as_map, name_in_api, Map.get(params_as_map, name))
    else
      params_as_map
    end
  end

  defp http_header do
    http_header = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:49.0) Gecko/20100101 Firefox/49.0" 
  end

  defp extract_launch_body(response) do
    {_status, response_body} = response.body |> JSON.decode
    {response_body["launches"], response_body["count"], response_body["total"]}
  end

  defp get_current_date do
    :calendar.local_time() |> Tuple.to_list |> Enum.take(1) |> List.first
  end

  defp format_date({year, month, day}) do
    "#{year}-#{month}-#{day}"
  end
end
