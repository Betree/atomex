defmodule Atomex.Types.Link do
  defstruct href: "",
            rel: nil,
            type: nil,
            hreflang: nil,
            title: nil,
            length: nil

  def new(href, params \\ []) do
    %Atomex.Types.Link{
      href: href,
      rel: params[:rel],
      type: params[:type],
      hreflang: params[:hreflang],
      title: params[:title],
      length: params[:length]
    }
  end
end