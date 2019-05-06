File.exists?(Path.expand("~/.iex.exs")) && import_file("~/.iex.exs")

alias CrowdReview.Repo
alias CrowdReview.Accounts
alias CrowdReview.Accounts.{ReviewRequest, User}
alias CrowdReview.Language
