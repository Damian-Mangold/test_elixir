defmodule GithubIssueCreator do
  @spec create_issue(any(), any(), any(), any(), any(), any()) ::
          {:error, <<_::64, _::_*8>>} | {:ok, any()}
  def create_issue(owner, repo, title, body, assignee, token) do
    # Configurar la solicitud con Req
    Req.post(
      "https://api.github.com/repos/#{owner}/#{repo}/issues",
      json: %{
        title: title,
        body: body,
        assignee: assignee
      },
      headers: [
        authorization: "Bearer #{token}",
        accept: "application/vnd.github+json"
      ]
    )
    |> handle_response()
  end

  defp handle_response({:ok, %Req.Response{status: 201, body: body}}) do
    {:ok, body} # Retorna los datos de la issue creada
  end

  defp handle_response({:ok, %Req.Response{status: status, body: body}}) do
    {:error, "Failed with status #{status}: #{inspect(body)}"}
  end

  defp handle_response({:error, reason}) do
    {:error, "Request failed: #{inspect(reason)}"}
  end
end
