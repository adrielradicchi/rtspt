defmodule Rtspt.Stocks do
  @moduledoc """
  Módulo de domínio para ações (stocks) em memória.
  """

  @symbols ~w(AAPL TSLA MSFT AMZN)

  @doc """
  Lista todos os símbolos de ações disponíveis.
  """
  def list_symbols, do: @symbols

  @doc """
  Verifica se um símbolo é válido.
  """
  def valid_symbol?(symbol), do: symbol in @symbols
end
