defmodule TestElixir do
  require Logger
  require GithubIssueCreator

  @moduledoc """
  Documentation for `TestElixir`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TestElixir.hello()
      :world

  """
  def hello do
    :world
  end

  @spec create_github_issue() :: :ok
  def create_github_issue do
    # Take this information from a configuration file
    owner = "Damian-Mangold"
    repo = "test_elixir"
    title = "Test issue creation from elixir"
    body = "Issue automatically created from Elixir using Req."
    assignee = "Damian-Mangold"
    token = System.get_env("GITHUB_TOKEN")

    case GithubIssueCreator.create_issue(owner, repo, title, body, assignee, token) do
      {:ok, body} ->
        Logger.info("Issue created successfully: #{inspect(body)}")

      {:error, reason} ->
        Logger.error("Failed to create issue: #{reason}")
    end
  end
end
