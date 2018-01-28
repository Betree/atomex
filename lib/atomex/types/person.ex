defmodule Atomex.Types.Person do
  defstruct __children: %{
    name: "", uri: nil, email: nil
  }

  def new(name, params \\ []) do
    %Atomex.Types.Person{__children: %{name: name, uri: params[:uri], email: params[:email]}}
  end
end