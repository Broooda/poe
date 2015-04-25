class DualTasksController < ApplicationController
  def data; end

  def calculation
    @params = params
    hash = DualSimplex.uzupelnij(params)
    @sympleks_tab=[[],[],[],[],[],[],[]]
    @sympleks_tab=hash[:sympleks_tab]
    #binding.pry
    render :result
  end

  def result; end
end