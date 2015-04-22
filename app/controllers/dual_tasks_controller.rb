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
    render :result
  end

  def result; end
end