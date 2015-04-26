class DualTasksController < ApplicationController
  def data; end

  def calculation
    @params = params
    hash = DualSimplex.uzupelnij(params)
    @sympleks_tab=[[],[],[],[],[],[],[]]
    @sympleks_tab=hash[:sympleks_tab]
    
    # puts @sympleks_tab.inspect
    # DualSimplex.transformation_to_one_in_cell(@sympleks_tab)
    # puts @sympleks_tab.inspect
    # DualSimplex.transformation_other_to_zero(@sympleks_tab)
    # puts @sympleks_tab.inspect
    result_hash = DualSimplex.all_in(@sympleks_tab)
    @sympleks_tab = result_hash[:sympleks_tab]
    @step_by_step = result_hash[:step_by_step]
    @success = result_hash[:success]
    render :result
  end

  def result; end
end
