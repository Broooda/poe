class FifthController < ApplicationController
  def data; end

  def calculation
    @transport = Fifth.new(params)
    @transport.calculate
    #obliczenia
    #oblicznenia

    render :result
  end

  def result; end
end