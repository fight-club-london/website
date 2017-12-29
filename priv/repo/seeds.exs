# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Lfc.Repo.insert!(%Lfc.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Lfc.{Repo}
alias Lfc.Accounts.{User}
alias Lfc.Main.{Fighter}

case Repo.get_by(User, first_name: "Admin") do
  nil ->
    Repo.insert! %User{
      first_name: "Admin",
      last_name: "User",
      email: System.get_env("ADMIN_EMAIL"),
      password: System.get_env("ADMIN_PASSWORD"),
      password_hash: Comeonin.Bcrypt.hashpwsalt(System.get_env("ADMIN_PASSWORD"))
    }
  _user -> IO.puts "Admin already in database"
end

# Repo.insert! %Fighter{
#   title: "Mr",
#   first_name: "John",
#   last_name: "Smith",
#   email: "johnsmith@email.com",
#   mobile_number: "07888444777",
#   location: "London",
#   occupation: "Accountant"
# }
# Repo.insert! %Fighter{
#   title: "Mr",
#   first_name: "John",
#   last_name: "Smith",
#   email: "johnsmith@email.com",
#   mobile_number: "07888444777",
#   location: "London",
#   occupation: "Accountant"
# }
# Repo.insert! %Fighter{
#   title: "Mr",
#   first_name: "John",
#   last_name: "Smith",
#   email: "johnsmith@email.com",
#   mobile_number: "07888444777",
#   location: "London",
#   occupation: "Accountant"
# }
# Repo.insert! %Fighter{
#   title: "Mr",
#   first_name: "John",
#   last_name: "Smith",
#   email: "johnsmith@email.com",
#   mobile_number: "07888444777",
#   location: "London",
#   occupation: "Accountant"
# }
