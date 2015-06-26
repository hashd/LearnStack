defmodule Issues.GithubIssues do
  require Logger

  @user_agent [ {"User-agent", "Github client"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info "Fetching issues for user #{user}'s project #{project}"
    issues_url(user, project) |> HTTPoison.get(@user_agent) |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    Logger.info "Successful response"
    {:ok, body |> :jsx.decode }
  end
  
  def handle_response({:ok, %{status_code: status, body: body}}) do
    Logger.error "Error #{status} returned"
    {:error, body |> :jsx.decode }
  end
end