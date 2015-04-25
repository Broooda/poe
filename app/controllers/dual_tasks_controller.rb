class DualTasksController < ApplicationController
  def data; end

  def calculation
    @params = params
    hash = DualSimplex.uzupelnij(params)
    @z = []
    @first = [[],[]]
    @second = [[],[]]
    @third = [[],[]]

    @z = hash[:z]
    @first = hash[:first]
    @second = hash[:second]
    @third = hash[:third]
    binding.pry
    render :result
  end

  def result; end
end