class DualTasksController < ApplicationController
  def data; end

  def calculation
    @params = params
    hash = DualSimplex.uzupelnij(params)
    @sympleks_tab=[[],[],[],[],[],[],[]]
    @sympleks_tab=hash[:sympleks_tab]
    #binding.pry
    # puts @sympleks_tab.inspect
    # DualSimplex.transformation_to_one_in_cell(@sympleks_tab)
    # puts @sympleks_tab.inspect
    # DualSimplex.transformation_other_to_zero(@sympleks_tab)
    # puts @sympleks_tab.inspect
    @sympleks_tab=DualSimplex.all_in(@sympleks_tab)
    render :result
  end

  def result; end
end