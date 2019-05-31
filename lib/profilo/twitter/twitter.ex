defmodule Profilo.Twitter do
  # In order for this context to work the developer must
  # create a consumer_key and consumer_secret on twitter and add it to
  # Profilo/config/dev.secret.exs


  def get_timeline(%{oauth_token: nil, oauth_token_secret: nil} = nil_user), do: nil_user

  def get_timeline(curr_user) do
    set_config(curr_user)
    try do
      {:ok, ExTwitter.request(:get, "1.1/statuses/home_timeline.json")}
    rescue
      e in ExTwitter.ConnectionError -> {:error, e.message}
      e in ExTwitter.RateLimitExceededError -> {:error, e.message}
    end
  end

  defp set_config(curr_user) do
    ExTwitter.configure(:process, [
      consumer_key: Application.get_env(:profilo, :pow_assent)[:providers][:twitter][:consumer_key],
      consumer_secret: Application.get_env(:profilo, :pow_assent)[:providers][:twitter][:consumer_secret],
      access_token: curr_user.oauth_token,
      access_token_secret: curr_user.oauth_token_secret
    ])
  end
end
